import 'package:hive_flutter/hive_flutter.dart';
import 'package:jay2xcoder/data/models/app_state.dart';

class LocalStorageService {
  static const String _boxName = 'jay2xcoder_box';
  static const String _stateKey = 'app_state';

  late final Box<dynamic> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<dynamic>(_boxName);
  }

  Future<AppState> loadState() async {
    final dynamic raw = _box.get(_stateKey);
    if (raw is Map) {
      return AppState.fromMap(raw);
    }
    return AppState.initial();
  }

  Future<void> saveState(AppState state) async {
    await _box.put(_stateKey, state.toMap());
  }

  Future<void> resetState() async {
    await _box.put(_stateKey, AppState.initial().toMap());
  }
}
