import '../entities/auth_session_entity.dart';
import '../repositories/auth_repository.dart';

class GetAuthSessionUseCase {
  final AuthRepository repository;

  GetAuthSessionUseCase(this.repository);

  Future<AuthSessionEntity?> call() {
    return repository.getSavedSession();
  }
}
