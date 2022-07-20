import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/screens/task/add_edit_task.dart';
import 'package:notes_getx/widgets/task/dismissible_card_listview.dart';

class TaskHome extends StatelessWidget {
  TaskHome({Key? key}) : super(key: key);

  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SizedBox(
          child: DismissibleCardListView(),
        ),
        floatingActionButton: !_taskController.isAddEditTaskScreen.value
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(
                    () => AddEditTask(),
                    opaque: false,
                  );
                  _taskController.isAddEditTaskScreen.value = true;
                },
                child: const Icon(Icons.add_rounded),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
