import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../repositories/academies_repository.dart';

class DeleteAcademyUseCase {
  final AcademiesRepository repository;

  DeleteAcademyUseCase(this.repository);

  Future<Either<Failure, void>> call(int academyId) {
    return repository.deleteAcademy(academyId);
  }
}
