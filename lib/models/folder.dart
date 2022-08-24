import 'package:isar/isar.dart';

part 'folder.g.dart';

@Collection()
class Folder {
  @Id()
  int id = Isar.autoIncrement;
  late String folderName;
}
