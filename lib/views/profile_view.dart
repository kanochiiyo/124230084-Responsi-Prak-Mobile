import 'package:flutter/material.dart';
import 'package:responsi/controllers/auth_controller.dart';
import 'package:responsi/views/auth/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthController authController = AuthController();
  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final username = await authController.getUser();
    if (mounted) {
      setState(() {
        _username = username ?? "Tidak ditemukan";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
            SizedBox(height: 20),
            Text(
              "Andini Andaresta",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Text(
              "124230084",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Logged in as: $_username", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await authController.logout();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
