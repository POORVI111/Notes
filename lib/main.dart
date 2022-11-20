import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/Screen/note_horizontal.dart';
import 'package:notes/Screen/note_list.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/strings.dart';

import 'Model/note.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>(ALL_NOTES);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: NoteListHorizontal());
  }
}
