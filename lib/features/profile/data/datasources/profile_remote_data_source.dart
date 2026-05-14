import 'package:seraj/features/profile/data/model/update_profile_request_model.dart';

import '../../../auth/domain/entities/auth_session_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<AuthSessionEntity> updateProfile({
    required String userId,
    required String token,
    required int roleId,
    required String roleName,
    required int? teacherId,
    required UpdateProfileRequestModel request,
  });
}
