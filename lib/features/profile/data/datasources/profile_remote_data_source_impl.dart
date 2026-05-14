import 'package:dio/dio.dart';
import 'package:seraj/features/profile/data/model/update_profile_request_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/domain/entities/auth_session_entity.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AuthSessionEntity> updateProfile({
    required String userId,
    required String token,
    required int roleId,
    required String roleName,
    required int? teacherId,
    required UpdateProfileRequestModel request,
  }) async {
    try {
      final response = await dioClient.dio.put(
        ApiConstants.updateUserProfile(userId),
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Update profile failed',
          statusCode: response.statusCode,
        );
      }

      final data = responseMap['data'] as Map<String, dynamic>?;

      final String firstName =
          data?['firstName'] as String? ?? request.firstName;
      final String lastName = data?['lastName'] as String? ?? request.lastName;
      final String fullName = '$firstName $lastName'.trim();

      return AuthSessionEntity(
        userId: userId,
        fullName: fullName,
        email: data?['email'] as String? ?? request.email,
        roleId: roleId,
        roleName: roleName,
        token: token,
        teacherId: teacherId,
        firstName: firstName,
        lastName: lastName,
        phone: data?['phone'] as String? ?? request.phone,
        profileImage: data?['profileImage'] as String? ?? request.profileImage,
        description: data?['description'] as String? ?? request.description,
        cityId: data?['cityId'] as int? ?? request.cityId,
        birthDate: data?['birthDate'] == null
            ? request.birthDate
            : DateTime.tryParse(data!['birthDate'].toString()) ??
                  request.birthDate,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final responseData = e.response?.data;
      final serverMessage = responseData is Map<String, dynamic>
          ? responseData['message'] as String? ?? 'Update profile failed'
          : 'Update profile failed';

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }
}
