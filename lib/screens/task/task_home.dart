import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/screens/task/add_edit_task.dart';
import 'package:notes_getx/widgets/no_item.dart';
import 'package:notes_getx/widgets/task/dismissible_card_listview.dart';

class TaskHome extends StatelessWidget {
  TaskHome({Key? key}) : super(key: key);

  final AppController _appController = Get.find();
  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _taskController.tasks.isNotEmpty
            ? DismissibleCardListView()
            : NoItem(),
        floatingActionButton: !_appController.isSelectMode.value
            ? Visibility(
                visible: !_taskController.isAddEditTaskScreen.value,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(
                      () => AddEditTask(),
                      opaque: false,
                    );
                    _taskController.isAddEditTaskScreen.value = true;
                  },
                  child: const Icon(Icons.add_rounded),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
