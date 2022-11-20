import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../Model/note.dart';

// note layout

Widget NoteWidget(Note note) {
  return Container(
    padding: EdgeInsets.all(10.0),
    margin: EdgeInsets.only(bottom: 15.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 25, // Image radius
                backgroundImage: AssetImage('assets/person.png'),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "username",
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      timeago.format(note.created!, locale: 'en_short'),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: Container(
            child: Text(
              note.body!,
              maxLines: 10,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    ),
  );
}
