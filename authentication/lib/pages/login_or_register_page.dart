import 'package:authentication/pages/login_page.dart';
import 'package:authentication/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOnRegister extends StatefulWidget {
  const LoginOnRegister({super.key});

  @override
  State<LoginOnRegister> createState() => _LoginOnRegisterState();
}

class _LoginOnRegisterState extends State<LoginOnRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
