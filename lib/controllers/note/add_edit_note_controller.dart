import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note_model.dart';

class AddEditNoteController extends GetxController {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final FocusNode noteFocusNode = FocusNode();

  var args = Get.arguments;
  var isSaveButtonVisible = false.obs;

  final NoteController _noteController = Get.find();

  void addNote({
    required String title,
    required String note,
    String folder = "parent",
  }) {
    if (title.isNotEmpty || note.isNotEmpty) {
      _noteController.notes.insert(
        0,
        NoteModel(
          id: DateTime.now().microsecondsSinceEpoch,
          note: note,
          title: title,
          dateTime: dateTimeNowStringify(),
          folder: folder,
        ),
      );

      // args is index of note in the list
      // so make args = 0; make it possible to be editable after adding the note
      // because the note is added to index 0
      args = 0;
    }
  }

  void editNote() {
    if (titleTextController.text.isEmpty && noteTextController.text.isEmpty) {
      _noteController.deleteNote(_noteController.notes[args].id);
    } else {
      var edited = _noteController.notes[args];
      edited.title = titleTextController.text;
      edited.note = noteTextController.text;
      edited.dateTime = dateTimeNowStringify();
      _noteController.notes[args] = edited;
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
      titleTextController.text = _noteController.notes[args].title;
      noteTextController.text = _noteController.notes[args].note;
      isSaveButtonVisible.value = true;
    } else {
      noteFocusNode.requestFocus();
    }
    super.onInit();
  }
}
