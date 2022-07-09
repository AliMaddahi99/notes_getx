import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_getx/models/note_model.dart';

class NoteController extends GetxController {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final FocusNode noteFocusNode = FocusNode();

  var notes = <NoteModel>[].obs;
  int _noteId = 0;
  var isGridView = false.obs;

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
          id: _noteId,
          note: note,
          title: title,
          dateTime: dateTimeNowStringify(),
        ),
      );
      _noteId++;
    }

    noteFocusNode.requestFocus();
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }

  String dateTimeNowStringify() {
    return DateTime.now().toString().substring(0, 16).replaceAll("-", "/");
  }

  @override
  void onInit() {
    // Save and read notes
    var storedNotes = GetStorage().read<List>("notes");
    if (storedNotes != null) {
      notes = storedNotes.map((e) => NoteModel.fromJson(e)).toList().obs;
    }
    ever(notes, (_) {
      GetStorage().write("notes", notes.toList());
    });

    // Save and read Layout mode, Gridview/Listview
    var layoutIsGridView = GetStorage().read("layout");
    if (layoutIsGridView != null) {
      isGridView.value = layoutIsGridView;
    }
    ever(isGridView, (_) {
      GetStorage().write("layout", isGridView.value);
    });

    super.onInit();
  }
}
