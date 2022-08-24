import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';

class AddEditNoteController extends GetxController {
  final AppController _appController = Get.find();
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final FocusNode noteFocusNode = FocusNode();

  Note? args = Get.arguments;
  var isSaveButtonVisible = false.obs;

  // void addNote({
  //   required String title,
  //   required String note,
  //   required String folderName,
  // }) {
  //   if (title.isNotEmpty || note.isNotEmpty) {
  //     var noteModel = Note(
  //       id: DateTime.now().microsecondsSinceEpoch,
  //       note: note,
  //       title: title,
  //       dateTime: dateTimeNowStringify(),
  //       folderName: folderName,
  //       isFolder: false,
  //     );

  //     if (folderName == "parent") {
  //       _noteController.notes.insert(
  //         0,
  //         noteModel,
  //       );
  //     } else {
  //       var folders = _folderController.folders.map((folder) => folder);
  //       for (var f in folders) {
  //         if (f.name == folderName) {
  //           f.notes.insert(0, noteModel);
  //         }
  //       }
  //     }

  //     // args is the note in the list
  //     // so make args = noteModel; make it possible to be editable
  //     // after adding the note
  //     // because args = null wold run addNote() again
  //     args = noteModel;
  //   }
  // }

  // void editNote() {
  //   if (titleTextController.text.isEmpty && noteTextController.text.isEmpty) {
  //     _noteController.deleteNote(_noteController.notes[args].id);
  //   } else {
  //     var edited = _noteController.notes[args];
  //     edited.title = titleTextController.text;
  //     edited.note = noteTextController.text;
  //     edited.dateTime = dateTimeNowStringify();
  //     _noteController.notes[args] = edited;
  //   }
  // }

  Future<void> addNote({
    required String title,
    required String note,
    required String folderName,
  }) async {
    if (title.isNotEmpty || note.isNotEmpty) {
      var noteModel = Note()
        ..title = title
        ..note = note
        ..dateTime = dateTimeNowStringify()
        ..folderName = folderName
        ..isFolder = false;

      await _appController.db
          .writeTxn((isar) async => await isar.notes.put(noteModel));

      // args is the note in the list
      // so make args = noteModel; make it possible to be editable
      // after adding the note
      // because args = null would run addNote() again
      args = noteModel;
      // select the added note, so it can be delete
      // right after adding it by add button in AddEditNote()
      _appController.selectItem(noteModel.id);
    }
  }

  Future<void> editNote() async {
    if (titleTextController.text.isEmpty && noteTextController.text.isEmpty) {
      await _appController.db
          .writeTxn((isar) async => await isar.notes.delete(args!.id));
    } else {
      Note newNote = args!
        ..title = titleTextController.text
        ..note = noteTextController.text
        ..dateTime = dateTimeNowStringify();
      await _appController.db
          .writeTxn((isar) async => await isar.notes.put(newNote));
    }
  }

  String dateTimeNowStringify() {
    return DateTime.now().toString().substring(0, 16).replaceAll("-", "/");
  }

  bool saveButtonVisibility() {
    return titleTextController.text.isNotEmpty ||
        noteTextController.text.isNotEmpty;
  }

  @override
  void onInit() {
    if (args != null) {
      titleTextController.text = args!.title;
      noteTextController.text = args!.note;

      isSaveButtonVisible.value = true;
    } else {
      noteFocusNode.requestFocus();
    }
    super.onInit();
  }
}
