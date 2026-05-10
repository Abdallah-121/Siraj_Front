import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/create_academy_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/update_academy_usecase.dart';
import '../entites/academies_page_entity.dart';
import '../entites/academy_entity.dart';
import '../usecases/get_academies_usecase.dart.dart';

abstract class AcademiesRepository {
  Future<Either<Failure, AcademiesPageEntity>> getAcademies(
    GetAcademiesParams params,
  );

  Future<Either<Failure, AcademyEntity>> getAcademyById(int academyId);

  Future<Either<Failure, AcademiesPageEntity>> getAcademiesByLocation({
    int? regionId,
    int? cityId,
    int? excludeRegionId,
    bool? isActive,
    int pageNumber = 1,
    int pageSize = 20,
  });

  Future<Either<Failure, AcademyEntity>> createAcademy(
    CreateAcademyParams params,
  );

  Future<Either<Failure, AcademyEntity>> updateAcademy(
    UpdateAcademyParams params,
  );

  Future<Either<Failure, void>> deleteAcademy(int academyId);

  Future<Either<Failure, String>> uploadAcademyImage({
    required int academyId,
    required File image,
  });

  Future<Either<Failure, void>> addFavoriteAcademy(int academyId);

  Future<Either<Failure, void>> removeFavoriteAcademy(int academyId);

  Future<Either<Failure, AcademiesPageEntity>> getFavoriteAcademies({
    int pageNumber = 1,
    int pageSize = 20,
  });
}
