import 'package:seraj/features/auth/domain/entities/auth_session_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/teachers/domain/entites/mosque_teacher_entity.dart';

abstract final class MosquePermissionResolver {
  static bool canPromoteTeacher({
    required AuthSessionEntity? session,
    required MosqueEntity mosque,
  }) {
    if (session == null) return false;

    if (_isAdmin(session)) return true;

    if (_isMosqueManager(session)) {
      return _isManagerOfMosque(session: session, mosque: mosque);
    }

    return false;
  }

  static bool canCreateLesson({
    required AuthSessionEntity? session,
    required MosqueEntity mosque,
    required List<MosqueTeacherEntity> mosqueTeachers,
  }) {
    if (session == null) return false;

    if (_isAdmin(session)) return true;

    if (_isMosqueManager(session)) {
      return _isManagerOfMosque(session: session, mosque: mosque);
    }

    if (_isTeacher(session)) {
      return _isTeacherOfMosque(
        session: session,
        mosqueTeachers: mosqueTeachers,
      );
    }

    return false;
  }

  static bool _isAdmin(AuthSessionEntity session) {
    return session.roleName.trim().toLowerCase() == 'admin';
  }

  static bool _isMosqueManager(AuthSessionEntity session) {
    return session.roleName.trim().toLowerCase() == 'mosquemanager';
  }

  static bool _isTeacher(AuthSessionEntity session) {
    return session.roleName.trim().toLowerCase() == 'teacher';
  }

  static bool _isManagerOfMosque({
    required AuthSessionEntity session,
    required MosqueEntity mosque,
  }) {
    final String? managerUserId = mosque.managerUserId?.trim().toLowerCase();
    final String currentUserId = session.userId.trim().toLowerCase();

    return managerUserId != null &&
        managerUserId.isNotEmpty &&
        managerUserId == currentUserId;
  }

  static bool _isTeacherOfMosque({
    required AuthSessionEntity session,
    required List<MosqueTeacherEntity> mosqueTeachers,
  }) {
    final String currentUserId = session.userId.trim().toLowerCase();
    final int? currentTeacherId = session.teacherId;

    return mosqueTeachers.any((teacher) {
      final bool sameUser =
          teacher.userId.trim().toLowerCase() == currentUserId;

      final bool sameTeacherId =
          currentTeacherId != null && teacher.teacherId == currentTeacherId;

      return teacher.isActive &&
          teacher.isVerified &&
          teacher.hasPermission &&
          (sameUser || sameTeacherId);
    });
  }
}
