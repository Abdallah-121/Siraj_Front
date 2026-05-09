import 'category_entity.dart';

class CategoriesPageEntity {
  final List<CategoryEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const CategoriesPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
