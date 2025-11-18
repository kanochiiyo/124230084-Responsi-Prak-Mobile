import 'package:hive/hive.dart';
import 'package:responsi/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Akses box
  final Box<UserModel> _userBox = Hive.box<UserModel>('users');
  // Session login
  static const String _sessionKey = 'logged_in_username';

  void register(String username, String password, String confirmPassword) {
    if (username.isEmpty || password.isEmpty) {
      throw Exception("Username atau password tidak boleh kosong.");
    }

    if (password.length < 6) {
      throw Exception("Password harus lebih dari 6 karakter.");
    }

    if (_userBox.containsKey(username)) {
      throw Exception("Username telah terdaftar.");
    }

    if (password != confirmPassword) {
      throw Exception("Password dan konfirmasi password tidak sama.");
    }

    final newUser = UserModel(username: username, password: password);
    _userBox.put(username, newUser);
  }

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception("Username atau password tidak boleh kosong.");
    }

    final user = _userBox.get(username);
    if (user == null) {
      throw Exception("User tidak terdaftar.");
    }

    if (password != user.password) {
      throw Exception("Password salah.");
    }

    // Set session jika berhasil login (melewati semua throw)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, username);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  // Get session
  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sessionKey);
  }
}
