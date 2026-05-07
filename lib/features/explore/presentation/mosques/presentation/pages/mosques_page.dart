import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosques_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosques_state.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_filter_dropdown.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_header.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_search_bar.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_title_filter_header.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_list_item.dart';

import '../../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/app_scaffold.dart';

class MosquesPage extends StatefulWidget {
  const MosquesPage({super.key});

  @override
  State<MosquesPage> createState() => _MosquesPageState();
}

class _MosquesPageState extends State<MosquesPage> {
  MainNavItem _currentItem = MainNavItem.home;
  bool _isFilterExpanded = false;
  String _selectedFilter = '';

  List<String> get _filterItems => [
    context.l10n.area,
    context.l10n.quran,
    context.l10n.shariaSciences,
    context.l10n.sheikh,
  ];

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _toggleFilter() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
    });
  }

  void _onFilterSelected(String value) {
    setState(() {
      _selectedFilter = value;
      _isFilterExpanded = false;
    });
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

  void _onMosquePressed(MosqueEntity mosque) {
    Navigator.pushNamed(context, RouteNames.mosqueDetail, arguments: mosque);
  }

  @override
  Widget build(BuildContext context) {
    final String filterLabel = _selectedFilter.isEmpty
        ? context.l10n.area
        : _selectedFilter;

    final session = context.watch<AuthSessionCubit>().state.session;
    final bool isAdmin = session?.roleName.trim().toLowerCase() == 'admin';

    return BlocProvider(
      create: (_) => sl<MosquesCubit>()..loadMosques(),
      child: Builder(
        builder: (providerContext) {
          void onSearchPressed() {
            showSearch(
              context: providerContext,
              delegate: _ExploreSearchDelegate(
                onQueryChanged: (query) {
                  providerContext.read<MosquesCubit>().searchMosques(query);
                },
              ),
            );
          }

          return AppScaffold(
            useSafeArea: true,
            bodyPadding: EdgeInsets.zero,
            bottomNavigationBar: MainBottomNavBar(
              currentItem: _currentItem,
              onItemSelected: _onBottomNavItemSelected,
            ),
            floatingActionButton: isAdmin
                ? FloatingActionButton(
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                        providerContext,
                        RouteNames.createMosque,
                      );

                      if (result == true && providerContext.mounted) {
                        providerContext.read<MosquesCubit>().loadMosques();
                      }
                    },
                    child: const Icon(Icons.add_rounded),
                  )
                : null,
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
                        ExploreTitleFilterHeader(
                          leadingSearchIcon: ExploreSearchBar(
                            mode: ExploreSearchBarMode.iconOnly,
                            onTap: onSearchPressed,
                          ),
                          titleIcon: const Icon(
                            Icons.mosque_outlined,
                            size: 34,
                          ),
                          title: context.l10n.mosques,
                          filterWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10n.showMosquesBy,
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              ExploreFilterDropdown(
                                label: filterLabel,
                                items: _filterItems,
                                isExpanded: _isFilterExpanded,
                                onPressed: _toggleFilter,
                                onItemSelected: _onFilterSelected,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        BlocBuilder<MosquesCubit, MosquesState>(
                          builder: (context, state) {
                            if (state.isLoading) {
                              return const _MosquesLoadingState();
                            }

                            if (state.errorMessage != null) {
                              return _MosquesErrorState(
                                message: state.errorMessage!,
                                onRetry: () {
                                  context.read<MosquesCubit>().loadMosques();
                                },
                              );
                            }

                            if (state.mosques.isEmpty) {
                              return _MosquesEmptyState(
                                message: context.l10n.noMosquesFound,
                              );
                            }

                            return ListView.separated(
                              itemCount: state.mosques.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: AppSpacing.lg),
                              itemBuilder: (context, index) {
                                final MosqueEntity mosque =
                                    state.mosques[index];

                                return PlaceListItem(
                                  title: mosque.name,
                                  preacherName: mosque.khatibName.isNotEmpty
                                      ? mosque.khatibName
                                      : context.l10n.unknown,
                                  imamName: mosque.imamName.isNotEmpty
                                      ? mosque.imamName
                                      : context.l10n.unknown,
                                  studyType: mosque.cityName.isNotEmpty
                                      ? mosque.cityName
                                      : context.l10n.unknown,
                                  imageLabel: mosque.name,
                                  isFavorite: false,
                                  onTap: () => _onMosquePressed(mosque),
                                  onFavoritePressed: () {},
                                  imageUrl: mosque.imageUrl,
                                );
                              },
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
        },
      ),
    );
  }
}

class _ExploreSearchDelegate extends SearchDelegate<String> {
  final ValueChanged<String> onQueryChanged;

  _ExploreSearchDelegate({required this.onQueryChanged});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          onQueryChanged('');
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ''),
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onQueryChanged(query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryChanged(query);
    return const SizedBox.shrink();
  }
}

class _MosquesLoadingState extends StatelessWidget {
  const _MosquesLoadingState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.md),
            Text(
              context.l10n.loading,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MosquesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _MosquesErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.error, width: 1),
      ),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
        ],
      ),
    );
  }
}

class _MosquesEmptyState extends StatelessWidget {
  final String message;

  const _MosquesEmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
