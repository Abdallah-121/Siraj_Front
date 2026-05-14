import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../repositories/mosques_repository.dart';

class AddMosqueToFavoritesUseCase {
  final MosquesRepository repository;

  const AddMosqueToFavoritesUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int mosqueId) {
    return repository.addMosqueToFavorites(mosqueId);
  }
}
