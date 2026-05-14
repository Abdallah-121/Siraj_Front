import '../../domain/entities/categories_page_entity.dart';
import 'category_model.dart';

class CategoriesPageModel extends CategoriesPageEntity {
  const CategoriesPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
  });

  factory CategoriesPageModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];

    return CategoriesPageModel(
      items: rawItems
          .whereType<Map<String, dynamic>>()
          .map(CategoryModel.fromJson)
          .toList(growable: false),
      totalCount: json['totalCount'] as int? ?? 0,
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
    );
  }
}
