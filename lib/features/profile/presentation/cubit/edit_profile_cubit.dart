import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/profile/domain/usecase/update_profile_usecase.dart';

import '../../../../core/error/error_mapper.dart';
import '../../../auth/domain/entities/auth_session_entity.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;

  EditProfileCubit(this.updateProfileUseCase)
    : super(EditProfileState.initial());

  Future<void> updateProfile({
    required AuthSessionEntity session,
    required int cityId,
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String profileImage,
    required String description,
    required DateTime birthDate,
  }) async {
    emit(
      state.copyWith(isSubmitting: true, isSuccess: false, clearError: true),
    );

    final result = await updateProfileUseCase(
      UpdateProfileParams(
        userId: session.userId,
        token: session.token,
        roleId: session.roleId,
        roleName: session.roleName,
        teacherId: session.teacherId,
        cityId: cityId,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        profileImage: profileImage,
        description: description,
        birthDate: birthDate,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (updatedSession) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            updatedSession: updatedSession,
            clearError: true,
          ),
        );
      },
    );
  }
}
