import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:basic_login_app/models/user.dart';
import 'package:basic_login_app/screens/admin_dashboard.dart';
import 'package:basic_login_app/screens/visitor_dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  Future<void> _login() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: _usernameTextController.text)
        .where('password', isEqualTo: _passwordTextController.text)
        .get()
        .then((snapshot) {
      if (snapshot.docs.length == 1) {
        User user = User.fromJson(snapshot.docs[0].data());

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => user.isAdmin
                  ? AdminDashboard(user: user)
                  : VisitorDashboard(user: user)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Wrong username or password!'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 320,
              color: const Color(0xFF3F72AF),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                const SizedBox(height: 180),
                const Text(
                  'Welcome',
                  style: TextStyle(
                    color: Color(0xFFF9F7F7),
                    fontSize: 48,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9F7F7),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameTextController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Username',
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _passwordTextController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: 'Password',
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 48),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _login();
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFF3F72AF)),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Color(0xFF3F72AF),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
