import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../entites/academies_page_entity.dart';
import '../repositories/academies_repository.dart';

class AddFavoriteAcademyUseCase {
  final AcademiesRepository repository;

  AddFavoriteAcademyUseCase(this.repository);

  Future<Either<Failure, void>> call(int academyId) {
    return repository.addFavoriteAcademy(academyId);
  }
}

class RemoveFavoriteAcademyUseCase {
  final AcademiesRepository repository;

  RemoveFavoriteAcademyUseCase(this.repository);

  Future<Either<Failure, void>> call(int academyId) {
    return repository.removeFavoriteAcademy(academyId);
  }
}

class GetFavoriteAcademiesUseCase {
  final AcademiesRepository repository;

  GetFavoriteAcademiesUseCase(this.repository);

  Future<Either<Failure, AcademiesPageEntity>> call({
    int pageNumber = 1,
    int pageSize = 20,
  }) {
    return repository.getFavoriteAcademies(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
