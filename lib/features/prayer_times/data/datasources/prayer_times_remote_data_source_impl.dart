import 'package:dio/dio.dart';
import 'package:seraj/features/prayer_times/data/model/prayer_times_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import 'prayer_times_remote_data_source.dart';

class PrayerTimesRemoteDataSourceImpl implements PrayerTimesRemoteDataSource {
  final DioClient dioClient;

  PrayerTimesRemoteDataSourceImpl(this.dioClient);

  @override
  Future<PrayerTimesModel> getTodayPrayerTimes({required int cityId}) async {
    try {
      final Response<dynamic> response = await dioClient.dio.get(
        ApiConstants.prayerTimesToday,
        queryParameters: {'CityId': cityId},
      );

      final responseData = response.data;

      if (responseData is! Map<String, dynamic>) {
        throw UnexpectedException(message: 'Unexpected error');
      }

      return PrayerTimesModel.fromJson(responseData);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final responseData = e.response?.data;

      final String serverMessage = responseData is Map<String, dynamic>
          ? responseData['message'] as String? ?? 'Prayer times request failed'
          : 'Prayer times request failed';

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } on NetworkException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }
}
