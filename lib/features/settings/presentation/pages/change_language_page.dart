import 'package:flutter/material.dart';
import 'package:seraj/app/local/app_locale_scope.dart';

import '../../../../app/widgets/app_page_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/language_option_tile.dart';
import '../widgets/language_search_field.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late final TextEditingController _searchController;
  String _selectedLanguageCode = 'ar';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLanguageCode = Localizations.localeOf(context).languageCode;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onLanguageSelected(String code) {
    setState(() {
      _selectedLanguageCode = code;
    });
  }

  void _onApplyPressed() {
    AppLocaleScope.of(context).setLocale(Locale(_selectedLanguageCode));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<_LanguageItem> allLanguages = [
      _LanguageItem(code: 'ar', title: context.l10n.arabicLanguage),
      _LanguageItem(code: 'en', title: context.l10n.englishLanguage),
      _LanguageItem(code: 'de', title: context.l10n.germanLanguage),
    ];

    final String query = _searchController.text.trim().toLowerCase();

    final List<_LanguageItem> filteredLanguages = query.isEmpty
        ? allLanguages
        : allLanguages
              .where((item) => item.title.toLowerCase().contains(query))
              .toList();

    return AppScaffold(
      useSafeArea: true,
      resizeToAvoidBottomInset: true,
      bodyPadding: EdgeInsets.zero,
      body: Column(
        children: [
          AppPageHeader(
            onBackPressed: _onBackPressed,
            bottomPadding: AppSpacing.xxxl,
          ),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.changeLanguageTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                    AppGap.v40,
                    LanguageSearchField(
                      controller: _searchController,
                      hintText: context.l10n.searchForDesiredLanguage,
                      onChanged: (_) => setState(() {}),
                    ),
                    AppGap.v24,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Column(
                        children: filteredLanguages.asMap().entries.map((
                          entry,
                        ) {
                          final int index = entry.key;
                          final _LanguageItem item = entry.value;
                          final bool isLast =
                              index == filteredLanguages.length - 1;

                          return Column(
                            children: [
                              LanguageOptionTile(
                                title: item.title,
                                isSelected: _selectedLanguageCode == item.code,
                                onTap: () => _onLanguageSelected(item.code),
                              ),
                              if (isLast) const SizedBox.shrink(),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    AppGap.v40,
                    Text(
                      context.l10n.languageUpdateNote,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    AppGap.v40,
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 220,
                        child: AppButton(
                          label: context.l10n.changeLanguageButton,
                          onPressed: _onApplyPressed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageItem {
  final String code;
  final String title;

  const _LanguageItem({required this.code, required this.title});
}
