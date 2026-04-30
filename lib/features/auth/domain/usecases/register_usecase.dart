import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_session_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, AuthSessionEntity>> call(RegisterParams params) {
    return repository.register(params);
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final int cityId;
  final String phone;
  final String description;
  final DateTime? birthDate;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.cityId,
    required this.phone,
    required this.description,
    required this.birthDate,
  });
}
