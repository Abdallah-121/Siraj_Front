import 'package:dartz/dartz.dart';
import 'package:seraj/features/teachers/domain/entites/promotion_user_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/teacher_promotion_repository.dart';

class SearchUsersForPromotionUseCase {
  final TeacherPromotionRepository repository;

  const SearchUsersForPromotionUseCase(this.repository);

  Future<Either<Failure, List<PromotionUserEntity>>> call(
    SearchUsersForPromotionParams params,
  ) {
    return repository.searchUsersForPromotion(params);
  }
}

class SearchUsersForPromotionParams {
  final String search;
  final int maxResults;

  const SearchUsersForPromotionParams({
    required this.search,
    this.maxResults = 10,
  });
}
