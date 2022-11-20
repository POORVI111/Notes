import 'package:hive/hive.dart';

part 'note.g.dart';

/*
 Note model
 */

@HiveType(typeId: 1)
class Note {

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? body;

  @HiveField(2)
  DateTime? created;

  Note({this.id,this.body, this.created});

}