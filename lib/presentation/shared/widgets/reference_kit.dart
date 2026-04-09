import 'package:flutter/material.dart';

class ReferencePalette {
  static const Color backgroundTop = Color(0xFFEFF4FF);
  static const Color backgroundBottom = Color(0xFFDCEEFF);
  static const Color surface = Colors.white;
  static const Color surfaceSoft = Color(0xFFF7F9FF);
  static const Color primary = Color(0xFF6C7FE8);
  static const Color secondary = Color(0xFF66C8C0);
  static const Color textPrimary = Color(0xFF1E2534);
  static const Color textMuted = Color(0xFF667087);
  static const Color border = Color(0xFFD8E2F6);
}

class ReferenceBackground extends StatelessWidget {
  const ReferenceBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  ReferencePalette.backgroundTop,
                  ReferencePalette.backgroundBottom,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -120,
          right: -80,
          child: _GlowOrb(
            color: ReferencePalette.primary.withValues(alpha: 0.20),
            size: 280,
          ),
        ),
        Positioned(
          bottom: -130,
          left: -85,
          child: _GlowOrb(
            color: ReferencePalette.secondary.withValues(alpha: 0.18),
            size: 250,
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}

class ReferenceCard extends StatelessWidget {
  const ReferenceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.color = ReferencePalette.surface,
    this.radius = 18,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double radius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? ReferencePalette.border),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ReferencePrimaryButton extends StatelessWidget {
  const ReferencePrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ReferencePalette.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class ReferenceSecondaryButton extends StatelessWidget {
  const ReferenceSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: ReferencePalette.primary,
          side: const BorderSide(color: ReferencePalette.primary),
          minimumSize: const Size.fromHeight(46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class ReferenceTopTitle extends StatelessWidget {
  const ReferenceTopTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: ReferencePalette.textPrimary,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: ReferencePalette.textMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...<Widget>[const SizedBox(width: 10), trailing!],
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: <Color>[color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
