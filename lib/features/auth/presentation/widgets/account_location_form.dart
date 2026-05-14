import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../location/domain/entities/city_entity.dart';
import '../../../location/presentation/cubit/cities_cubit.dart';
import '../../../location/presentation/cubit/cities_state.dart';

class AccountLocationForm extends StatefulWidget {
  final TextEditingController neighborhoodController;
  final CityEntity? selectedCity;
  final ValueChanged<CityEntity> onCitySelected;

  const AccountLocationForm({
    super.key,
    required this.neighborhoodController,
    required this.selectedCity,
    required this.onCitySelected,
  });

  @override
  State<AccountLocationForm> createState() => _AccountLocationFormState();
}

class _AccountLocationFormState extends State<AccountLocationForm> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<CitiesCubit>().searchCities(_searchController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionLabel(label: context.l10n.governorate),
        AppGap.v8,
        AppTextField(
          hintText: context.l10n.searchGovernorate,
          controller: _searchController,
          prefixIcon: const Icon(Icons.search_rounded),
        ),
        AppGap.v12,
        BlocBuilder<CitiesCubit, CitiesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(color: const Color(0xFFE8E2B5), width: 1),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            if (state.errorMessage != null) {
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
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    AppGap.v12,
                    TextButton(
                      onPressed: () {
                        context.read<CitiesCubit>().loadCities(
                          search: _searchController.text.trim(),
                        );
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state.cities.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(color: const Color(0xFFE8E2B5), width: 1),
                ),
                child: Text(
                  'لا توجد مدن مطابقة',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(color: const Color(0xFFE8E2B5), width: 1),
              ),
              child: Column(
                children: List.generate(state.cities.length, (index) {
                  final CityEntity city = state.cities[index];
                  final bool isLast = index == state.cities.length - 1;
                  final bool isSelected = widget.selectedCity?.id == city.id;

                  return InkWell(
                    onTap: () => widget.onCitySelected(city),
                    borderRadius: isLast
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(AppRadius.xl),
                            bottomRight: Radius.circular(AppRadius.xl),
                          )
                        : BorderRadius.zero,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.lg,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.surfaceSoft
                            : AppColors.surface,
                        border: isLast
                            ? null
                            : const Border(
                                bottom: BorderSide(
                                  color: AppColors.divider,
                                  width: 1,
                                ),
                              ),
                      ),
                      child: Center(
                        child: Text(
                          city.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
        AppGap.v32,
        _SectionLabel(label: context.l10n.neighborhood),
        AppGap.v8,
        AppTextField(
          hintText: context.l10n.writeNeighborhood,
          controller: widget.neighborhoodController,
          prefixIcon: const Icon(Icons.location_on_outlined),
        ),
        AppGap.v8,
        Text(
          context.l10n.neighborhoodHelp,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        label,
        style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
