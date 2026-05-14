import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/app/local/app_locale_controller.dart';
import 'package:seraj/app/local/app_locale_scope.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/l10n/generated/app_localizations.dart';

import '../core/theme/app_theme.dart';
import 'router/app_router.dart';
import 'router/route_names.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppLocaleController _localeController;

  @override
  void initState() {
    super.initState();
    _localeController = AppLocaleController();
  }

  @override
  void dispose() {
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLocaleScope(
      controller: _localeController,
      child: AnimatedBuilder(
        animation: _localeController,
        builder: (context, _) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthSessionCubit>(
                create: (_) => sl<AuthSessionCubit>()..restoreSession(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              locale: _localeController.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) {
                final TextDirection textDirection = _localeController.isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr;

                return Directionality(
                  textDirection: textDirection,
                  child: child ?? const SizedBox.shrink(),
                );
              },
              initialRoute: RouteNames.welcome,
              onGenerateRoute: AppRouter.onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}
