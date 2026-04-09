import 'package:flutter/material.dart';

class ReferencePalette {
  static const Color accentStart = Color(0xFF4A90E2);
  static const Color accentEnd = Color(0xFF8E44AD);
  static const Color textNeutral = Color(0xFF1F2937);
  static const Color mutedText = Color(0xFF64748B);
  static const Color softTeal = Color(0xFF1ABC9C);
  static const Color background = Color(0xFFF8FAFC);
  static const Color success = Color(0xFF2ECC71);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE2E8F0);
  static const Color codeBackground = Color(0xFF111827);

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color onSurface(BuildContext context) {
    return isDark(context) ? const Color(0xFFF3F4F6) : textNeutral;
  }

  static Color onMuted(BuildContext context) {
    return isDark(context) ? const Color(0xFF9CA3AF) : mutedText;
  }

  static Color card(BuildContext context) {
    return isDark(context) ? const Color(0xFF111827) : surface;
  }

  static Color cardBorder(BuildContext context) {
    return isDark(context) ? const Color(0xFF334155) : border;
  }

  static Color surfaceSoft(BuildContext context) {
    return isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF1F5FF);
  }
}

class ReferenceBackground extends StatelessWidget {
  const ReferenceBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bool dark = ReferencePalette.isDark(context);

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: dark
                    ? const <Color>[Color(0xFF0B1222), Color(0xFF0F172A)]
                    : const <Color>[
                        ReferencePalette.background,
                        Color(0xFFF1F5FF),
                      ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -180,
          right: -120,
          child: _GlowOrb(
            color: ReferencePalette.accentStart.withValues(
              alpha: dark ? 0.18 : 0.20,
            ),
            size: 340,
          ),
        ),
        Positioned(
          bottom: -180,
          left: -120,
          child: _GlowOrb(
            color: ReferencePalette.accentEnd.withValues(
              alpha: dark ? 0.14 : 0.18,
            ),
            size: 340,
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
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.radius = 24,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double radius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final bool dark = ReferencePalette.isDark(context);
    final Color resolvedColor = color ?? ReferencePalette.card(context);
    final bool onLightSurface = resolvedColor.computeLuminance() > 0.72;
    final Color defaultTextColor = onLightSurface
        ? ReferencePalette.textNeutral
        : ReferencePalette.onSurface(context);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? ReferencePalette.cardBorder(context),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.24 : 0.07),
            blurRadius: dark ? 18 : 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: IconTheme(
        data: IconThemeData(color: defaultTextColor),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: defaultTextColor),
          child: child,
        ),
      ),
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
    final BorderRadius borderRadius = BorderRadius.circular(24);

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: onPressed == null
                ? const Color(0xFF94A3B8)
                : ReferencePalette.accentStart,
            borderRadius: borderRadius,
            border: Border.all(
              color: onPressed == null
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF2563EB),
            ),
            boxShadow: onPressed == null
                ? const <BoxShadow>[]
                : <BoxShadow>[
                    BoxShadow(
                      color: ReferencePalette.accentStart.withValues(
                        alpha: 0.26,
                      ),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: borderRadius,
            child: SizedBox(
              height: 52,
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
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
          foregroundColor: ReferencePalette.accentStart,
          side: BorderSide(
            color: ReferencePalette.accentStart.withValues(alpha: 0.55),
          ),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
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
                  color: ReferencePalette.onSurface(context),
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                ),
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: ReferencePalette.onMuted(context),
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
