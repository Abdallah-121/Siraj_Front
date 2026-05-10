import 'dart:io';

import '../../domain/usecases/get_academies_usecase.dart.dart';
import '../models/academies_page_model.dart';
import '../models/academy_model.dart';
import '../models/create_update_academy_request_model.dart';
import '../models/upload_academy_image_response_model.dart';

abstract class AcademiesRemoteDataSource {
  Future<AcademiesPageModel> getAcademies(GetAcademiesParams params);

  Future<AcademyModel> getAcademyById(int academyId);

  Future<AcademiesPageModel> getAcademiesByLocation({
    int? regionId,
    int? cityId,
    int? excludeRegionId,
    bool? isActive,
    int pageNumber = 1,
    int pageSize = 20,
  });

  Future<AcademyModel> createAcademy(CreateUpdateAcademyRequestModel request);

  Future<AcademyModel> updateAcademy({
    required int academyId,
    required CreateUpdateAcademyRequestModel request,
  });

  Future<void> deleteAcademy(int academyId);

  Future<UploadAcademyImageResponseModel> uploadAcademyImage({
    required int academyId,
    required File image,
  });

  Future<void> addFavoriteAcademy(int academyId);

  Future<void> removeFavoriteAcademy(int academyId);

  Future<AcademiesPageModel> getFavoriteAcademies({
    int pageNumber = 1,
    int pageSize = 20,
  });
}
