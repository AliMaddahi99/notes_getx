import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/tasks/controllers/task_controller.dart';

class EditTaskController extends GetxController {
  final TextEditingController editTaskTextEditingController =
      TextEditingController();
  final FocusNode editTaskTextFieldFocusNode = FocusNode();

  final TaskController _controller = Get.find();

  var args = Get.arguments;

  @override
  void onInit() {
    editTaskTextEditingController.text =
        _controller.tasks.isNotEmpty ? args[1] : "Nothing!";
    editTaskTextFieldFocusNode.requestFocus();
    super.onInit();
  }
}
