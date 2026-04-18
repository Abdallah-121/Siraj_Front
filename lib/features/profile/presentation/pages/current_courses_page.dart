import 'package:flutter/material.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/widgets/app_page_header.dart';
import '../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/course_progress_card.dart';

class CurrentCoursesPage extends StatefulWidget {
  const CurrentCoursesPage({super.key});

  @override
  State<CurrentCoursesPage> createState() => _CurrentCoursesPageState();
}

class _CurrentCoursesPageState extends State<CurrentCoursesPage> {
  MainNavItem _currentItem = MainNavItem.bookmarks;

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onBottomNavItemSelected(MainNavItem item) {
    if (_currentItem == item) return;

    switch (item) {
      case MainNavItem.home:
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;
      case MainNavItem.search:
        Navigator.pushReplacementNamed(context, RouteNames.search);
        break;
      case MainNavItem.settings:
        Navigator.pushReplacementNamed(context, RouteNames.settings);
        break;
      default:
        setState(() {
          _currentItem = item;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: MainBottomNavBar(
        currentItem: _currentItem,
        onItemSelected: _onBottomNavItemSelected,
      ),
      body: Column(
        children: [
          AppPageHeader(onBackPressed: _onBackPressed),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.currentCoursesTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppGap.v24,
                  Expanded(
                    child: ListView.separated(
                      itemCount: 2,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        return CourseProgressCard(
                          title: context.l10n.courseName,
                          teacherLine: context.l10n.sampleCourseTeacher,
                          timeLine: context.l10n.sampleCourseTime,
                          progress: 0.65,
                        );
                      },
                    ),
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
