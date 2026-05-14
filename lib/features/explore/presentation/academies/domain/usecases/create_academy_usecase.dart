import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../entites/academy_entity.dart';
import '../repositories/academies_repository.dart';

class CreateAcademyUseCase {
  final AcademiesRepository repository;

  CreateAcademyUseCase(this.repository);

  Future<Either<Failure, AcademyEntity>> call(CreateAcademyParams params) {
    return repository.createAcademy(params);
  }
}

class CreateAcademyParams {
  final String platformUrl;
  final int regionId;
  final String name;
  final String specialization;
  final String description;
  final bool isRegistrationOpen;
  final String phoneNumber;
  final List<int> categoryIds;

  const CreateAcademyParams({
    required this.platformUrl,
    required this.regionId,
    required this.name,
    required this.specialization,
    required this.description,
    required this.isRegistrationOpen,
    required this.phoneNumber,
    required this.categoryIds,
  });
}
