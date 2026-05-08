import 'package:seraj/features/teachers/data/model/create_teacher_request_model.dart';
import 'package:seraj/features/teachers/data/model/mosque_teacher_model.dart';
import 'package:seraj/features/teachers/data/model/promote_user_request_model.dart';
import 'package:seraj/features/teachers/data/model/promotion_user_model.dart';

abstract class TeacherPromotionRemoteDataSource {
  Future<List<PromotionUserModel>> searchUsersForPromotion({
    required String search,
    required int maxResults,
  });

  Future<void> promoteUserToTeacher(PromoteUserRequestModel request);

  Future<void> createTeacher(CreateTeacherRequestModel request);

  Future<List<MosqueTeacherModel>> getTeachersByMosque({required int mosqueId});
}
