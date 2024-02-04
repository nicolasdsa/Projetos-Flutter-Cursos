import 'package:alubank_tests/data/bank_http.dart';
import 'package:alubank_tests/data/bank_inherited.dart';
import 'package:alubank_tests/screens/home.dart';
import 'package:alubank_tests/themes/purple_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: purpleTheme,
      home: BankInherited(child: Home(api: BankHttp().dolarToReal())),
    );
  }
}
