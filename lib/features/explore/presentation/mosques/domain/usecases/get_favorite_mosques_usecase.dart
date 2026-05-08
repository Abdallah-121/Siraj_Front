import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../entites/mosques_page_entity.dart';
import '../repositories/mosques_repository.dart';

class GetFavoriteMosquesUseCase {
  final MosquesRepository repository;

  const GetFavoriteMosquesUseCase(this.repository);

  Future<Either<Failure, MosquesPageEntity>> call(
    GetFavoriteMosquesParams params,
  ) {
    return repository.getFavoriteMosques(
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

class GetFavoriteMosquesParams {
  final int pageNumber;
  final int pageSize;

  const GetFavoriteMosquesParams({this.pageNumber = 1, this.pageSize = 20});
}
