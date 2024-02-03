import 'package:alubank_tests/components/sections/actions.dart';
import 'package:alubank_tests/components/sections/header.dart';
import 'package:alubank_tests/components/sections/points_exchange.dart';
import 'package:alubank_tests/components/sections/recent_activities.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            Header(), // cuidado com o const
            RecentActivity(),
            ActionsSection(),
            PointsExchange(),
          ],
        ),
      ),
    );
  }
}
