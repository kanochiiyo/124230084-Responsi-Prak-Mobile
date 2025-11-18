import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi/models/user_model.dart';
import 'package:responsi/views/auth/login_view.dart';
import 'package:responsi/views/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('users');

  // Jalankan build runner abis ini di terminal
  // flutter pub run build_runner build

  // Cek session
  final prefs = await SharedPreferences.getInstance();
  final String? loggedInUser = prefs.getString('logged_in_username');
  runApp(MyApp(loggedInUser: loggedInUser));
}

class MyApp extends StatelessWidget {
  final String? loggedInUser;
  const MyApp({super.key, this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loggedInUser == null
          ? LoginView()
          : BottomNavigationBarExampleApp(),
    );
  }
}
