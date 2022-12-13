import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferencesKey {
  issueTitle,
  issueBody,
}

final sharedPreferencesProvider = Provider<SharedPreferences>((_) => throw UnimplementedError());

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) => SharedPreferencesService(ref.read));

class SharedPreferencesService {
  SharedPreferencesService(this._read);
  final Reader _read;

  Future<bool> removeByStringKey(String stringKey) async {
    return _read(sharedPreferencesProvider).remove(stringKey);
  }

  Future<bool> clearAll() async {
    return _read(sharedPreferencesProvider).clear();
  }
}
