import 'package:dartz/dartz.dart';
import 'package:seraj/features/teachers/domain/entites/mosque_teacher_entity.dart';
import 'package:seraj/features/teachers/domain/entites/promotion_user_entity.dart';
import 'package:seraj/features/teachers/domain/usecases/get_teachers_by_mosque_usecase.dart';

import '../../../../core/error/failures.dart';
import '../usecases/create_teacher_usecase.dart';
import '../usecases/promote_user_to_teacher_usecase.dart';
import '../usecases/search_users_for_promotion_usecase.dart';

abstract class TeacherPromotionRepository {
  Future<Either<Failure, List<PromotionUserEntity>>> searchUsersForPromotion(
    SearchUsersForPromotionParams params,
  );

  Future<Either<Failure, Unit>> promoteUserToTeacher(
    PromoteUserToTeacherParams params,
  );

  Future<Either<Failure, Unit>> createTeacher(CreateTeacherParams params);

  Future<Either<Failure, List<MosqueTeacherEntity>>> getTeachersByMosque(
    GetTeachersByMosqueParams params,
  );
}
