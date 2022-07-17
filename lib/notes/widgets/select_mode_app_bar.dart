import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/notes/controllers/note_controller.dart';

class SelectModeAppBar extends StatelessWidget {
  SelectModeAppBar({Key? key}) : super(key: key);

  final NoteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Obx(
        () => Text(
          _controller.selectedNote.isEmpty
              ? "Select items"
              : "${_controller.getSelectedNotesCount()} selected",
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () {
          _controller.isSelectMode.value = false;
          _controller.selectedNote.clear();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () {
              if (_controller.selectedNote.length < _controller.notes.length) {
                _controller.selectedNote.clear();
                for (var note in _controller.notes) {
                  _controller.selectedNote.add(note.id);
                }
              } else {
                _controller.selectedNote.clear();
              }
            },
            icon: const Icon(Icons.checklist_rounded),
          ),
        ),
      ],
    );
  }
}
