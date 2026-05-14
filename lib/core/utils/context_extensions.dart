import 'package:flutter/widgets.dart';
import 'package:seraj/l10n/generated/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
