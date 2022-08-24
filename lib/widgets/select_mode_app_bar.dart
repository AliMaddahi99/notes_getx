import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/models/note.dart';

class SelectModeAppBar extends StatelessWidget {
  final String folderName;
  SelectModeAppBar({
    Key? key,
    this.folderName = "parent",
  }) : super(key: key);

  final AppController _appController = Get.find();
  final TaskController _taskController = Get.find();

  Stream<List<Note>> getNotes() {
    if (folderName == "parent") {
      return _appController.db.notes
          .where()
          .filter()
          .folderNameEqualTo(folderName)
          .or()
          .isFolderEqualTo(true)
          .build()
          .watch(initialReturn: true);
    } else {
      return _appController.db.notes
          .where()
          .filter()
          .folderNameEqualTo(folderName)
          .and()
          .isFolderEqualTo(false)
          .build()
          .watch(initialReturn: true);
    }
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
          child: _appController.pageViewId.value == 0
              ? StreamBuilder<List<Note>>(
                  initialData: const [],
                  stream: getNotes(),
                  builder: (context, snapshot) {
                    return IconButton(
                      onPressed: () {
                        if (_appController.selectedItems.length <
                            snapshot.data!.length) {
                          _appController.selectedItems.clear();
                          for (var note in snapshot.data!) {
                            _appController.selectedItems.add(note.id);
                          }
                        } else {
                          _appController.selectedItems.clear();
                        }
                      },
                      icon: const Icon(Icons.checklist_rounded),
                    );
                  },
                )
              : IconButton(
                  onPressed: () {
                    if (_appController.selectedItems.length <
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
