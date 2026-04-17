import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';

class AccountLocationForm extends StatefulWidget {
  const AccountLocationForm({super.key});

  @override
  State<AccountLocationForm> createState() => _AccountLocationFormState();
}

class _AccountLocationFormState extends State<AccountLocationForm> {
  late final TextEditingController _searchController;
  late final TextEditingController _neighborhoodController;

  final List<String> _allGovernorates = [];
  String? _selectedGovernorate;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _neighborhoodController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_allGovernorates.isEmpty) {
      _allGovernorates.addAll([
        context.l10n.damascus,
        context.l10n.aleppo,
        context.l10n.hama,
        context.l10n.tartus,
        context.l10n.latakia,
        context.l10n.daraa,
        context.l10n.suwayda,
        context.l10n.homs,
        context.l10n.deirEzzor,
      ]);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _neighborhoodController.dispose();
    super.dispose();
  }

  List<String> get _filteredGovernorates {
    final String query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return _allGovernorates;
    }

    return _allGovernorates
        .where((item) => item.toLowerCase().contains(query))
        .toList();
  }

  void _onGovernorateSelected(String value) {
    setState(() {
      _selectedGovernorate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = _filteredGovernorates;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionLabel(label: context.l10n.governorate),
        AppGap.v8,
        AppTextField(
          hintText: context.l10n.searchGovernorate,
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          prefixIcon: const Icon(Icons.search_rounded),
        ),
        AppGap.v12,
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: const Color(0xFFE8E2B5), width: 1),
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final String item = items[index];
              final bool isLast = index == items.length - 1;
              final bool isSelected = _selectedGovernorate == item;

              return InkWell(
                onTap: () => _onGovernorateSelected(item),
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
                      item,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        AppGap.v32,
        _SectionLabel(label: context.l10n.neighborhood),
        AppGap.v8,
        AppTextField(
          hintText: context.l10n.writeNeighborhood,
          controller: _neighborhoodController,
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
