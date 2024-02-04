import 'package:alubank_tests/components/sections/actions.dart';
import 'package:alubank_tests/components/sections/header.dart';
import 'package:alubank_tests/components/sections/points_exchange.dart';
import 'package:alubank_tests/components/sections/recent_activities.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({required this.api, Key? key}) : super(key: key);
  final Future<String> api;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Header(api: this.api), // cuidado com o const
            const RecentActivity(),
            const ActionsSection(),
            const PointsExchange(),
          ],
        ),
      ),
    );
  }
}
