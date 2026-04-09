import 'package:flutter/material.dart';
import 'package:jay2xcoder/presentation/shared/widgets/tap_scale.dart';

class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool dark = theme.brightness == Brightness.dark;

    Widget card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            theme.cardColor.withValues(alpha: dark ? 0.98 : 0.96),
            theme.cardColor.withValues(alpha: dark ? 0.94 : 0.9),
          ],
        ),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: dark ? 0.2 : 0.1),
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.22 : 0.08),
            blurRadius: dark ? 16 : 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      card = TapScale(onTap: onTap, child: card);
    }

    return card;
  }
}
