import 'package:alubank_tests/components/box_card.dart';
import 'package:alubank_tests/data/bank_http_mocks.dart';
import 'package:alubank_tests/data/bank_inherited.dart';
import 'package:alubank_tests/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  final MockBankHttp mockBankHttp = MockBankHttp();
  testWidgets('My Widget has a text "Spent', (tester) async {
    when(mockBankHttp.dolarToReal()).thenAnswer((_) async => '5.0');
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: mockBankHttp.dolarToReal()),
      ),
    ));
    final spentFinder = find.text('Spent');
    expect(spentFinder, findsOneWidget);
  });
  testWidgets('Finds a AccountStatus', (tester) async {
    when(mockBankHttp.dolarToReal()).thenAnswer((_) async => '5.0');
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: mockBankHttp.dolarToReal()),
      ),
    ));
    final progressIndicator = find.byType(LinearProgressIndicator);
    expect(progressIndicator, findsOneWidget);
  });

  testWidgets('Finds a LinearProgressIndicator', (tester) async {
    when(mockBankHttp.dolarToReal()).thenAnswer((_) async => '5.0');
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: mockBankHttp.dolarToReal()),
      ),
    ));
    expect(find.byKey(const Key('testKey')), findsOneWidget);
  });

  testWidgets('Finds 5 BoxCards', (tester) async {
    when(mockBankHttp.dolarToReal()).thenAnswer((_) async => '5.0');
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: mockBankHttp.dolarToReal()),
      ),
    ));
    expect(find.byWidgetPredicate((widget) {
      if (widget is BoxCard) {
        return true;
      }
      return false;
    }), findsNWidgets(5));
  });

  testWidgets('My widget has a text "Deposit" ', (tester) async {
    when(mockBankHttp.dolarToReal()).thenAnswer((_) async => '5.0');
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: mockBankHttp.dolarToReal()),
      ),
    ));
    final spentFinder = find.text('Deposit');
    expect(spentFinder, findsOneWidget);
  });

  testWidgets('When tap Deposit should upload earned in 10', (tester) async {
    when(mockBankHttp.dolarToReal()).thenAnswer((_) async => '5.0');
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: mockBankHttp.dolarToReal()),
      ),
    ));

    await tester.tap(find.text('Deposit'));
    await tester.tap(find.text('Earned'));
    await tester.pumpAndSettle();
    expect(find.text('\$10.0'), findsOneWidget);
  });

  testWidgets('Testing MockHttp dolarToReal', (tester) async {
    when(mockBankHttp.dolarToReal()).thenAnswer((_) async => '5.0');
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: mockBankHttp.dolarToReal()),
      ),
    ));
    verify(mockBankHttp.dolarToReal()).called(7);
  });
}
