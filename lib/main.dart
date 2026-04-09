import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jay2xcoder/app/app.dart';
import 'package:jay2xcoder/data/models/app_state.dart';
import 'package:jay2xcoder/data/storage/local_storage_service.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final LocalStorageService storage = LocalStorageService();
  await storage.init();
  final AppState initialState = await storage.loadState();

  runApp(
    ProviderScope(
      overrides: <Override>[
        localStorageProvider.overrideWithValue(storage),
        initialAppStateProvider.overrideWithValue(initialState),
      ],
      child: Jay2xCoderApp(),
    ),
  );
}
