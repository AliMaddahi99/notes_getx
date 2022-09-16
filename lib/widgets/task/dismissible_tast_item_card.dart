import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/widgets/task/task_item_card.dart';

class DismissibleTaskItemCard extends StatelessWidget {
  final Key key;
  final int index;

  DismissibleTaskItemCard({required this.key, required this.index});

  final AppController _appController = Get.find();
  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      dismissThresholds: const {DismissDirection.startToEnd: 1},
      direction: _appController.isSelectMode.value
          ? DismissDirection.none
          : DismissDirection.horizontal,
      key: key,
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
          _taskController.deletedTaskToUndo.add(_taskController.tasks[index]);
          Get.snackbar(
            "Task deleted",
            "Do you want to undo that?",
            mainButton: TextButton(
              onPressed: () {
                _taskController.tasks
                    .insert(index, _taskController.deletedTaskToUndo.first);
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
  }
}
