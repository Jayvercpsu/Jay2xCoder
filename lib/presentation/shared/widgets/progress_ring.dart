import 'package:flutter/material.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';

class ProgressRing extends StatelessWidget {
  const ProgressRing({super.key, required this.value, required this.label});

  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double safe = value.clamp(0, 1);

    return SizedBox(
      width: 122,
      height: 122,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            value: safe,
            strokeWidth: 12,
            color: ReferencePalette.accentStart,
            backgroundColor: const Color(0xFFE2E8F0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${(safe * 100).round()}%',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(label, style: theme.textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
