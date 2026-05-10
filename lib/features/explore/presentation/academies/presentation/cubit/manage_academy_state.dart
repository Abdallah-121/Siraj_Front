import '../../domain/entites/academy_entity.dart';

enum ManageAcademyActionType { created, updated, deleted }

class ManageAcademyState {
  final bool isSubmitting;
  final AcademyEntity? academy;
  final ManageAcademyActionType? successAction;
  final String? uploadedImageUrl;
  final String? errorMessage;

  const ManageAcademyState({
    required this.isSubmitting,
    required this.academy,
    required this.successAction,
    required this.uploadedImageUrl,
    required this.errorMessage,
  });

  factory ManageAcademyState.initial() {
    return const ManageAcademyState(
      isSubmitting: false,
      academy: null,
      successAction: null,
      uploadedImageUrl: null,
      errorMessage: null,
    );
  }

  ManageAcademyState copyWith({
    bool? isSubmitting,
    AcademyEntity? academy,
    ManageAcademyActionType? successAction,
    String? uploadedImageUrl,
    String? errorMessage,
    bool clearSuccess = false,
    bool clearError = false,
  }) {
    return ManageAcademyState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      academy: academy ?? this.academy,
      successAction: clearSuccess ? null : successAction ?? this.successAction,
      uploadedImageUrl: uploadedImageUrl ?? this.uploadedImageUrl,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
