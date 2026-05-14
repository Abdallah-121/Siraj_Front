import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../repositories/mosques_repository.dart';

class RemoveMosqueFromFavoritesUseCase {
  final MosquesRepository repository;

  const RemoveMosqueFromFavoritesUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int mosqueId) {
    return repository.removeMosqueFromFavorites(mosqueId);
  }
}
