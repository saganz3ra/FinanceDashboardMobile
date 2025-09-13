// Classe utilitária para salvar e recuperar dados de usuário localmente
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserStorage {
  static const String _userKey = 'registered_user';

  // Salva os dados do usuário como um Map convertido para String (JSON)
  static Future<void> saveUser(Map<String, String> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = userData.entries
        .map((e) => '${e.key}=${e.value}')
        .join(';');
    await prefs.setString(_userKey, userJson);
  }

  // Recupera os dados do usuário como Map<String, String>
  static Future<Map<String, String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) return null;
    final map = <String, String>{};
    for (final pair in userJson.split(';')) {
      final kv = pair.split('=');
      if (kv.length == 2) map[kv[0]] = kv[1];
    }
    return map;
  }

  // Remove o usuário salvo
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
