import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/teacher_promotion_repository.dart';

class PromoteUserToTeacherUseCase {
  final TeacherPromotionRepository repository;

  const PromoteUserToTeacherUseCase(this.repository);

  Future<Either<Failure, Unit>> call(PromoteUserToTeacherParams params) {
    return repository.promoteUserToTeacher(params);
  }
}

class PromoteUserToTeacherParams {
  final String userId;
  final int mosqueId;
  final String qualification;
  final String bio;

  const PromoteUserToTeacherParams({
    required this.userId,
    required this.mosqueId,
    required this.qualification,
    required this.bio,
  });
}
