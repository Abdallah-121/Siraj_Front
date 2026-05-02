import '../../../auth/domain/entities/auth_session_entity.dart';
import '../../../explore/presentation/mosques/domain/entites/mosque_entity.dart';
import '../entities/lesson_entity.dart';

abstract final class LessonPermissionHelper {
  static const int adminRoleId = 1;
  static const int mosqueManagerRoleId = 2;
  static const int teacherRoleId = 3;

  static bool canCreateLesson({
    required AuthSessionEntity session,
    required MosqueEntity mosque,
    required List<LessonEntity> mosqueLessons,
  }) {
    if (session.roleId == adminRoleId) {
      return true;
    }

    if (session.roleId == mosqueManagerRoleId) {
      return mosque.managerUserId == session.userId;
    }

    if (session.roleId == teacherRoleId) {
      final int? teacherId = session.teacherId;
      if (teacherId == null) return false;

      return mosqueLessons.any((lesson) => lesson.teacherId == teacherId);
    }

    return false;
  }
}
