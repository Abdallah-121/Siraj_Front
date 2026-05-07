import 'dart:io';

import 'package:seraj/features/explore/presentation/mosques/data/models/upload_mosque_image_response_model.dart';

import '../../domain/usecases/get_mosques_usecase.dart';
import '../models/create_mosque_request_model.dart';
import '../models/mosque_model.dart';
import '../models/mosques_page_model.dart';

abstract class MosquesRemoteDataSource {
  Future<MosquesPageModel> getMosques(GetMosquesParams params);

  Future<MosqueModel> createMosque(CreateMosqueRequestModel request);

  Future<UploadMosqueImageResponseModel> uploadMosqueImage({
    required int mosqueId,
    required File image,
  });
}
