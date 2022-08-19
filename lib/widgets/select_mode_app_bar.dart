import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/models/note.dart';

class SelectModeAppBar extends StatelessWidget {
  final String folderName;
  SelectModeAppBar({
    Key? key,
    this.folderName = "parent",
  }) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();
  final TaskController _taskController = Get.find();
  final FolderController _folderController = Get.find();

  List<Note> getFolderNotes() {
    List<Note> notes = [];
    for (var folder in _folderController.folders) {
      if (folder.name == folderName) {
        notes = folder.notes;
      }
    }

    return notes;
  }

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
              if (folderName == "parent" &&
                  _appController.pageViewId.value == 0 &&
                  _appController.selectedItems.length <
                      _noteController.notes.length) {
                _appController.selectedItems.clear();
                for (var note in _noteController.notes) {
                  _appController.selectedItems.add(note.id);
                }
              } else if (folderName == "parent" &&
                  _appController.pageViewId.value == 1 &&
                  _appController.selectedItems.length <
                      _taskController.tasks.length) {
                _appController.selectedItems.clear();
                for (var task in _taskController.tasks) {
                  _appController.selectedItems.add(task.id);
                }
              } else if (folderName != "parent" &&
                  _appController.selectedItems.length <
                      getFolderNotes().length) {
                _appController.selectedItems.clear();
                for (var note in getFolderNotes()) {
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
