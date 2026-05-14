import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosques_page_entity.dart';

import 'mosque_model.dart';

class MosquesPageModel extends MosquesPageEntity {
  const MosquesPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
  });

  factory MosquesPageModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawItems = json['items'] as List<dynamic>;

    return MosquesPageModel(
      items: rawItems
          .map((item) => MosqueModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
    );
  }
}
