import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/screens/task/add_edit_task.dart';
import 'package:notes_getx/widgets/app/add_fab.dart';
import 'package:notes_getx/widgets/app/no_item.dart';
import 'package:notes_getx/widgets/task/reorderable_task_card_listview.dart';

class TaskHome extends StatelessWidget {
  TaskHome({Key? key}) : super(key: key);

  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _taskController.tasks.isNotEmpty
            ? ReorderableTaskCardListView()
            : NoItem(),
        floatingActionButton: Visibility(
          visible: !_taskController.isAddEditTaskScreen.value,
          child: AddFAB(
            onPressed: () {
              Get.to(
                () => AddEditTask(),
                opaque: false,
              );
              _taskController.isAddEditTaskScreen.value = true;
            },
            tooltip: "Add task",
          ),
        ),
      ),
    );
  }
}
