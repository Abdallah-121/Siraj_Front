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

  static String publishLesson(int lessonId) {
    return '$lessons/$lessonId/publish';
  }

  static String unpublishLesson(int lessonId) {
    return '$lessons/$lessonId/unpublish';
  }

  static const String users = '/api/users';

  static String updateUserProfile(String userId) {
    return '$users/$userId';
  }

  static const String teachers = '/api/teachers';
  static const String promoteUserToTeacher = '/api/teachers/promote-user';
  static const String searchUsersForPromotion =
      '/api/users/search-for-promotion';

  static String teachersByMosque(int mosqueId) {
    return '$teachers/by-mosque?MosqueId=$mosqueId';
  }

  static String favoriteMosque(int mosqueId) {
    return '$mosques/$mosqueId/favorite';
  }

  static const String favoriteMosques = '$mosques/favorites';
}
