import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';

class FolderController extends GetxController {
  final TextEditingController folderTextController = TextEditingController();

  var isTextFieldEmpty = true.obs;

  Future<void> createFolder(String folderName, List<Note>? notes) async {
    if (notes != null) {
      for (var note in notes) {
        note.folderName = folderName;
      }
      await NoteDatabaseService().updateNotesInDb(notes);
    }

    var noteAsFolder = Note()
      ..title = ""
      ..note = ""
      ..dateTime =
          DateTime.now().toString().substring(0, 16).replaceAll("-", "/")
      ..folderName = folderName
      ..isFolder = true;

    await NoteDatabaseService().addNoteToDb(noteAsFolder);

    folderTextController.clear();
    isTextFieldEmpty.value = true;
  }

  void addNoteToExistingFolder(String folderName, Note note) async {
    note.folderName = folderName;

    await NoteDatabaseService().updateNoteInDb(note);
  }
}
