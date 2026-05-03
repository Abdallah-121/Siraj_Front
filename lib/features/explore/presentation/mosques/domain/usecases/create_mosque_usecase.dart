import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';

import '../repositories/mosques_repository.dart';

class CreateMosqueUseCase {
  final MosquesRepository repository;

  CreateMosqueUseCase(this.repository);

  Future<Either<Failure, MosqueEntity>> call(CreateMosqueParams params) {
    return repository.createMosque(params);
  }
}

class CreateMosqueParams {
  final int regionId;
  final String name;
  final String imamName;
  final String khatibName;
  final String address;
  final String phoneNumber;
  final double latitude;
  final double longitude;
  final String timezone;
  final int calculationMethod;
  final int madhab;

  const CreateMosqueParams({
    required this.regionId,
    required this.name,
    required this.imamName,
    required this.khatibName,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.calculationMethod,
    required this.madhab,
  });
}
