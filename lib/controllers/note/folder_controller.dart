import 'package:get/get.dart';
import 'package:notes_getx/models/folder_model.dart';
import 'package:notes_getx/models/note_model.dart';

class FolderController extends GetxController {
  var folders = <FolderModel>[].obs;

  void createFolder(String folderName, List<NoteModel> notes) {
    folders.insert(0, FolderModel(name: folderName, notes: notes));
  }
}
