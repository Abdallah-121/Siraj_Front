class UploadAcademyImageResponseModel {
  final int academyId;
  final String imageUrl;

  const UploadAcademyImageResponseModel({
    required this.academyId,
    required this.imageUrl,
  });

  factory UploadAcademyImageResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadAcademyImageResponseModel(
      academyId: json['academyId'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}
