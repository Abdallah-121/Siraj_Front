import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/exceptions.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosques_page_entity.dart';

import '../../domain/repositories/mosques_repository.dart';
import '../../domain/usecases/get_mosques_usecase.dart';
import '../datasources/mosques_remote_data_source.dart';

class MosquesRepositoryImpl implements MosquesRepository {
  final MosquesRemoteDataSource remoteDataSource;

  MosquesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, MosquesPageEntity>> getMosques(
    GetMosquesParams params,
  ) async {
    try {
      final result = await remoteDataSource.getMosques(params);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }
}
