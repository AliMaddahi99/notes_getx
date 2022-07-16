import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';
import 'package:notes_getx/widgets/delete_bottom_sheet.dart';

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
      leading: Obx(
        () => IconButton(
          icon: const Icon(Icons.delete_rounded),
          onPressed: _controller.selectedNote.isNotEmpty
              ? () {
                  Get.bottomSheet(
                    DeleteBottomSheet(
                      message: "Delete ${_controller.getSelectedNotesCount()}?",
                    ),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                  );
                }
              : null,
        ),
      ),
      actions: [
        IconButton(
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
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: () {
              _controller.isSelectMode.value = false;
              _controller.selectedNote.clear();
            },
          ),
        ),
      ],
    );
  }
}
