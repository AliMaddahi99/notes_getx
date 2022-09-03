import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/models/task.dart';

class AddEditTaskController extends GetxController {
  final TextEditingController taskTextController = TextEditingController();
  var isTextFieldNotEmpty = false.obs;
  var args = Get.arguments;

  final TaskController _taskController = Get.find();

  void addTask({required String title}) {
    if (taskTextController.text.isNotEmpty) {
      taskTextController.clear();
      isTextFieldNotEmpty.value = false;

      _taskController.tasks.insert(
          0, Task(id: DateTime.now().microsecondsSinceEpoch, title: title));
    }
  }

  void editTask() {
    if (taskTextController.text.isEmpty) {
      _taskController.deleteTask(_taskController.tasks[args].id);
    } else {
      var edited = _taskController.tasks[args];
      edited.title = taskTextController.text;
      _taskController.tasks[args] = edited;
    }
  }

  void addOrEdit() {
    if (args == null) {
      addTask(title: taskTextController.text);
    } else {
      editTask();
    }

    Get.back();
    _taskController.isAddEditTaskScreen.value = false;
  }

  @override
  void onInit() {
    if (args != null) {
      taskTextController.text = _taskController.tasks[args].title;
      isTextFieldNotEmpty.value = true;
    }
    super.onInit();
  }
}
