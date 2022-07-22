import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/widgets/task/task_item_card.dart';

class DismissibleCardListView extends StatelessWidget {
  DismissibleCardListView({Key? key}) : super(key: key);
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_taskController.tasks[index].id.toString()),
            direction: DismissDirection.endToStart,
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
            onDismissed: (_) {
              _taskController.deleteTask(_taskController.tasks[index].id);
            },
            child: TaskItemCard(
              index: index,
            ),
          );
        },
        itemCount: _taskController.tasks.length,
      ),
    );
  }
}
