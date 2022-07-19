import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';

class SelectModeAppBar extends StatelessWidget {
  SelectModeAppBar({Key? key}) : super(key: key);

  final NoteController _noteController = Get.find();
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Obx(
        () => Text(
          _appController.selectedItems.isEmpty
              ? "Select items"
              : "${_appController.getSelectedItemsCount()} selected",
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () {
          _appController.isSelectMode.value = false;
          _appController.selectedItems.clear();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () {
              if (_appController.selectedItems.length <
                  _noteController.notes.length) {
                _appController.selectedItems.clear();
                for (var note in _noteController.notes) {
                  _appController.selectedItems.add(note.id);
                }
              } else {
                _appController.selectedItems.clear();
              }
            },
            icon: const Icon(Icons.checklist_rounded),
          ),
        ),
      ],
    );
  }
}
