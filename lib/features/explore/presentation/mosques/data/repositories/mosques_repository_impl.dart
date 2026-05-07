import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/exceptions.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/mosques/data/models/create_mosque_request_model.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosques_page_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/create_mosque_usecase.dart';

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

  @override
  Future<Either<Failure, MosqueEntity>> createMosque(
    CreateMosqueParams params,
  ) async {
    try {
      final result = await remoteDataSource.createMosque(
        CreateMosqueRequestModel(
          regionId: params.regionId,
          name: params.name,
          imamName: params.imamName,
          khatibName: params.khatibName,
          address: params.address,
          phoneNumber: params.phoneNumber,
          latitude: params.latitude,
          longitude: params.longitude,
          timezone: params.timezone,
          calculationMethod: params.calculationMethod,
          madhab: params.madhab,
          imageUrl: params.imageUrl,
        ),
      );

      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> uploadMosqueImage({
    required int mosqueId,
    required File image,
  }) async {
    try {
      final result = await remoteDataSource.uploadMosqueImage(
        mosqueId: mosqueId,
        image: image,
      );

      return Right(result.imageUrl);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }
}
