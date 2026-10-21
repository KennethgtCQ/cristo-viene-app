
import 'package:flutter/material.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.church_rounded,
          color: accent,
          size: compact ? 27 : 36,
        ),
        const SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CRISTO VIENE',
              style: TextStyle(
                fontFamily: 'Aller',
                fontSize: compact ? 14 : 18,
                letterSpacing: 1.3,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (!compact)
              Text(
                'COMUNIDAD DE FE',
                style: TextStyle(
                  fontFamily: 'Aller',
                  fontSize: 9,
                  letterSpacing: 2.1,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
