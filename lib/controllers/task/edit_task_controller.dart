import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';

class EditTaskController extends GetxController {
  final TextEditingController editTaskTextEditingController =
      TextEditingController();
  final FocusNode editTaskTextFieldFocusNode = FocusNode();

  final TaskController _taskController = Get.find();

  var args = Get.arguments;

  @override
  void onInit() {
    editTaskTextEditingController.text =
        _taskController.tasks.isNotEmpty ? args[1] : "Nothing!";
    editTaskTextFieldFocusNode.requestFocus();
    super.onInit();
  }
}
