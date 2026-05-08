import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/auth_session_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  const UpdateProfileUseCase(this.repository);

  Future<Either<Failure, AuthSessionEntity>> call(UpdateProfileParams params) {
    return repository.updateProfile(params);
  }
}

class UpdateProfileParams {
  final String userId;
  final String token;
  final int roleId;
  final String roleName;
  final int? teacherId;

  final int cityId;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String profileImage;
  final String description;
  final DateTime birthDate;

  const UpdateProfileParams({
    required this.userId,
    required this.token,
    required this.roleId,
    required this.roleName,
    required this.teacherId,
    required this.cityId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.profileImage,
    required this.description,
    required this.birthDate,
  });
}
