import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal_webapi_authentication/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/journal.dart';
import 'screens/add_journal_screen/add_journal_screen.dart';
import 'screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogged = await verifyToken();
  runApp(MyApp(
    isLogged: isLogged,
  ));
}

Future<bool> verifyToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("accessToken");

  if (token != null) {
    return true;
  }

  return false;
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({Key? key, required this.isLogged}) : super(key: key);
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
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      initialRoute: (isLogged) ? "home" : "login",
      routes: {
        "home": (context) => const HomeScreen(),
        "login": (context) => LoginScreen()
      },
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == "add-journal") {
          final map = routeSettings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return AddJournalScreen(
                journal: map["journal"] as Journal,
                isEditing: map["is_editing"],
              );
            },
          );
        }
        return null;
      },
    );
  }
}
