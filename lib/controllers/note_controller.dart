import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_getx/models/note_model.dart';

class NoteController extends GetxController {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final FocusNode noteFocusNode = FocusNode();

  var notes = <NoteModel>[].obs;
  int _noteId = 0;

  void addNote({String? title, required String note}) {
    titleTextController.clear();
    noteTextController.clear();

    if ((title == null || title == "") && note.isEmpty) {
      Get.snackbar(
        "Empty title and note!",
        "Please at least write a title or note",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      notes.insert(
          0,
          NoteModel(
              id: _noteId, note: note, title: title, dateTime: DateTime.now()));
      _noteId++;
    }

    noteFocusNode.requestFocus();
  }

  @override
  void onInit() {
    noteFocusNode.requestFocus();
    super.onInit();
  }
}
