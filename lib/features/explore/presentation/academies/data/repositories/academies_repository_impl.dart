import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/exceptions.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/academies/data/models/create_update_academy_request_model.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academies_page_entity.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academy_entity.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/create_academy_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/update_academy_usecase.dart';

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
      return Right(await remoteDataSource.getAcademies(params));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AcademyEntity>> getAcademyById(int academyId) async {
    try {
      return Right(await remoteDataSource.getAcademyById(academyId));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AcademiesPageEntity>> getAcademiesByLocation({
    int? regionId,
    int? cityId,
    int? excludeRegionId,
    bool? isActive,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    try {
      return Right(
        await remoteDataSource.getAcademiesByLocation(
          regionId: regionId,
          cityId: cityId,
          excludeRegionId: excludeRegionId,
          isActive: isActive,
          pageNumber: pageNumber,
          pageSize: pageSize,
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AcademyEntity>> createAcademy(
    CreateAcademyParams params,
  ) async {
    try {
      return Right(
        await remoteDataSource.createAcademy(
          CreateUpdateAcademyRequestModel(
            platformUrl: params.platformUrl,
            regionId: params.regionId,
            name: params.name,
            specialization: params.specialization,
            description: params.description,
            isRegistrationOpen: params.isRegistrationOpen,
            phoneNumber: params.phoneNumber,
            categoryIds: params.categoryIds,
          ),
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AcademyEntity>> updateAcademy(
    UpdateAcademyParams params,
  ) async {
    try {
      return Right(
        await remoteDataSource.updateAcademy(
          academyId: params.academyId,
          request: CreateUpdateAcademyRequestModel(
            platformUrl: params.platformUrl,
            regionId: params.regionId,
            name: params.name,
            specialization: params.specialization,
            description: params.description,
            isRegistrationOpen: params.isRegistrationOpen,
            phoneNumber: params.phoneNumber,
            categoryIds: params.categoryIds,
          ),
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAcademy(int academyId) async {
    try {
      await remoteDataSource.deleteAcademy(academyId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> uploadAcademyImage({
    required int academyId,
    required File image,
  }) async {
    try {
      final result = await remoteDataSource.uploadAcademyImage(
        academyId: academyId,
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

  @override
  Future<Either<Failure, void>> addFavoriteAcademy(int academyId) async {
    try {
      await remoteDataSource.addFavoriteAcademy(academyId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteAcademy(int academyId) async {
    try {
      await remoteDataSource.removeFavoriteAcademy(academyId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AcademiesPageEntity>> getFavoriteAcademies({
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    try {
      return Right(
        await remoteDataSource.getFavoriteAcademies(
          pageNumber: pageNumber,
          pageSize: pageSize,
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }
}
