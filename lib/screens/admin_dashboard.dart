import 'package:basic_login_app/models/user.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  final User user;
  const AdminDashboard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Center(
        child: Text(
          'Hi ${user.username}!',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
