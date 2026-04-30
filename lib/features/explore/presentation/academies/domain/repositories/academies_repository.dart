import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academies_page_entity.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';

abstract class AcademiesRepository {
  Future<Either<Failure, AcademiesPageEntity>> getAcademies(
    GetAcademiesParams params,
  );
}
