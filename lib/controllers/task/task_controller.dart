import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_getx/models/task_model.dart';

class TaskController extends GetxController {
  final TextEditingController addTaskTextEditingController =
      TextEditingController();
  final FocusNode addTaskTextFieldFocusNode = FocusNode();

  var isTextFieldNotEmpty = false.obs;
  var tasks = <TaskModel>[].obs;
  var isAddTaskTextViewVisible = false.obs;

  void addTask({required String title}) {
    addTaskTextEditingController.clear();

    isTextFieldNotEmpty.value = false;

    tasks.insert(
        0, TaskModel(id: DateTime.now().microsecondsSinceEpoch, title: title));

    addTaskTextFieldFocusNode.requestFocus();
  }

  void deleteTask({required int id}) {
    tasks.removeAt(id);
  }

  @override
  void onInit() {
    var storedTasks = GetStorage().read<List>("tasks");
    if (storedTasks != null) {
      tasks = storedTasks.map((e) => TaskModel.fromJson(e)).toList().obs;
    }

    ever(tasks, (_) {
      GetStorage().write("tasks", tasks.toList());
    });
    super.onInit();
  }
}
