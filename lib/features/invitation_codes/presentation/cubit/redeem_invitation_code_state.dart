import 'package:seraj/features/invitation_codes/domain/entites/redeem_invitation_result_entity.dart';

class RedeemInvitationCodeState {
  final bool isLoading;
  final RedeemInvitationResultEntity? result;
  final String? errorMessage;

  const RedeemInvitationCodeState({
    required this.isLoading,
    required this.result,
    required this.errorMessage,
  });

  factory RedeemInvitationCodeState.initial() {
    return const RedeemInvitationCodeState(
      isLoading: false,
      result: null,
      errorMessage: null,
    );
  }

  RedeemInvitationCodeState copyWith({
    bool? isLoading,
    RedeemInvitationResultEntity? result,
    String? errorMessage,
    bool clearError = false,
    bool clearResult = false,
  }) {
    return RedeemInvitationCodeState(
      isLoading: isLoading ?? this.isLoading,
      result: clearResult ? null : result ?? this.result,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
