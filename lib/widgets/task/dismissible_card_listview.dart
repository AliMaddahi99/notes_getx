import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/widgets/task/task_item_card.dart';

class DismissibleCardListView extends StatelessWidget {
  DismissibleCardListView({Key? key}) : super(key: key);
  final TaskController _taskController = Get.put(TaskController());
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReorderableListView.builder(
        key: const PageStorageKey<String>("tasksPage"),
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          var item = _taskController.tasks.removeAt(oldIndex);
          _taskController.tasks.insert(newIndex, item);
        },
        onReorderStart: (index) {
          _appController.isSelectMode.value = true;
          if (_appController.selectedItems.isEmpty) {
            _appController.selectItem(_taskController.tasks[index].id);
          }
        },
        padding: const EdgeInsets.all(8.0),
        itemCount: _taskController.tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            dismissThresholds: const {DismissDirection.startToEnd: 1},
            direction: _appController.isSelectMode.value
                ? DismissDirection.none
                : DismissDirection.horizontal,
            key: Key(_taskController.tasks[index].id.toString()),
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            onUpdate: (details) {
              if (details.direction == DismissDirection.startToEnd) {
                _appController.pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              }
              Get.closeCurrentSnackbar();
              _taskController.deletedTaskToUndo.clear();
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                _taskController.deletedTaskToUndo
                    .add(_taskController.tasks[index]);
                Get.snackbar(
                  "Task deleted",
                  "Do you want to undo that?",
                  mainButton: TextButton(
                    onPressed: () {
                      _taskController.tasks.insert(
                          index, _taskController.deletedTaskToUndo.first);
                      _taskController.deletedTaskToUndo.clear();
                      Get.closeCurrentSnackbar();
                    },
                    child: const Text(
                      "Undo",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  animationDuration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(20.0),
                );
                _taskController.deleteTask(_taskController.tasks[index].id);
              }
            },
            child: TaskItemCard(
              index: index,
            ),
          );
        },
      ),
    );
  }
}
