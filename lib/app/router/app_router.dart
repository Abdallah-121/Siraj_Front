import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/account_location_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/explore/presentation/academies/pages/academies_page.dart';
import '../../features/explore/presentation/academies/pages/academy_detail_page.dart';
import '../../features/explore/presentation/mosques/pages/mosque_detail_page.dart';
import '../../features/explore/presentation/mosques/pages/mosques_page.dart';
import '../../features/explore/presentation/registration/pages/course_registration_page.dart';
import '../../features/explore/presentation/sheikhs/pages/sheikh_detail_page.dart';
import '../../features/explore/presentation/sheikhs/pages/sheikhs_page.dart';
import '../../features/explore/presentation/subjects/pages/subject_branch_selection_page.dart';
import '../../features/explore/presentation/subjects/pages/subject_places_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'route_names.dart';

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.welcome:
        return _materialRoute(settings: settings, child: const WelcomePage());
      case RouteNames.login:
        return _materialRoute(settings: settings, child: const LoginPage());
      case RouteNames.register:
        return _materialRoute(settings: settings, child: const RegisterPage());
      case RouteNames.forgotPassword:
        return _materialRoute(
          settings: settings,
          child: const ForgotPasswordPage(),
        );
      case RouteNames.accountLocation:
        return _materialRoute(
          settings: settings,
          child: const AccountLocationPage(),
        );
      case RouteNames.home:
        return _materialRoute(settings: settings, child: const HomePage());
      case RouteNames.mosques:
        return _materialRoute(settings: settings, child: const MosquesPage());
      case RouteNames.academies:
        return _materialRoute(settings: settings, child: const AcademiesPage());
      case RouteNames.sheikhs:
        return _materialRoute(settings: settings, child: const SheikhsPage());
      case RouteNames.subjectBranchSelection:
        return _materialRoute(
          settings: settings,
          child: const SubjectBranchSelectionPage(),
        );
      case RouteNames.subjectPlaces:
        return _materialRoute(
          settings: settings,
          child: const SubjectPlacesPage(),
        );
      case RouteNames.mosqueDetail:
        return _materialRoute(
          settings: settings,
          child: const MosqueDetailPage(),
        );
      case RouteNames.academyDetail:
        return _materialRoute(
          settings: settings,
          child: const AcademyDetailPage(),
        );
      case RouteNames.sheikhDetail:
        return _materialRoute(
          settings: settings,
          child: const SheikhDetailPage(),
        );
      case RouteNames.courseRegistration:
        return _materialRoute(
          settings: settings,
          child: const CourseRegistrationPage(),
        );
      case RouteNames.search:
        return _materialRoute(settings: settings, child: const SearchPage());
      case RouteNames.settings:
        return _materialRoute(settings: settings, child: const SettingsPage());
      default:
        return _materialRoute(settings: settings, child: const WelcomePage());
    }
  }

  static MaterialPageRoute<dynamic> _materialRoute({
    required RouteSettings settings,
    required Widget child,
  }) {
    return MaterialPageRoute(settings: settings, builder: (_) => child);
  }
}
