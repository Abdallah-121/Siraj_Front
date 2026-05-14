import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';

class MosquesState {
  final bool isLoading;
  final List<MosqueEntity> mosques;
  final String? errorMessage;
  final String searchQuery;

  const MosquesState({
    required this.isLoading,
    required this.mosques,
    required this.errorMessage,
    required this.searchQuery,
  });

  factory MosquesState.initial() {
    return const MosquesState(
      isLoading: false,
      mosques: [],
      errorMessage: null,
      searchQuery: '',
    );
  }

  MosquesState copyWith({
    bool? isLoading,
    List<MosqueEntity>? mosques,
    String? errorMessage,
    String? searchQuery,
    bool clearError = false,
  }) {
    return MosquesState(
      isLoading: isLoading ?? this.isLoading,
      mosques: mosques ?? this.mosques,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
