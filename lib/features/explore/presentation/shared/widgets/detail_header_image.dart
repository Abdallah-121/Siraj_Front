import 'package:flutter/material.dart';
import 'package:seraj/core/utils/image_url_resolver.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class DetailHeaderImage extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFavoritePressed;
  final bool isFavorite;

  /// Extra actions shown beside the back button.
  ///
  /// Example:
  /// - promote user to teacher
  /// - share
  /// - edit
  final List<Widget> leadingActions;

  const DetailHeaderImage({
    super.key,
    this.imageUrl,
    this.onBackPressed,
    this.onFavoritePressed,
    this.isFavorite = false,
    this.leadingActions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final String resolvedImageUrl = resolveImageUrl(imageUrl);
    final bool hasImage = resolvedImageUrl.trim().isNotEmpty;

    return Container(
      height: 280,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
            child: hasImage
                ? Image.network(
                    resolvedImageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return const _PlaceholderImage(showLoading: true);
                    },
                    errorBuilder: (_, __, ___) {
                      debugPrint('Image failed to load: $resolvedImageUrl');
                      return const _PlaceholderImage();
                    },
                  )
                : const _PlaceholderImage(),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.18),
                  Colors.black.withValues(alpha: 0.48),
                ],
              ),
            ),
          ),

          PositionedDirectional(
            top: AppSpacing.lg,
            start: AppSpacing.lg,
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderCircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    onPressed: onBackPressed,
                  ),
                  for (final action in leadingActions) ...[
                    const SizedBox(width: AppSpacing.sm),
                    action,
                  ],
                ],
              ),
            ),
          ),

          PositionedDirectional(
            top: AppSpacing.lg,
            end: AppSpacing.lg,
            child: SafeArea(
              bottom: false,
              child: HeaderCircleIconButton(
                icon: isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                iconColor: isFavorite ? AppColors.error : AppColors.primary,
                onPressed: onFavoritePressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;
  final String? tooltip;

  const HeaderCircleIconButton({
    super.key,
    required this.icon,
    this.iconColor = AppColors.primary,
    this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final Widget button = Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(icon, color: iconColor, size: 25),
        ),
      ),
    );

    if (tooltip == null || tooltip!.trim().isEmpty) {
      return button;
    }

    return Tooltip(message: tooltip!, child: button);
  }
}

class _PlaceholderImage extends StatelessWidget {
  final bool showLoading;

  const _PlaceholderImage({this.showLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Center(
        child: showLoading
            ? const CircularProgressIndicator(color: AppColors.white)
            : Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                ),
                child: const Icon(
                  Icons.mosque_rounded,
                  color: AppColors.white,
                  size: 54,
                ),
              ),
      ),
    );
  }
}
