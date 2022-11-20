import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/Helper/alert_dialog.dart';
import 'package:notes/strings.dart';
import 'package:uuid/uuid.dart';

import '../Model/note.dart';
import '../colors.dart';

/*
 add a note to hive database
 */

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late TextEditingController _noteController;

  @override
  void initState() {
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    clearText();
    _noteController.dispose();
    super.dispose();
  }

  void clearText() {
    _noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(addNote, style: Theme.of(context).textTheme.headline5),
        centerTitle: true,
        leading: IconButton(
            splashRadius: 22,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            splashRadius: 22,
            icon: Icon(
              Icons.save,
              color: Colors.black,
            ),
            onPressed: () {
              if (_noteController.text.trim().isNotEmpty)
              {
                var box = Hive.box<Note>(ALL_NOTES);
                var uuid = Uuid();
                var note = Note(
                    id: uuid.v1().toString(),
                    body: _noteController.text,
                    created: DateTime.now());

                box.add(note);
                clearText();
                Navigator.pop(context);
              }
              else
              {
                // alert in case of empty note
                alertDialog(
                    context: context,
                    title: emptyNote,
                    message: noteIsRequired);
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                TextWriteNote(controller: _noteController),
                SizedBox(height: 20.0),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextWriteNote extends StatelessWidget {
  final TextEditingController controller;

  const TextWriteNote({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        controller: controller,
        maxLines: 8,
        maxLength: 100,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: writeNote,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
