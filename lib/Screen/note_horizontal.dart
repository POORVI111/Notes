import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/Screen/note_list.dart';
import 'package:notes/strings.dart';

import '../Helper/note_widget.dart';
import '../Model/note.dart';

/*
  This class contains notes (not more than 6) that can be scrolled horizontally
 */


class NoteListHorizontal extends StatefulWidget {
  const NoteListHorizontal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NoteListHorizontalState();
  }
}

class NoteListHorizontalState extends State<NoteListHorizontal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F3F7),
        appBar: AppBar(
          title: Text(notes, style: Theme.of(context).textTheme.headline5),
          centerTitle: true,
          elevation: 0,
          shadowColor: Colors.grey,
          backgroundColor: Color(0xffF2F3F7),
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Note>('Notes').listenable(),
            builder: (context, Box box, _) {
              return box.isEmpty
                  ? Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(zeroNoteHorizontalDisplay,
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ),
                    )
                  : Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: getNotesList(context, box),
                    );
            }));
  }

  // display notes(not more than 6) in horizontal scroll view
  Widget getNotesList(BuildContext context, Box box) {
    return ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: min(box.values.length, 6),
        itemBuilder: (_, i) {
          Note note = box.getAt(i)!;

          return Row(
            children: [
              Container(
                  height: 250,
                  width: 250,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: NoteWidget(note)),

              // to view all notes(>6) --> NoteList
              if (i == 5)
                Container(
                    height: 250,
                    width: 150,
                    margin: EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => NoteList()));
                          },
                          child: const Text(
                            viewAllNotes,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ))
            ],
          );
        });
  }
}
