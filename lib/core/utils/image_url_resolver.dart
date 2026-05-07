import 'package:seraj/core/network/api_constants.dart';

String resolveImageUrl(String? imageUrl) {
  if (imageUrl == null || imageUrl.trim().isEmpty) return '';

  final value = imageUrl.trim();

  if (value.startsWith('http://') || value.startsWith('https://')) {
    return value;
  }

  final baseUrl = ApiConstants.baseUrl;

  if (value.startsWith('/')) {
    return '$baseUrl$value';
  }

  return '$baseUrl/$value';
}
