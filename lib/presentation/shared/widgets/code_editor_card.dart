import 'package:flutter/material.dart';

class CodeEditorCard extends StatelessWidget {
  const CodeEditorCard({
    super.key,
    required this.controller,
    required this.languageLabel,
  });

  final TextEditingController controller;
  final String languageLabel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color editorSurface = Colors.white;
    final Color accent = Colors.black87;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
        color: editorSurface,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.terminal_rounded, size: 16, color: accent),
              const SizedBox(width: 6),
              Text(
                languageLabel,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                height: 1.4,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
              cursorColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
