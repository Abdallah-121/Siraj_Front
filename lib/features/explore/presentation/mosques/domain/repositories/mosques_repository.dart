import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosques_page_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/create_mosque_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/get_mosques_usecase.dart';

abstract class MosquesRepository {
  Future<Either<Failure, MosquesPageEntity>> getMosques(
    GetMosquesParams params,
  );

  Future<Either<Failure, MosqueEntity>> createMosque(CreateMosqueParams params);

  Future<Either<Failure, String>> uploadMosqueImage({
    required int mosqueId,
    required File image,
  });

  Future<Either<Failure, Unit>> addMosqueToFavorites(int mosqueId);

  Future<Either<Failure, Unit>> removeMosqueFromFavorites(int mosqueId);

  Future<Either<Failure, MosquesPageEntity>> getFavoriteMosques({
    required int pageNumber,
    required int pageSize,
  });
}
