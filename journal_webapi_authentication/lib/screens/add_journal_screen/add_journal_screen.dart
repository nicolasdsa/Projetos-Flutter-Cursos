import 'dart:io';

import 'package:flutter/material.dart';
import 'package:journal_webapi_authentication/helpers/logout.dart';
import 'package:journal_webapi_authentication/screens/common/exception_dialog.dart';
import '../../helpers/weekday.dart';
import '../../models/journal.dart';
import '../../services/journal_service.dart';

class AddJournalScreen extends StatefulWidget {
  final Journal journal;
  final bool isEditing;
  const AddJournalScreen({
    Key? key,
    required this.journal,
    required this.isEditing,
  }) : super(key: key);

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    contentController.text = widget.journal.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WeekDay(widget.journal.createdAt).toString()),
        actions: [
          IconButton(
            onPressed: () {
              registerJournal(context);
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: contentController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 24),
          expands: true,
          maxLines: null,
          minLines: null,
        ),
      ),
    );
  }

  registerJournal(BuildContext context) async {
    JournalService journalService = JournalService();
    widget.journal.content = contentController.text;

    if (widget.isEditing) {
      journalService.edit(widget.journal.id, widget.journal).then((value) {
        if (value) {
          Navigator.pop(context, DisposeStatus.success);
        } else {
          Navigator.pop(context, DisposeStatus.error);
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
    } else {
      journalService.register(widget.journal).then((value) {
        if (value) {
          Navigator.pop(context, DisposeStatus.success);
        } else {
          Navigator.pop(context, DisposeStatus.error);
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
  }
}

enum DisposeStatus { exit, error, success }
