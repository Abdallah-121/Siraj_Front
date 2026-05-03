import 'package:seraj/features/invitation_codes/domain/entites/invitation_code_entity.dart';

class CreateInvitationCodeState {
  final bool isLoading;
  final InvitationCodeEntity? result;
  final String? errorMessage;

  const CreateInvitationCodeState({
    required this.isLoading,
    required this.result,
    required this.errorMessage,
  });

  factory CreateInvitationCodeState.initial() {
    return const CreateInvitationCodeState(
      isLoading: false,
      result: null,
      errorMessage: null,
    );
  }

  CreateInvitationCodeState copyWith({
    bool? isLoading,
    InvitationCodeEntity? result,
    String? errorMessage,
    bool clearError = false,
    bool clearResult = false,
  }) {
    return CreateInvitationCodeState(
      isLoading: isLoading ?? this.isLoading,
      result: clearResult ? null : result ?? this.result,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
