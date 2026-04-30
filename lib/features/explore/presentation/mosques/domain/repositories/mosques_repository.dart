import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosques_page_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/get_mosques_usecase.dart';

abstract class MosquesRepository {
  Future<Either<Failure, MosquesPageEntity>> getMosques(
    GetMosquesParams params,
  );
}
