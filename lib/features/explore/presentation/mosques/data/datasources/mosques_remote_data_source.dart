import '../../domain/usecases/get_mosques_usecase.dart';
import '../models/mosques_page_model.dart';

abstract class MosquesRemoteDataSource {
  Future<MosquesPageModel> getMosques(GetMosquesParams params);
}
