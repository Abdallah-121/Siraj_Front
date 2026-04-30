import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/exceptions.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academies_page_entity.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';

import '../../domain/repositories/academies_repository.dart';
import '../datasources/academies_remote_data_source.dart';

class AcademiesRepositoryImpl implements AcademiesRepository {
  final AcademiesRemoteDataSource remoteDataSource;

  AcademiesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AcademiesPageEntity>> getAcademies(
    GetAcademiesParams params,
  ) async {
    try {
      final result = await remoteDataSource.getAcademies(params);
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
