import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/folder.dart';
import 'package:notes_getx/models/note.dart';

class FolderController extends GetxController {
  final AppController _appController = Get.find();
  final TextEditingController folderTextController = TextEditingController();

  var isTextFieldEmpty = true.obs;

  Future<void> createFolder(String folderName, List<Note> notes) async {
    for (var note in notes) {
      note.folderName = folderName;
    }
    await _appController.db.writeTxn((isar) async {
      return await isar.notes.putAll(notes);
    });

    var folderModel = Folder()..folderName = folderName;

    await _appController.db
        .writeTxn((isar) async => await isar.folders.put(folderModel));

    var noteModel = Note()
      ..title = ""
      ..note = ""
      ..dateTime =
          DateTime.now().toString().substring(0, 16).replaceAll("-", "/")
      ..folderName = folderName
      ..isFolder = true;

    await _appController.db
        .writeTxn((isar) async => await isar.notes.put(noteModel));

    folderTextController.clear();
    isTextFieldEmpty.value = true;
  }

  void addNoteToExistingFolder(String folderName, Note note) async {
    note.folderName = folderName;
    await _appController.db
        .writeTxn((isar) async => await isar.notes.put(note));
  }
}
