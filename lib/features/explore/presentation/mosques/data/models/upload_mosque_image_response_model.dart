class UploadMosqueImageResponseModel {
  final int mosqueId;
  final String imageUrl;

  const UploadMosqueImageResponseModel({
    required this.mosqueId,
    required this.imageUrl,
  });

  factory UploadMosqueImageResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadMosqueImageResponseModel(
      mosqueId: json['mosqueId'] as int,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}
