import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_service.dart';

class AddEditNoteController extends GetxController {
  final AppController _appController = Get.find();
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final FocusNode noteFocusNode = FocusNode();

  Note? args = Get.arguments;
  var isSaveButtonVisible = false.obs;

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

      await NoteService().addNoteToDb(noteModel);

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
      await NoteService().deleteNotesFromDb([args!.id]);
    } else {
      Note newNote = args!
        ..title = titleTextController.text
        ..note = noteTextController.text
        ..dateTime = dateTimeNowStringify();

      await NoteService().updateNoteInDb(newNote);
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
