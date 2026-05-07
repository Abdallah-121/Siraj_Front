import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';

import '../../domain/usecases/create_mosque_usecase.dart';
import '../../domain/usecases/upload_mosque_image_usecase.dart';
import 'create_mosque_state.dart';

class CreateMosqueCubit extends Cubit<CreateMosqueState> {
  final CreateMosqueUseCase createMosqueUseCase;
  final UploadMosqueImageUseCase uploadMosqueImageUseCase;

  CreateMosqueCubit(this.createMosqueUseCase, this.uploadMosqueImageUseCase)
    : super(CreateMosqueState.initial());

  Future<void> createMosque({
    required int regionId,
    required String name,
    required String imamName,
    required String khatibName,
    required String address,
    required String phoneNumber,
    required double latitude,
    required double longitude,
    required String timezone,
    required int calculationMethod,
    required int madhab,
    File? image,
  }) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, clearError: true));

    final createResult = await createMosqueUseCase(
      CreateMosqueParams(
        regionId: regionId,
        name: name,
        imamName: imamName,
        khatibName: khatibName,
        address: address,
        phoneNumber: phoneNumber,
        latitude: latitude,
        longitude: longitude,
        timezone: timezone,
        calculationMethod: calculationMethod,
        madhab: madhab,
        imageUrl: null,
      ),
    );

    await createResult.fold(
      (failure) async {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (mosque) async {
        if (image != null) {
          final uploadResult = await uploadMosqueImageUseCase(
            UploadMosqueImageParams(mosqueId: mosque.id, image: image),
          );

          uploadResult.fold(
            (failure) {
              emit(
                state.copyWith(
                  isLoading: false,
                  isSuccess: false,
                  errorMessage: ErrorMapper.mapFailureToMessage(failure),
                  createdMosque: mosque,
                ),
              );
            },
            (_) {
              emit(
                state.copyWith(
                  isLoading: false,
                  isSuccess: true,
                  createdMosque: mosque,
                  clearError: true,
                ),
              );
            },
          );

          return;
        }

        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            createdMosque: mosque,
            clearError: true,
          ),
        );
      },
    );
  }
}
