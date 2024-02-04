import 'package:alubank_tests/data/bank_inherited.dart';
import 'package:alubank_tests/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('My Widget has a text "Spent', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BankInherited(child: const Home())));
    final spentFinder = find.text('Spent');
    expect(spentFinder, findsOneWidget);
  });
  testWidgets('Finds a AccountStatus', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BankInherited(child: const Home())));
    final progressIndicator = find.byType(LinearProgressIndicator);
    expect(progressIndicator, findsOneWidget);
  });

  testWidgets('Finds a LinearProgressIndicator', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BankInherited(child: const Home())));
    expect(find.byKey(const Key('testKey')), findsOneWidget);
  });
}
