import '../../domain/usecases/get_cities_usecase.dart';
import '../models/cities_page_model.dart';

abstract class LocationRemoteDataSource {
  Future<CitiesPageModel> getCities(GetCitiesParams params);
}
