import 'package:isar/isar.dart';

part 'note.g.dart';

@Collection()
class Note {
  @Id()
  int id = Isar.autoIncrement;
  late String title;
  late String note;
  late String dateTime;
  late bool isFolder;
  late String folderName;
}
