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
      () => Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                Dismissible(
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
                ),
                const SizedBox(height: 8.0),
              ],
            );
          },
          itemCount: _taskController.tasks.length,
        ),
      ),
    );
  }
}
