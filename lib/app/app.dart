import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jay2xcoder/core/localization/app_localizations_by_code_delegate.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/core/constants/app_constants.dart';
import 'package:jay2xcoder/core/theme/app_theme.dart';
import 'package:jay2xcoder/navigation/app_router.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class Jay2xCoderApp extends ConsumerWidget {
  Jay2xCoderApp({super.key});

  final _router = AppRouter.buildRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool darkMode = ref.watch(
      appStateControllerProvider.select((state) => state.darkMode),
    );
    final String localeCode = ref.watch(appLocaleCodeProvider);
    final Locale resolvedLocale = frameworkLocaleFromCode(localeCode);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      routerConfig: _router,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      locale: resolvedLocale,
      supportedLocales: supportedFrameworkLocales,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizationsByCodeDelegate(localeCode: localeCode),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
