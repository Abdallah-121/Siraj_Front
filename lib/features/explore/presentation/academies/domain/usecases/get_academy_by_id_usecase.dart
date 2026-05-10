import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../entites/academy_entity.dart';
import '../repositories/academies_repository.dart';

class GetAcademyByIdUseCase {
  final AcademiesRepository repository;

  GetAcademyByIdUseCase(this.repository);

  Future<Either<Failure, AcademyEntity>> call(int academyId) {
    return repository.getAcademyById(academyId);
  }
}
