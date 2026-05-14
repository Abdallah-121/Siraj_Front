import 'city_entity.dart';

class CitiesPageEntity {
  final List<CityEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const CitiesPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
