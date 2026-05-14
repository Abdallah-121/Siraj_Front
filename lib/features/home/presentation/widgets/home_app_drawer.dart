import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/invitation_codes/presentation/pages/create_mosque_manager_code_diaolg.dart';
import 'package:seraj/features/invitation_codes/presentation/pages/redeem_invitation_code_diaolg.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/cubit/auth_session_cubit.dart';

class HomeAppDrawer extends StatelessWidget {
  const HomeAppDrawer({super.key});

  bool _isAdmin(String? roleName) {
    return roleName?.trim().toLowerCase() == 'admin';
  }

  bool _canRedeem(String? roleName) {
    final role = roleName?.trim().toLowerCase();
    return role == 'user' || role == 'student' || role == 'teacher';
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthSessionCubit>().state.session;

    final String userName = session?.fullName.trim().isNotEmpty == true
        ? session!.fullName
        : 'مستخدم';

    final String email = session?.email.trim().isNotEmpty == true
        ? session!.email
        : '';

    final String roleName = session?.roleName ?? '';

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (email.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      email,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                  if (roleName.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      roleName,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            _DrawerTile(
              title: 'الملف الشخصي',
              icon: Icons.person_outline_rounded,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.profile);
              },
            ),

            _DrawerTile(
              title: 'المساجد',
              icon: Icons.mosque_outlined,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.mosques);
              },
            ),

            _DrawerTile(
              title: 'الأكاديميات',
              icon: Icons.school_outlined,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.academies);
              },
            ),

            _DrawerTile(
              icon: (Icons.access_time_filled_rounded),
              title: 'أوقات الصلاة',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.prayerTimes);
              },
            ),

            _DrawerTile(
              title: 'الإعدادات',
              icon: Icons.settings_outlined,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.settings);
              },
            ),

            if (_isAdmin(roleName))
              _DrawerTile(
                title: 'توليد كود مدير مسجد',
                icon: Icons.qr_code_rounded,
                onTap: () {
                  Navigator.pop(context);
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => const CreateMosqueManagerCodeDialog(),
                  );
                },
              ),

            if (_canRedeem(roleName))
              _DrawerTile(
                title: 'تفعيل كود الدعوة',
                icon: Icons.verified_outlined,
                onTap: () {
                  Navigator.pop(context);
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => const RedeemInvitationCodeDialog(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: AppTextStyles.bodyLarge,
      ),
    );
  }
}
