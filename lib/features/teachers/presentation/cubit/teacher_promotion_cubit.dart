import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/teachers/domain/entites/promotion_user_entity.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/usecases/create_teacher_usecase.dart';
import '../../domain/usecases/promote_user_to_teacher_usecase.dart';
import '../../domain/usecases/search_users_for_promotion_usecase.dart';
import 'teacher_promotion_state.dart';

class TeacherPromotionCubit extends Cubit<TeacherPromotionState> {
  final SearchUsersForPromotionUseCase searchUsersForPromotionUseCase;
  final PromoteUserToTeacherUseCase promoteUserToTeacherUseCase;
  final CreateTeacherUseCase createTeacherUseCase;

  TeacherPromotionCubit({
    required this.searchUsersForPromotionUseCase,
    required this.promoteUserToTeacherUseCase,
    required this.createTeacherUseCase,
  }) : super(TeacherPromotionState.initial());

  Future<void> searchUsers(String query) async {
    final normalizedQuery = query.trim();

    emit(
      state.copyWith(
        searchQuery: normalizedQuery,
        isSuccess: false,
        clearError: true,
        clearSelectedUser: true,
      ),
    );

    if (normalizedQuery.length < 2) {
      emit(
        state.copyWith(isSearching: false, users: [], clearSelectedUser: true),
      );
      return;
    }

    emit(state.copyWith(isSearching: true, users: []));

    final result = await searchUsersForPromotionUseCase(
      SearchUsersForPromotionParams(search: normalizedQuery, maxResults: 10),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isSearching: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (users) {
        emit(
          state.copyWith(isSearching: false, users: users, clearError: true),
        );
      },
    );
  }

  void selectUser(PromotionUserEntity user) {
    emit(
      state.copyWith(selectedUser: user, clearError: true, isSuccess: false),
    );
  }

  void showCreateTeacherForm() {
    emit(
      state.copyWith(
        mode: TeacherPromotionMode.create,
        clearSelectedUser: true,
        clearError: true,
        isSuccess: false,
      ),
    );
  }

  void showSearchForm() {
    emit(
      state.copyWith(
        mode: TeacherPromotionMode.search,
        clearError: true,
        isSuccess: false,
      ),
    );
  }

  Future<void> promoteSelectedUser({
    required int mosqueId,
    required String qualification,
    required String bio,
  }) async {
    final user = state.selectedUser;
    if (user == null) return;

    emit(
      state.copyWith(isSubmitting: true, isSuccess: false, clearError: true),
    );

    final result = await promoteUserToTeacherUseCase(
      PromoteUserToTeacherParams(
        userId: user.userId,
        mosqueId: mosqueId,
        qualification: qualification.trim(),
        bio: bio.trim(),
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
      (_) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> createTeacher({
    required int mosqueId,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String qualification,
    required String bio,
  }) async {
    emit(
      state.copyWith(isSubmitting: true, isSuccess: false, clearError: true),
    );

    final result = await createTeacherUseCase(
      CreateTeacherParams(
        mosqueId: mosqueId,
        email: email.trim(),
        password: password,
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        qualification: qualification.trim(),
        bio: bio.trim(),
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
      (_) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            clearError: true,
          ),
        );
      },
    );
  }
}
