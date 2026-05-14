import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';

import '../repositories/mosques_repository.dart';

class UploadMosqueImageUseCase {
  final MosquesRepository repository;

  UploadMosqueImageUseCase(this.repository);

  Future<Either<Failure, String>> call(UploadMosqueImageParams params) {
    return repository.uploadMosqueImage(
      mosqueId: params.mosqueId,
      image: params.image,
    );
  }
}

class UploadMosqueImageParams {
  final int mosqueId;
  final File image;

  const UploadMosqueImageParams({required this.mosqueId, required this.image});
}
