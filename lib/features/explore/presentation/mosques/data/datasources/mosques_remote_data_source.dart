import '../../domain/usecases/get_mosques_usecase.dart';
import '../models/create_mosque_request_model.dart';
import '../models/mosque_model.dart';
import '../models/mosques_page_model.dart';

abstract class MosquesRemoteDataSource {
  Future<MosquesPageModel> getMosques(GetMosquesParams params);

  Future<MosqueModel> createMosque(CreateMosqueRequestModel request);
}
