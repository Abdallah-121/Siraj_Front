import 'package:seraj/features/teachers/domain/entites/mosque_teacher_entity.dart';

class MosqueTeachersState {
  final bool isLoading;
  final List<MosqueTeacherEntity> teachers;
  final String? errorMessage;

  const MosqueTeachersState({
    required this.isLoading,
    required this.teachers,
    required this.errorMessage,
  });

  factory MosqueTeachersState.initial() {
    return const MosqueTeachersState(
      isLoading: false,
      teachers: [],
      errorMessage: null,
    );
  }

  MosqueTeachersState copyWith({
    bool? isLoading,
    List<MosqueTeacherEntity>? teachers,
    String? errorMessage,
    bool clearError = false,
  }) {
    return MosqueTeachersState(
      isLoading: isLoading ?? this.isLoading,
      teachers: teachers ?? this.teachers,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
