abstract final class ApiConstants {
  static const String baseUrl = 'http://10.86.204.38:5199';

  static const String cities = '/api/cities';
  static const String mosques = '/api/mosques';
  static const String academies = '/api/academies';
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String lessons = '/api/Lessons';
  static const String createMosqueManagerInvitationCode =
      '/api/invitation-codes/mosque-manager';

  static const String redeemInvitationCode = '/api/invitation-codes/redeem';

  static String uploadMosqueImage(int mosqueId) {
    return '$mosques/$mosqueId/image';
  }
}
