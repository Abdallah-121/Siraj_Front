class CategoryRequestModel {
  final String name;

  const CategoryRequestModel({required this.name});

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
