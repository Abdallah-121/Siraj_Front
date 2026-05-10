import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/create_academy_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/delete_academy_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/update_academy_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/upload_academy_image_usecase.dart';

import 'manage_academy_state.dart';

class ManageAcademyCubit extends Cubit<ManageAcademyState> {
  final CreateAcademyUseCase createAcademyUseCase;
  final UpdateAcademyUseCase updateAcademyUseCase;
  final DeleteAcademyUseCase deleteAcademyUseCase;
  final UploadAcademyImageUseCase uploadAcademyImageUseCase;

  ManageAcademyCubit({
    required this.createAcademyUseCase,
    required this.updateAcademyUseCase,
    required this.deleteAcademyUseCase,
    required this.uploadAcademyImageUseCase,
  }) : super(ManageAcademyState.initial());

  void _safeEmit(ManageAcademyState newState) {
    if (!isClosed) emit(newState);
  }

  Future<void> createAcademy({
    required String platformUrl,
    required int regionId,
    required String name,
    required String specialization,
    required String description,
    required String phoneNumber,
    required List<int> categoryIds,
    File? image,
  }) async {
    _safeEmit(
      state.copyWith(isSubmitting: true, clearError: true, clearSuccess: true),
    );

    final result = await createAcademyUseCase(
      CreateAcademyParams(
        platformUrl: platformUrl,
        regionId: regionId,
        name: name,
        specialization: specialization,
        description: description,
        isRegistrationOpen: false,
        phoneNumber: phoneNumber,
        categoryIds: categoryIds,
      ),
    );

    if (isClosed) return;

    await result.fold(
      (failure) async {
        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (academy) async {
        String? uploadedUrl;

        if (image != null) {
          final uploadResult = await uploadAcademyImageUseCase(
            academyId: academy.id,
            image: image,
          );

          if (isClosed) return;

          uploadResult.fold(
            (failure) {
              _safeEmit(
                state.copyWith(
                  isSubmitting: false,
                  academy: academy,
                  successAction: ManageAcademyActionType.created,
                  errorMessage: ErrorMapper.mapFailureToMessage(failure),
                ),
              );
            },
            (imageUrl) {
              uploadedUrl = imageUrl;
            },
          );
        }

        if (isClosed) return;

        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            academy: uploadedUrl == null
                ? academy
                : academy.copyWith(imageUrl: uploadedUrl),
            uploadedImageUrl: uploadedUrl,
            successAction: ManageAcademyActionType.created,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> updateAcademy({
    required int academyId,
    required String platformUrl,
    required int regionId,
    required String name,
    required String specialization,
    required String description,
    required String phoneNumber,
    required List<int> categoryIds,
    File? image,
  }) async {
    _safeEmit(
      state.copyWith(isSubmitting: true, clearError: true, clearSuccess: true),
    );

    final result = await updateAcademyUseCase(
      UpdateAcademyParams(
        academyId: academyId,
        platformUrl: platformUrl,
        regionId: regionId,
        name: name,
        specialization: specialization,
        description: description,
        isRegistrationOpen: false,
        phoneNumber: phoneNumber,
        categoryIds: categoryIds,
      ),
    );

    if (isClosed) return;

    await result.fold(
      (failure) async {
        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (academy) async {
        String? uploadedUrl;

        if (image != null) {
          final uploadResult = await uploadAcademyImageUseCase(
            academyId: academy.id,
            image: image,
          );

          if (isClosed) return;

          uploadResult.fold(
            (failure) {
              _safeEmit(
                state.copyWith(
                  isSubmitting: false,
                  academy: academy,
                  successAction: ManageAcademyActionType.updated,
                  errorMessage: ErrorMapper.mapFailureToMessage(failure),
                ),
              );
            },
            (imageUrl) {
              uploadedUrl = imageUrl;
            },
          );
        }

        if (isClosed) return;

        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            academy: uploadedUrl == null
                ? academy
                : academy.copyWith(imageUrl: uploadedUrl),
            uploadedImageUrl: uploadedUrl,
            successAction: ManageAcademyActionType.updated,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> deleteAcademy(int academyId) async {
    _safeEmit(
      state.copyWith(isSubmitting: true, clearError: true, clearSuccess: true),
    );

    final result = await deleteAcademyUseCase(academyId);

    if (isClosed) return;

    result.fold(
      (failure) {
        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            successAction: ManageAcademyActionType.deleted,
            clearError: true,
          ),
        );
      },
    );
  }

  void clearMessages() {
    _safeEmit(state.copyWith(clearError: true, clearSuccess: true));
  }
}
