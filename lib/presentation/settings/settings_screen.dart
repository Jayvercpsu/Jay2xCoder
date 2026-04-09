import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/section_header.dart';
import 'package:jay2xcoder/presentation/shared/widgets/soft_card.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;
    final state = ref.watch(appStateControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: Stack(
        children: <Widget>[
          const DevBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SectionHeader(title: l10n.settingsTitle),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      children: <Widget>[
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.settingsDarkMode),
                          subtitle: Text(l10n.settingsDarkModeSubtitle),
                          value: state.darkMode,
                          onChanged: (bool value) async {
                            await ref
                                .read(appStateControllerProvider.notifier)
                                .toggleDarkMode(value);
                          },
                        ),
                        const Divider(height: 1),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.settingsNotifications),
                          subtitle: Text(l10n.settingsNotificationsSubtitle),
                          value: state.notificationsEnabled,
                          onChanged: (bool value) async {
                            await ref
                                .read(appStateControllerProvider.notifier)
                                .toggleNotifications(value);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.settingsLanguage),
                          subtitle: Text(l10n.settingsLanguageSubtitle),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(languageLabel(l10n, state.localeCode)),
                              const SizedBox(width: 6),
                              const Icon(Icons.keyboard_arrow_right_rounded),
                            ],
                          ),
                          onTap: () => _showLanguageSheet(
                            context,
                            ref,
                            state.localeCode,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.settingsProgressControls,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.settingsProgressDescription,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _confirmReset(context, ref),
                            icon: const Icon(Icons.restart_alt_rounded),
                            label: Text(l10n.settingsResetProgress),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.settingsAbout,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(l10n.appName),
                        const SizedBox(height: 2),
                        Text(l10n.appSubtitle),
                        const SizedBox(height: 8),
                        Text(
                          l10n.settingsAboutDescription,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageSheet(
    BuildContext context,
    WidgetRef ref,
    String selectedCode,
  ) async {
    final l10n = context.l10n;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(l10n.languageEnglish),
                trailing: selectedCode == 'en'
                    ? const Icon(Icons.check_rounded)
                    : null,
                onTap: () async {
                  await ref
                      .read(appStateControllerProvider.notifier)
                      .updateLocale('en');
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text(l10n.languageBisaya),
                trailing: selectedCode == 'ceb'
                    ? const Icon(Icons.check_rounded)
                    : null,
                onTap: () async {
                  await ref
                      .read(appStateControllerProvider.notifier)
                      .updateLocale('ceb');
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text(l10n.languageFilipino),
                trailing: selectedCode == 'fil'
                    ? const Icon(Icons.check_rounded)
                    : null,
                onTap: () async {
                  await ref
                      .read(appStateControllerProvider.notifier)
                      .updateLocale('fil');
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.settingsResetDialogTitle),
          content: Text(l10n.settingsResetDialogMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.commonCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.commonReset),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await ref.read(appStateControllerProvider.notifier).resetProgress();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.settingsResetSuccess)));
      }
    }
  }
}
