import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const _userKey = 'registered_user';
  final SharedPreferences prefs;
  UserLocalDataSourceImpl({required this.prefs});

  @override
  Future<void> saveUser(UserModel user) async {
    final map = user.toMap();
    final encoded = map.entries.map((e) => '${e.key}=${e.value}').join(';');
    await prefs.setString(_userKey, encoded);
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = prefs.getString(_userKey);
    if (userJson == null) return null;
    final map = <String, String>{};
    for (final pair in userJson.split(';')) {
      final kv = pair.split('=');
      if (kv.length == 2) map[kv[0]] = kv[1];
    }
    return UserModel.fromMap(map);
  }

  @override
  Future<void> clearUser() async {
    await prefs.remove(_userKey);
  }
}
