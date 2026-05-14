import 'package:dartz/dartz.dart';
import 'package:seraj/features/profile/domain/usecase/update_profile_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/auth_session_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, AuthSessionEntity>> updateProfile(
    UpdateProfileParams params,
  );
}
