import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../repositories/academies_repository.dart';

class UploadAcademyImageUseCase {
  final AcademiesRepository repository;

  UploadAcademyImageUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required int academyId,
    required File image,
  }) {
    return repository.uploadAcademyImage(academyId: academyId, image: image);
  }
}
