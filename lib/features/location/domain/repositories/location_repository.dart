import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cities_page_entity.dart';
import '../usecases/get_cities_usecase.dart';

abstract class LocationRepository {
  Future<Either<Failure, CitiesPageEntity>> getCities(GetCitiesParams params);
}
