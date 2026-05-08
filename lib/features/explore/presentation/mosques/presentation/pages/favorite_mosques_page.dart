import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/app/widgets/app_page_header.dart';
import 'package:seraj/core/theme/app_colors.dart';
import 'package:seraj/core/theme/app_radius.dart';
import 'package:seraj/core/theme/app_spacing.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/core/widgets/app_scaffold.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosque_favorites_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosque_favorites_state.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_list_item.dart';

class FavoriteMosquesPage extends StatelessWidget {
  const FavoriteMosquesPage({super.key});

  void _onMosquePressed(BuildContext context, MosqueEntity mosque) {
    Navigator.pushNamed(context, RouteNames.mosqueDetail, arguments: mosque);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MosqueFavoritesCubit>()..loadFavoriteMosques(),
      child: AppScaffold(
        useSafeArea: true,
        bodyPadding: EdgeInsets.zero,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPageHeader(
              onBackPressed: () => Navigator.pop(context),
              bottomPadding: AppSpacing.xl,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                context.l10n.favorites,
                textAlign: TextAlign.start,
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: BlocConsumer<MosqueFavoritesCubit, MosqueFavoritesState>(
                listenWhen: (previous, current) {
                  return previous.errorMessage != current.errorMessage;
                },
                listener: (context, state) {
                  final message = state.errorMessage;
                  if (message == null || message.trim().isEmpty) return;

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));

                  context.read<MosqueFavoritesCubit>().clearMessages();
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return const _FavoriteMosquesLoadingState();
                  }

                  if (state.errorMessage != null &&
                      state.favoriteMosques.isEmpty) {
                    return _FavoriteMosquesErrorState(
                      message: state.errorMessage!,
                      onRetry: () {
                        context
                            .read<MosqueFavoritesCubit>()
                            .loadFavoriteMosques();
                      },
                    );
                  }

                  if (state.favoriteMosques.isEmpty) {
                    return _FavoriteMosquesEmptyState(
                      message: context.l10n.noFavoriteMosques,
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () {
                      return context
                          .read<MosqueFavoritesCubit>()
                          .loadFavoriteMosques();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        0,
                        AppSpacing.lg,
                        AppSpacing.xl,
                      ),
                      itemCount: state.favoriteMosques.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        final mosque = state.favoriteMosques[index];

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
                          imageUrl: mosque.imageUrl,
                          isFavorite: state.isFavorite(mosque.id),
                          onTap: () => _onMosquePressed(context, mosque),
                          onFavoritePressed: () {
                            context
                                .read<MosqueFavoritesCubit>()
                                .removeFromFavorites(mosque.id);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteMosquesLoadingState extends StatelessWidget {
  const _FavoriteMosquesLoadingState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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

class _FavoriteMosquesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _FavoriteMosquesErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.error, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}

class _FavoriteMosquesEmptyState extends StatelessWidget {
  final String message;

  const _FavoriteMosquesEmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite_border_rounded,
              color: AppColors.textSecondary,
              size: 42,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
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
