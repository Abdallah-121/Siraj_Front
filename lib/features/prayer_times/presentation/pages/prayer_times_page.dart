import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../app/widgets/app_page_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/cubit/auth_session_cubit.dart';
import '../../../location/domain/entities/city_entity.dart';
import '../../../location/presentation/cubit/cities_cubit.dart';
import '../../../location/presentation/cubit/cities_state.dart';
import '../cubit/prayer_times_cubit.dart';
import '../cubit/prayer_times_state.dart';
import '../widgets/prayer_time_tile.dart';
import '../widgets/prayer_times_summary_card.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  late final TextEditingController _cityController;

  CityEntity? _selectedCity;
  bool _didLoadInitial = false;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didLoadInitial) return;
    _didLoadInitial = true;
  }

  int? _sessionCityId(BuildContext context) {
    final session = context.read<AuthSessionCubit>().state.session;
    return session?.cityId;
  }

  void _loadForCity(BuildContext context, int cityId) {
    context.read<PrayerTimesCubit>().loadTodayPrayerTimes(cityId: cityId);
  }

  Future<void> _selectCity(BuildContext pageContext) async {
    final city = await showModalBottomSheet<CityEntity>(
      context: pageContext,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: pageContext.read<CitiesCubit>(),
          child: const _PrayerCityPickerSheet(),
        );
      },
    );

    if (city == null || !pageContext.mounted) return;

    setState(() {
      _selectedCity = city;
      _cityController.text = city.name;
    });

    _loadForCity(pageContext, city.id);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<PrayerTimesCubit>()),
        BlocProvider(create: (_) => sl<CitiesCubit>()..loadCities()),
      ],
      child: Builder(
        builder: (pageContext) {
          final int? cityId = _selectedCity?.id ?? _sessionCityId(pageContext);

          if (cityId != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final state = pageContext.read<PrayerTimesCubit>().state;
              if (state.prayerTimes == null && !state.isLoading) {
                _loadForCity(pageContext, cityId);
              }
            });
          }

          return AppScaffold(
            useSafeArea: true,
            bodyPadding: EdgeInsets.zero,
            body: Column(
              children: [
                AppPageHeader(
                  onBackPressed: () => Navigator.pop(pageContext),
                  bottomPadding: AppSpacing.xxl,
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
                        Text(
                          context.l10n.prayerTimes,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        AppGap.v16,
                        TextField(
                          controller: _cityController,
                          readOnly: true,
                          onTap: () => _selectCity(pageContext),
                          decoration: InputDecoration(
                            hintText: context.l10n.chooseCity,
                            prefixIcon: const Icon(
                              Icons.location_city_outlined,
                            ),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                          ),
                        ),
                        AppGap.v20,
                        BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
                          builder: (context, state) {
                            if (cityId == null &&
                                state.prayerTimes == null &&
                                !state.isLoading) {
                              return _EmptyPrayerTimesState(
                                message:
                                    context.l10n.chooseCityToShowPrayerTimes,
                              );
                            }

                            if (state.isLoading) {
                              return const _PrayerTimesLoadingState();
                            }

                            if (state.errorMessage != null) {
                              return _PrayerTimesErrorState(
                                message: state.errorMessage!,
                                onRetry: cityId == null
                                    ? null
                                    : () => _loadForCity(context, cityId),
                              );
                            }

                            final prayerTimes = state.prayerTimes;
                            if (prayerTimes == null) {
                              return _EmptyPrayerTimesState(
                                message: context.l10n.noPrayerTimesFound,
                              );
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                PrayerTimesSummaryCard(
                                  prayerTimes: prayerTimes,
                                ),
                                AppGap.v20,
                                PrayerTimeTile(
                                  title: context.l10n.fajr,
                                  time: prayerTimes.fajr,
                                  icon: Icons.nightlight_round,
                                  isHighlighted:
                                      prayerTimes.nextPrayerName == 'Fajr',
                                ),
                                AppGap.v12,
                                PrayerTimeTile(
                                  title: context.l10n.sunrise,
                                  time: prayerTimes.sunrise,
                                  icon: Icons.wb_twilight_rounded,
                                  isHighlighted:
                                      prayerTimes.nextPrayerName == 'Sunrise',
                                ),
                                AppGap.v12,
                                PrayerTimeTile(
                                  title: context.l10n.dhuhr,
                                  time: prayerTimes.dhuhr,
                                  icon: Icons.wb_sunny_outlined,
                                  isHighlighted:
                                      prayerTimes.nextPrayerName == 'Dhuhr',
                                ),
                                AppGap.v12,
                                PrayerTimeTile(
                                  title: context.l10n.asr,
                                  time: prayerTimes.asr,
                                  icon: Icons.sunny_snowing,
                                  isHighlighted:
                                      prayerTimes.nextPrayerName == 'Asr',
                                ),
                                AppGap.v12,
                                PrayerTimeTile(
                                  title: context.l10n.maghrib,
                                  time: prayerTimes.maghrib,
                                  icon: Icons.wb_twilight_outlined,
                                  isHighlighted:
                                      prayerTimes.nextPrayerName == 'Maghrib',
                                ),
                                AppGap.v12,
                                PrayerTimeTile(
                                  title: context.l10n.isha,
                                  time: prayerTimes.isha,
                                  icon: Icons.dark_mode_outlined,
                                  isHighlighted:
                                      prayerTimes.nextPrayerName == 'Isha',
                                ),
                              ],
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

class _PrayerCityPickerSheet extends StatelessWidget {
  const _PrayerCityPickerSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.70,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: TextField(
                decoration: InputDecoration(
                  hintText: context.l10n.searchGovernorate,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
                onChanged: context.read<CitiesCubit>().searchCities,
              ),
            ),
            Expanded(
              child: BlocBuilder<CitiesCubit, CitiesState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  }

                  if (state.cities.isEmpty) {
                    return Center(child: Text(context.l10n.noCitiesFound));
                  }

                  return ListView.separated(
                    itemCount: state.cities.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final city = state.cities[index];

                      return ListTile(
                        title: Text(city.name),
                        onTap: () => Navigator.pop(context, city),
                      );
                    },
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

class _PrayerTimesLoadingState extends StatelessWidget {
  const _PrayerTimesLoadingState();

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

class _PrayerTimesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _PrayerTimesErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.error),
      ),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.md),
            TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
          ],
        ],
      ),
    );
  }
}

class _EmptyPrayerTimesState extends StatelessWidget {
  final String message;

  const _EmptyPrayerTimesState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border),
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
