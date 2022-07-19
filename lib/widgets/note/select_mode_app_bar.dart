import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';

class SelectModeAppBar extends StatelessWidget {
  SelectModeAppBar({Key? key}) : super(key: key);

  final NoteController _noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Obx(
        () => Text(
          _noteController.selectedNote.isEmpty
              ? "Select items"
              : "${_noteController.getSelectedNotesCount()} selected",
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () {
          _noteController.isSelectMode.value = false;
          _noteController.selectedNote.clear();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () {
              if (_noteController.selectedNote.length <
                  _noteController.notes.length) {
                _noteController.selectedNote.clear();
                for (var note in _noteController.notes) {
                  _noteController.selectedNote.add(note.id);
                }
              } else {
                _noteController.selectedNote.clear();
              }
            },
            icon: const Icon(Icons.checklist_rounded),
          ),
        ),
      ],
    );
  }
}
