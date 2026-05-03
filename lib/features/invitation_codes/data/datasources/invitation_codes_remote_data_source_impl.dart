import 'package:dio/dio.dart';
import 'package:seraj/features/invitation_codes/data/model/create_mosque_manager_invitation_request_model.dart';
import 'package:seraj/features/invitation_codes/data/model/invitation_code_entity_model.dart';
import 'package:seraj/features/invitation_codes/data/model/redeem_invitation_code_request_model.dart';
import 'package:seraj/features/invitation_codes/data/model/redeem_invitation_result_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import 'invitation_codes_remote_data_source.dart';

class InvitationCodesRemoteDataSourceImpl
    implements InvitationCodesRemoteDataSource {
  final DioClient dioClient;

  InvitationCodesRemoteDataSourceImpl(this.dioClient);

  @override
  Future<InvitationCodeModel> createMosqueManagerInvitationCode({
    required int mosqueId,
    required int expiresInDays,
    required String notes,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.createMosqueManagerInvitationCode,
        data: CreateMosqueManagerInvitationRequestModel(
          mosqueId: mosqueId,
          expiresInDays: expiresInDays,
          notes: notes,
        ).toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Create code failed',
          statusCode: response.statusCode,
        );
      }

      return InvitationCodeModel.fromJson(
        responseMap['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data?['message']?.toString() ??
            e.message ??
            'Create code failed',
        statusCode: e.response?.statusCode,
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<RedeemInvitationResultModel> redeemInvitationCode({
    required String code,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.redeemInvitationCode,
        data: RedeemInvitationCodeRequestModel(code: code).toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Redeem code failed',
          statusCode: response.statusCode,
        );
      }

      return RedeemInvitationResultModel.fromJson(
        responseMap['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      String serverMessage = e.message ?? 'Create code failed';

      if (responseData is Map<String, dynamic>) {
        final errors = responseData['errors'];
        if (errors is List && errors.isNotEmpty) {
          serverMessage = errors.first.toString();
        } else if (responseData['message'] != null) {
          serverMessage = responseData['message'].toString();
        }
      }

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }
}
