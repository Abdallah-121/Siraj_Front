import '../entities/auth_session_entity.dart';
import '../repositories/auth_repository.dart';

class SaveAuthSessionUseCase {
  final AuthRepository repository;

  SaveAuthSessionUseCase(this.repository);

  Future<void> call(AuthSessionEntity session) {
    return repository.saveSession(session);
  }
}
