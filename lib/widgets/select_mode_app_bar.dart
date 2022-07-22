import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';

class SelectModeAppBar extends StatelessWidget {
  SelectModeAppBar({Key? key}) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();
  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Obx(
        () => Text(
          _appController.selectedItems.isEmpty
              ? "Select items"
              : "${_appController.getSelectedItemsCount("item")} selected",
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
              if (_appController.pageViewId.value == 0 &&
                  _appController.selectedItems.length <
                      _noteController.notes.length) {
                _appController.selectedItems.clear();
                for (var note in _noteController.notes) {
                  _appController.selectedItems.add(note.id);
                }
              } else if (_appController.pageViewId.value == 1 &&
                  _appController.selectedItems.length <
                      _taskController.tasks.length) {
                _appController.selectedItems.clear();
                for (var task in _taskController.tasks) {
                  _appController.selectedItems.add(task.id);
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
