import 'package:flutter/material.dart';
import 'package:yakal/screens/Auth/auth_login_screen.dart'; // Import the AuthLoginScreen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Profile'),
          const SizedBox(height: 20), // Add some spacing
          ElevatedButton(
            onPressed: () {
              // 만약 뒤로 못돌아가게 하고 싶으면 Navigator.pushReplacement 사용
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AuthLoginScreen()),
              );
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
