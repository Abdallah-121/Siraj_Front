import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';

class ExploreTitleFilterHeader extends StatelessWidget {
  final Widget leadingSearchIcon;
  final Widget titleIcon;
  final String title;
  final Widget filterWidget;

  const ExploreTitleFilterHeader({
    super.key,
    required this.leadingSearchIcon,
    required this.titleIcon,
    required this.title,
    required this.filterWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leadingSearchIcon,
            const Spacer(),
            titleIcon,
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Align(alignment: AlignmentDirectional.centerEnd, child: filterWidget),
      ],
    );
  }
}
