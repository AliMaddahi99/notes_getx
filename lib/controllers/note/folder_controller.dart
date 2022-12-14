import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';

class FolderController extends GetxController {
  final TextEditingController folderTextController = TextEditingController();

  var isTextFieldEmpty = true.obs;
  var isFolderScreenOpen = false.obs;

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

  Future<void> addNoteToExistingFolder(
      String folderName, List<Note> notes) async {
    for (var note in notes) {
      note.folderName = folderName;
    }

    await NoteDatabaseService().updateNotesInDb(notes);
  }

  Future<void> renameFolder(String newFolderName, List<Note> notes) async {
    for (var note in notes) {
      note.folderName = newFolderName;
    }
    await NoteDatabaseService().updateNotesInDb(notes);

    folderTextController.clear();
    isTextFieldEmpty.value = true;
  }
}
