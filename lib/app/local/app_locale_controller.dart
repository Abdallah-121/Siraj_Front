import 'package:flutter/material.dart';

class AppLocaleController extends ChangeNotifier {
  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  bool get isArabic => _locale.languageCode == 'ar';

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggleLocale() {
    _locale = isArabic ? const Locale('en') : const Locale('ar');
    notifyListeners();
  }
}
