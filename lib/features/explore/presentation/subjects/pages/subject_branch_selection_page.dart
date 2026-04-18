import 'package:flutter/material.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_header.dart';
import 'package:seraj/features/explore/presentation/subjects/widgets/subject_option_card.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../../core/widgets/app_scaffold.dart';

class SubjectBranchSelectionPage extends StatefulWidget {
  const SubjectBranchSelectionPage({super.key});

  @override
  State<SubjectBranchSelectionPage> createState() =>
      _SubjectBranchSelectionPageState();
}

class _SubjectBranchSelectionPageState
    extends State<SubjectBranchSelectionPage> {
  MainNavItem _currentItem = MainNavItem.home;

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onBottomNavItemSelected(MainNavItem item) {
    if (_currentItem == item) return;

    switch (item) {
      case MainNavItem.home:
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;
      default:
        setState(() {
          _currentItem = item;
        });
        break;
    }
  }

  void _onBranchPressed(String branchTitle) {
    Navigator.pushNamed(
      context,
      RouteNames.subjectPlaces,
      arguments: branchTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> branches = [
      context.l10n.hadith,
      context.l10n.tafsir,
      context.l10n.fiqh,
      context.l10n.aqeedah,
      context.l10n.arabicLanguage,
      context.l10n.tajweed,
    ];

    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: MainBottomNavBar(
        currentItem: _currentItem,
        onItemSelected: _onBottomNavItemSelected,
      ),
      body: Column(
        children: [
          ExploreHeader(onBackPressed: _onBackPressed, compact: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.subjectBranchSelectionTitle,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double width = constraints.maxWidth;
                      final double spacing = AppSpacing.lg;
                      final double itemWidth = (width - spacing) / 2;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: branches.map((branch) {
                          return SizedBox(
                            width: itemWidth,
                            child: SubjectOptionCard(
                              title: branch,
                              onTap: () => _onBranchPressed(branch),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
