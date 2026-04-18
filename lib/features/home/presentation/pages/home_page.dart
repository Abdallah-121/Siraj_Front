import 'package:flutter/material.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/home_header.dart';
import '../widgets/home_horizontal_section.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/lesson_category_card.dart';
import '../widgets/place_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainNavItem _currentItem = MainNavItem.home;

  void _onBackPressed() {
    Navigator.maybePop(context);
  }

  void _onSearchPressed() {}

  void _onViewAllNearbyMosquesPressed() {
    Navigator.pushNamed(context, RouteNames.mosques);
  }

  void _onViewAllAcademiesPressed() {
    Navigator.pushNamed(context, RouteNames.academies);
  }

  void _onBottomNavItemSelected(MainNavItem item) {
    if (_currentItem == item) return;

    setState(() {
      _currentItem = item;
    });
  }

  void _onQuranPressed() {
    Navigator.pushNamed(context, RouteNames.subjectPlaces);
  }

  void _onShariaPressed() {
    Navigator.pushNamed(context, RouteNames.subjectBranchSelection);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> lessonItems = [
      context.l10n.quranCategory,
      context.l10n.islamicSciencesCategory,
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
          HomeHeader(
            userName: context.l10n.username,
            onBackPressed: _onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HomeSearchBar(onTap: _onSearchPressed),
                  AppGap.v20,
                  HomeHorizontalSection(
                    title: context.l10n.lessonTypesTitle,
                    showAction: false,
                    height: LessonCategoryCard.cardHeight,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: lessonItems.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        return LessonCategoryCard(
                          title: lessonItems[index],
                          onTap: index == 0
                              ? _onQuranPressed
                              : _onShariaPressed,
                        );
                      },
                    ),
                  ),
                  AppGap.v24,
                  HomeHorizontalSection(
                    title: context.l10n.viewAllNearbyMosques,
                    height: PlaceCard.cardHeight,
                    onPressed: _onViewAllNearbyMosquesPressed,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        return PlaceCard(
                          title: context.l10n.sampleMosqueName,
                          isFavorite: index == 1,
                          onTap: _onViewAllNearbyMosquesPressed,
                          onFavoritePressed: () {},
                        );
                      },
                    ),
                  ),
                  AppGap.v24,
                  HomeHorizontalSection(
                    title: context.l10n.viewAllAcademies,
                    height: PlaceCard.cardHeight,
                    onPressed: _onViewAllAcademiesPressed,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        return PlaceCard(
                          title: context.l10n.sampleAcademyName,
                          isFavorite: index == 1,
                          onTap: _onViewAllAcademiesPressed,
                          onFavoritePressed: () {},
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
