import '../../domain/entities/cities_page_entity.dart';
import 'city_model.dart';

class CitiesPageModel extends CitiesPageEntity {
  const CitiesPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
  });

  factory CitiesPageModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawItems =
        json['items'] as List<dynamic>? ?? <dynamic>[];

    return CitiesPageModel(
      items: rawItems
          .map((item) => CityModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int? ?? 0,
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? rawItems.length,
    );
  }
}
