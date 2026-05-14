import 'package:dartz/dartz.dart';
import 'package:seraj/features/invitation_codes/domain/entites/invitation_code_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/invitation_codes_repository.dart';

class CreateMosqueManagerInvitationCodeUseCase {
  final InvitationCodesRepository repository;

  CreateMosqueManagerInvitationCodeUseCase(this.repository);

  Future<Either<Failure, InvitationCodeEntity>> call({
    required int mosqueId,
    required int expiresInDays,
    required String notes,
  }) {
    return repository.createMosqueManagerInvitationCode(
      mosqueId: mosqueId,
      expiresInDays: expiresInDays,
      notes: notes,
    );
  }
}
