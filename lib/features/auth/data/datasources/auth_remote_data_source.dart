import 'package:seraj/features/auth/data/models/change_password_request_model.dart';

import '../models/auth_session_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login(LoginRequestModel request);
  Future<AuthSessionModel> register(RegisterRequestModel request);
  Future<void> changePassword(ChangePasswordRequestModel request);
}
