import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              Get.to(() => const AuthLoginScreen());
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
