import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/teacher_promotion_repository.dart';

class CreateTeacherUseCase {
  final TeacherPromotionRepository repository;

  const CreateTeacherUseCase(this.repository);

  Future<Either<Failure, Unit>> call(CreateTeacherParams params) {
    return repository.createTeacher(params);
  }
}

class CreateTeacherParams {
  final int mosqueId;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String qualification;
  final String bio;

  const CreateTeacherParams({
    required this.mosqueId,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.qualification,
    required this.bio,
  });
}
