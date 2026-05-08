import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosque_favorites_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosque_favorites_state.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosques_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosques_state.dart';
import 'package:seraj/features/home/presentation/widgets/home_app_drawer.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/cubit/auth_session_cubit.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MainNavItem _currentItem = MainNavItem.home;

  void _onMenuPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onSearchPressed() {}

  void _onViewAllNearbyMosquesPressed() {
    Navigator.pushNamed(context, RouteNames.mosques);
  }

  void _onViewAllAcademiesPressed() {
    Navigator.pushNamed(context, RouteNames.academies);
  }

  void _onMosquePressed(MosqueEntity mosque) {
    Navigator.pushNamed(context, RouteNames.mosqueDetail, arguments: mosque);
  }

  void _onBottomNavItemSelected(MainNavItem item) {
    if (_currentItem == item) return;

    switch (item) {
      case MainNavItem.search:
        Navigator.pushNamed(context, RouteNames.search);
        break;
      case MainNavItem.settings:
        Navigator.pushNamed(context, RouteNames.settings);
        break;
      case MainNavItem.profile:
        Navigator.pushNamed(context, RouteNames.profile);
        break;
      default:
        setState(() {
          _currentItem = item;
        });
        break;
    }
  }

  void _onQuranPressed() {
    Navigator.pushNamed(context, RouteNames.subjectPlaces);
  }

  void _onShariaPressed() {
    Navigator.pushNamed(context, RouteNames.subjectBranchSelection);
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthSessionCubit>().state;
    final session = authState.session;

    final String userName = session?.fullName.trim().isNotEmpty == true
        ? session!.fullName
        : context.l10n.username;

    final List<String> lessonItems = [
      context.l10n.quranCategory,
      context.l10n.islamicSciencesCategory,
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<MosquesCubit>()..loadMosques(pageSize: 8),
        ),
        BlocProvider(
          create: (_) => sl<MosqueFavoritesCubit>()..loadFavoriteMosques(),
        ),
      ],
      child: AppScaffold(
        scaffoldKey: _scaffoldKey,
        useSafeArea: true,
        bodyPadding: EdgeInsets.zero,
        drawer: const HomeAppDrawer(),
        bottomNavigationBar: MainBottomNavBar(
          currentItem: _currentItem,
          onItemSelected: _onBottomNavItemSelected,
        ),
        body: Column(
          children: [
            HomeHeader(
              userName: userName,
              onBackPressed: _onMenuPressed,
              onAvatarPressed: () {
                Navigator.pushNamed(context, RouteNames.profile);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(
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
                    _HomeMosquesSection(
                      onViewAllPressed: _onViewAllNearbyMosquesPressed,
                      onMosquePressed: _onMosquePressed,
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
                            subtitle: context.l10n.academyDetails,
                            actionLabel: context.l10n.viewDetails,
                            fallbackIcon: Icons.school_rounded,
                            isFavorite: false,
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
      ),
    );
  }
}

class _HomeMosquesSection extends StatelessWidget {
  final VoidCallback onViewAllPressed;
  final ValueChanged<MosqueEntity> onMosquePressed;

  const _HomeMosquesSection({
    required this.onViewAllPressed,
    required this.onMosquePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MosquesCubit, MosquesState>(
      builder: (context, mosquesState) {
        final List<MosqueEntity> mosques = mosquesState.mosques
            .take(5)
            .toList(growable: false);

        return HomeHorizontalSection(
          title: context.l10n.viewAllNearbyMosques,
          height: PlaceCard.cardHeight,
          onPressed: onViewAllPressed,
          child: BlocBuilder<MosqueFavoritesCubit, MosqueFavoritesState>(
            builder: (context, favoritesState) {
              if (mosquesState.isLoading) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.lg),
                  itemBuilder: (context, index) {
                    return PlaceCard(
                      title: context.l10n.loading,
                      subtitle: '',
                      actionLabel: context.l10n.viewDetails,
                      isFavorite: false,
                      onTap: null,
                      onFavoritePressed: null,
                    );
                  },
                );
              }

              if (mosques.isEmpty) {
                return Center(child: Text(context.l10n.noMosquesFound));
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: mosques.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.lg),
                itemBuilder: (context, index) {
                  final mosque = mosques[index];

                  return PlaceCard(
                    title: mosque.name,
                    subtitle: mosque.cityName.isNotEmpty
                        ? mosque.cityName
                        : mosque.address,
                    actionLabel: context.l10n.viewDetails,
                    imageUrl: mosque.imageUrl,
                    fallbackIcon: Icons.mosque_rounded,
                    isFavorite: favoritesState.isFavorite(mosque.id),
                    onTap: () => onMosquePressed(mosque),
                    onFavoritePressed: () {
                      context.read<MosqueFavoritesCubit>().toggleFavorite(
                        mosque.id,
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
