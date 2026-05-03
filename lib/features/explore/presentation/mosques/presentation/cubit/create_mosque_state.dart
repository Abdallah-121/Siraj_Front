import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';

class CreateMosqueState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final MosqueEntity? createdMosque;

  const CreateMosqueState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
    required this.createdMosque,
  });

  factory CreateMosqueState.initial() {
    return const CreateMosqueState(
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
      createdMosque: null,
    );
  }

  CreateMosqueState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    MosqueEntity? createdMosque,
    bool clearError = false,
  }) {
    return CreateMosqueState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      createdMosque: createdMosque ?? this.createdMosque,
    );
  }
}
