import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/notes/controllers/note_controller.dart';
import 'package:notes_getx/notes/models/note_model.dart';

class AddEditNoteController extends GetxController {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final FocusNode noteFocusNode = FocusNode();

  var args = Get.arguments;
  var isSaveButtonVisible = false.obs;

  final NoteController _controller = Get.find();

  void addNote({required String title, required String note}) {
    if (title.isNotEmpty || note.isNotEmpty) {
      _controller.notes.insert(
        0,
        NoteModel(
          id: DateTime.now().microsecondsSinceEpoch,
          note: note,
          title: title,
          dateTime: dateTimeNowStringify(),
        ),
      );
      args = 0;
    }
  }

  void editNote() {
    if (titleTextController.text.isEmpty && noteTextController.text.isEmpty) {
      _controller.deleteNote(_controller.notes[args].id);
    } else {
      var edited = _controller.notes[args];
      edited.title = titleTextController.text;
      edited.note = noteTextController.text;
      edited.dateTime = dateTimeNowStringify();
      _controller.notes[args] = edited;
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
      titleTextController.text = _controller.notes[args].title;
      noteTextController.text = _controller.notes[args].note;
      isSaveButtonVisible.value = true;
    } else {
      noteFocusNode.requestFocus();
    }
    super.onInit();
  }
}
