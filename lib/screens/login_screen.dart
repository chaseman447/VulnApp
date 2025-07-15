import 'package:flutter/material.dart';
import '../utils/insecure_storage.dart';
import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  String _error = '';

  // Hardcoded "vulnerable" credentials
  final _hardcodedUser = "admin";
  final _hardcodedPass = "1234"; // 🚨 Not secure!

  void _login() async {
    if (_userController.text == _hardcodedUser &&
        _passController.text == _hardcodedPass) {
      await InsecureStorage.saveToken("fake_jwt_token"); // 🔓 stored plaintext
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ProfileScreen()));
    } else {
      setState(() => _error = "Incorrect username or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🔐 VulnApp Login")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(_error, style: TextStyle(color: Colors.red)),
              ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
