import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';

enum HomeNavItem { search, settings, home, notifications, bookmarks }

class HomeBottomNavBar extends StatelessWidget {
  final HomeNavItem currentItem;
  final ValueChanged<HomeNavItem>? onItemSelected;

  const HomeBottomNavBar({
    super.key,
    required this.currentItem,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _HomeNavBarItem(
              icon: Icons.search_rounded,
              isSelected: currentItem == HomeNavItem.search,
              tooltip: context.l10n.search,
              onTap: () => onItemSelected?.call(HomeNavItem.search),
            ),
            _HomeNavBarItem(
              icon: Icons.settings_outlined,
              isSelected: currentItem == HomeNavItem.settings,
              tooltip: context.l10n.settings,
              onTap: () => onItemSelected?.call(HomeNavItem.settings),
            ),
            _HomeNavBarItem(
              icon: Icons.home_rounded,
              isSelected: currentItem == HomeNavItem.home,
              tooltip: context.l10n.home,
              onTap: () => onItemSelected?.call(HomeNavItem.home),
            ),
            _HomeNavBarItem(
              icon: Icons.notifications_none_rounded,
              isSelected: currentItem == HomeNavItem.notifications,
              tooltip: context.l10n.notifications,
              onTap: () => onItemSelected?.call(HomeNavItem.notifications),
            ),
            _HomeNavBarItem(
              icon: Icons.menu_book_outlined,
              isSelected: currentItem == HomeNavItem.bookmarks,
              tooltip: context.l10n.bookmarks,
              onTap: () => onItemSelected?.call(HomeNavItem.bookmarks),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeNavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final String tooltip;
  final VoidCallback? onTap;

  const _HomeNavBarItem({
    required this.icon,
    required this.isSelected,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? AppColors.primary : AppColors.iconMuted;

    return Semantics(
      button: true,
      label: tooltip,
      selected: isSelected,
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        icon: Icon(icon, color: color, size: isSelected ? 31 : 28),
      ),
    );
  }
}
