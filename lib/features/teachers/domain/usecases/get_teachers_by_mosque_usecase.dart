import 'package:dartz/dartz.dart';
import 'package:seraj/features/teachers/domain/entites/mosque_teacher_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/teacher_promotion_repository.dart';

class GetTeachersByMosqueUseCase {
  final TeacherPromotionRepository repository;

  const GetTeachersByMosqueUseCase(this.repository);

  Future<Either<Failure, List<MosqueTeacherEntity>>> call(
    GetTeachersByMosqueParams params,
  ) {
    return repository.getTeachersByMosque(params);
  }
}

class GetTeachersByMosqueParams {
  final int mosqueId;

  const GetTeachersByMosqueParams({required this.mosqueId});
}
