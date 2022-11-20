import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/Screen/add_note.dart';
import 'package:notes/Helper/note_widget.dart';
import 'package:notes/Screen/note_horizontal.dart';
import 'package:notes/strings.dart';
import '../Model/note.dart';
import '../colors.dart';

/*
  This class contains all notes in grid view
 */

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: myAppBar(),
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Note>('Notes').listenable(),
            builder: (context, Box box, _) {
              return box.isEmpty
                  ? Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(zeroNote,
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ),
                    )
                  : Container(
                      child: getNotesList(context, box),
                    );
            }));
  }

  //display all notes in grid view
  Widget getNotesList(BuildContext context, Box box) {
    return GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 2.0,
            crossAxisSpacing: 10,
            maxCrossAxisExtent: 250,
            mainAxisExtent: 250),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: box.values.length,
        itemBuilder: (_, i) {
          Note note = box.getAt(i)!;

          return GestureDetector(
              child: Dismissible(
                  key: Key(note.id!),
                  background: Container(),
                  direction: DismissDirection.endToStart,
                  secondaryBackground: Container(
                    padding: EdgeInsets.only(right: 35.0),
                    margin: EdgeInsets.only(bottom: 15.0),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0))),
                    child: Icon(Icons.delete_sweep_rounded,
                        color: Colors.white, size: 40),
                  ),
                  onDismissed: (direction) async {
                    box.deleteAt(i);
                  },
                  child: NoteWidget(note)));
        });
  }


  PreferredSizeWidget myAppBar() {
    return AppBar(
      title: Text(notes, style: Theme.of(context).textTheme.headline5),
      centerTitle: true,
      elevation: 0,
      shadowColor: Colors.grey,
      backgroundColor: backgroundColor,
      leading: IconButton(
          splashRadius: 22,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      actions: <Widget>[
        IconButton(
          splashRadius: 22,
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNote()));
          },
        )
      ],
    );
  }
}
