import 'academy_entity.dart';

class AcademiesPageEntity {
  final List<AcademyEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const AcademiesPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
