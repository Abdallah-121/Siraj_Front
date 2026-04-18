import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/context_extensions.dart';

enum MainNavItem { search, settings, home, notifications, bookmarks }

class MainBottomNavBar extends StatelessWidget {
  final MainNavItem currentItem;
  final ValueChanged<MainNavItem>? onItemSelected;

  const MainBottomNavBar({
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
            _MainNavBarItem(
              icon: Icons.search_rounded,
              isSelected: currentItem == MainNavItem.search,
              tooltip: context.l10n.search,
              onTap: () => onItemSelected?.call(MainNavItem.search),
            ),
            _MainNavBarItem(
              icon: Icons.settings_outlined,
              isSelected: currentItem == MainNavItem.settings,
              tooltip: context.l10n.settings,
              onTap: () => onItemSelected?.call(MainNavItem.settings),
            ),
            _MainNavBarItem(
              icon: Icons.home_rounded,
              isSelected: currentItem == MainNavItem.home,
              tooltip: context.l10n.home,
              onTap: () => onItemSelected?.call(MainNavItem.home),
            ),
            _MainNavBarItem(
              icon: Icons.notifications_none_rounded,
              isSelected: currentItem == MainNavItem.notifications,
              tooltip: context.l10n.notifications,
              onTap: () => onItemSelected?.call(MainNavItem.notifications),
            ),
            _MainNavBarItem(
              icon: Icons.menu_book_outlined,
              isSelected: currentItem == MainNavItem.bookmarks,
              tooltip: context.l10n.bookmarks,
              onTap: () => onItemSelected?.call(MainNavItem.bookmarks),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainNavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final String tooltip;
  final VoidCallback? onTap;

  const _MainNavBarItem({
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
