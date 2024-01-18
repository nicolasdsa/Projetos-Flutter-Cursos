import 'dart:io';

import 'package:flutter/material.dart';
import 'package:journal_webapi_authentication/helpers/logout.dart';
import 'package:journal_webapi_authentication/screens/common/exception_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/journal.dart';
import '../../services/journal_service.dart';
import 'widgets/home_screen_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // O último dia apresentado na lista
  DateTime currentDay = DateTime.now();

  // Tamanho da lista
  int windowPage = 10;

  // A base de dados mostrada na lista
  Map<String, Journal> database = {};

  final ScrollController _listScrollController = ScrollController();
  final JournalService _journalService = JournalService();

  String? userId;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título basado no dia atual
        title: Text(
          "${currentDay.day}  |  ${currentDay.month}  |  ${currentDay.year}",
        ),
        actions: [
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            onTap: () {
              logout(context);
            },
            title: const Text("Sair"),
            leading: const Icon(Icons.logout),
          )
        ],
      )),
      body: (userId != null)
          ? ListView(
              controller: _listScrollController,
              children: generateListJournalCards(
                userId: userId!,
                windowPage: windowPage,
                currentDay: currentDay,
                database: database,
                refreshFunction: refresh,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void refresh() async {
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString('accessToken');
      String? id = prefs.getString('id');
      String? email = prefs.getString('email');

      if (token != null && id != null && email != null) {
        _journalService
            .getAll(id: id, token: token)
            .then((List<Journal> listJournal) {
          setState(() {
            userId = id;
            database = {};
            for (Journal journal in listJournal) {
              database[journal.id] = journal;
            }

            if (_listScrollController.hasClients) {
              final double position =
                  _listScrollController.position.maxScrollExtent;
              _listScrollController.jumpTo(position);
            }
          });
        });
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    }).catchError(
      (error) {
        logout(context);
      },
      test: (error) => error is UnauthorizedException,
    ).catchError(
      (error) {
        var innerError = error as HttpException;
        showExceptionDialog(context, content: innerError.message);
      },
      test: (error) => error is HttpException,
    );
  }

  /*void refresh() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("accessToken");
      String? id = prefs.getString("id");

      if (token == null && id == null && mounted) {
        Navigator.pushReplacementNamed(context, "login");
      }

      List<Journal> listJournal =
          await _journalService.getAll(id: id, token: token);
      if (mounted) {
        setState(() {
          userId = id;
          database = {};
          for (Journal journal in listJournal) {
            database[journal.id] = journal;
          }

          if (_listScrollController.hasClients) {
            final double position =
                _listScrollController.position.maxScrollExtent;
            _listScrollController.jumpTo(position);
          }
        });
      }
    } on UnauthorizedException {
      if (mounted) {
        Navigator.pushReplacementNamed(context, "login");
      }
    }
  }*/
}
