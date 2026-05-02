import '../repositories/auth_repository.dart';

class ClearAuthSessionUseCase {
  final AuthRepository repository;

  ClearAuthSessionUseCase(this.repository);

  Future<void> call() {
    return repository.clearSession();
  }
}
