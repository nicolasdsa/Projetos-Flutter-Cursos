import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal_webapi/models/journal.dart';
import 'package:journal_webapi/screens/home_screen/add_journal_screen.dart';
import 'package:journal_webapi/services/journal_service.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  JournalService service = JournalService();
  service.register(Journal(
      id: 'id',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      content: "Teste"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      initialRoute: "home",
      routes: {
        "home": (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "add-journal") {
          final Journal journal = settings.arguments as Journal;
          return MaterialPageRoute(
            builder: (context) => AddJournalScreen(
              journal: journal,
            ),
          );
        }
        return null;
      },
    );
  }
}
