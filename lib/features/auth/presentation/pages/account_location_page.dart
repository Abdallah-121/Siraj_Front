// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/auth/presentation/cubit/register_cubit.dart';
import 'package:seraj/features/auth/presentation/cubit/register_state.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_constraints.dart';
import '../../../../core/responsive/responsive_wrapper.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../location/domain/entities/city_entity.dart';
import '../../../location/presentation/cubit/cities_cubit.dart';
import '../widgets/account_location_form.dart';
import '../widgets/auth_flow_actions.dart';
import '../widgets/auth_logo_panel.dart';
import '../widgets/auth_title_text.dart';

class AccountLocationPage extends StatefulWidget {
  const AccountLocationPage({super.key});

  @override
  State<AccountLocationPage> createState() => _AccountLocationPageState();
}

class _AccountLocationPageState extends State<AccountLocationPage> {
  CityEntity? _selectedCity;
  late final TextEditingController _neighborhoodController;

  @override
  void initState() {
    super.initState();
    _neighborhoodController = TextEditingController();
  }

  @override
  void dispose() {
    _neighborhoodController.dispose();
    super.dispose();
  }

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _onNextPressed(BuildContext context) async {
    debugPrint('NEXT BUTTON PRESSED');
    debugPrint('Selected city id: ${_selectedCity?.id}');
    debugPrint('Neighborhood: ${_neighborhoodController.text.trim()}');
    debugPrint(
      'Draft email: ${context.read<RegisterCubit>().state.draft?.email}',
    );

    if (_selectedCity == null || _neighborhoodController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.pleaseChooseCityAndNeighborhood)),
      );
      return;
    }

    await context.read<RegisterCubit>().submitRegister(
      cityId: _selectedCity!.id,
      neighborhood: _neighborhoodController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CitiesCubit>()..loadCities()),
        BlocProvider.value(value: sl<RegisterCubit>()),
      ],
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) async {
          if (state.isSuccess && state.session != null) {
            await context.read<AuthSessionCubit>().setSession(state.session!);

            if (context.mounted) {
              Navigator.pushReplacementNamed(context, RouteNames.home);
            }
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, registerState) {
          return AppScaffold(
            resizeToAvoidBottomInset: true,
            useSafeArea: false,
            body: Column(
              children: [
                AuthLogoPanel(
                  appName: context.l10n.appName,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    32,
                    AppSpacing.xl,
                    18,
                  ),
                  maxLogoWidth: 150,
                  bottomRadius: 28,
                  logo: Image.asset(AppAssets.logo, fit: BoxFit.contain),
                ),
                Expanded(
                  child: ResponsiveWrapper(
                    maxWidth: ResponsiveConstraints.formMaxWidth,
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.xxl,
                      AppSpacing.xl,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthTitleText(
                          title: context.l10n.accountLocationTitle,
                          textAlign: TextAlign.center,
                        ),
                        AppGap.v24,
                        Expanded(
                          child: SingleChildScrollView(
                            child: AccountLocationForm(
                              neighborhoodController: _neighborhoodController,
                              selectedCity: _selectedCity,
                              onCitySelected: (city) {
                                setState(() {
                                  _selectedCity = city;
                                });
                              },
                            ),
                          ),
                        ),
                        AppGap.v16,
                        AuthFlowActions(
                          onBackPressed: () => _onBackPressed(context),
                          onNextPressed: registerState.isLoading
                              ? () {}
                              : () => _onNextPressed(context),
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
