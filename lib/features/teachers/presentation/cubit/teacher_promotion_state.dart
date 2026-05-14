import 'package:seraj/features/teachers/domain/entites/promotion_user_entity.dart';

enum TeacherPromotionMode { search, create }

class TeacherPromotionState {
  final TeacherPromotionMode mode;
  final bool isSearching;
  final bool isSubmitting;
  final List<PromotionUserEntity> users;
  final PromotionUserEntity? selectedUser;
  final String searchQuery;
  final String? errorMessage;
  final bool isSuccess;

  const TeacherPromotionState({
    required this.mode,
    required this.isSearching,
    required this.isSubmitting,
    required this.users,
    required this.selectedUser,
    required this.searchQuery,
    required this.errorMessage,
    required this.isSuccess,
  });

  factory TeacherPromotionState.initial() {
    return const TeacherPromotionState(
      mode: TeacherPromotionMode.search,
      isSearching: false,
      isSubmitting: false,
      users: [],
      selectedUser: null,
      searchQuery: '',
      errorMessage: null,
      isSuccess: false,
    );
  }

  bool get hasSearched => searchQuery.trim().isNotEmpty;

  TeacherPromotionState copyWith({
    TeacherPromotionMode? mode,
    bool? isSearching,
    bool? isSubmitting,
    List<PromotionUserEntity>? users,
    PromotionUserEntity? selectedUser,
    String? searchQuery,
    String? errorMessage,
    bool? isSuccess,
    bool clearSelectedUser = false,
    bool clearError = false,
  }) {
    return TeacherPromotionState(
      mode: mode ?? this.mode,
      isSearching: isSearching ?? this.isSearching,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      users: users ?? this.users,
      selectedUser: clearSelectedUser
          ? null
          : selectedUser ?? this.selectedUser,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
