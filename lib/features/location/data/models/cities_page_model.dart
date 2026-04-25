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
    final List<dynamic> rawItems = json['items'] as List<dynamic>;

    return CitiesPageModel(
      items: rawItems
          .map((item) => CityModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
    );
  }
}
