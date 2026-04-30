import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';

import '../models/academies_page_model.dart';

abstract class AcademiesRemoteDataSource {
  Future<AcademiesPageModel> getAcademies(GetAcademiesParams params);
}
