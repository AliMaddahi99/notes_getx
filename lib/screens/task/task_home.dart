import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/widgets/task/add_task_text_field.dart';
import 'package:notes_getx/widgets/task/dismissible_card_listview.dart';

class TaskHome extends StatelessWidget {
  TaskHome({Key? key}) : super(key: key);

  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DismissibleCardListView(),
          AddTaskTextField(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _taskController.isAddTaskTextViewVisible.value = true;
          _taskController.addTaskTextFieldFocusNode.requestFocus();
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
