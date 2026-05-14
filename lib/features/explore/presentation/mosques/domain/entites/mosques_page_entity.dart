import 'mosque_entity.dart';

class MosquesPageEntity {
  final List<MosqueEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const MosquesPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
