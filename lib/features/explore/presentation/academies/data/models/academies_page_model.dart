import 'package:seraj/features/explore/presentation/academies/domain/entites/academies_page_entity.dart';

import 'academy_model.dart';

class AcademiesPageModel extends AcademiesPageEntity {
  const AcademiesPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
  });

  factory AcademiesPageModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawItems = json['items'] as List<dynamic>;

    return AcademiesPageModel(
      items: rawItems
          .map((item) => AcademyModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
    );
  }
}
