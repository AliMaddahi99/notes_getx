import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/folder_model.dart';
import 'package:notes_getx/models/note_model.dart';

class FolderController extends GetxController {
  final TextEditingController folderTextController = TextEditingController();
  final NoteController _noteController = Get.find();

  var folders = <FolderModel>[].obs;
  var isTextFieldEmpty = true.obs;

  void createFolder(String folderName, List<NoteModel> notes) {
    for (var note in notes) {
      note.folderName = folderName;
    }

    folders.insert(0, FolderModel(name: folderName, notes: notes));

    _noteController.notes.insert(
      0,
      NoteModel(
        id: DateTime.now().microsecondsSinceEpoch,
        title: "",
        note: "",
        dateTime:
            DateTime.now().toString().substring(0, 16).replaceAll("-", "/"),
        folderName: folderTextController.text,
        isFolder: true,
      ),
    );

    folderTextController.clear();
    isTextFieldEmpty.value = true;

    for (var n in notes) {
      _noteController.notes.removeWhere((note) => note.id == n.id);
    }
  }

  void addNoteToExistingFolder(String folderName, NoteModel note) {
    for (var folder in folders) {
      if (folder.name == folderName) {
        note.folderName = folderName;
        folder.notes.insert(0, note);
        _noteController.notes.removeWhere((n) => n.id == note.id);
      }
    }
  }
}
