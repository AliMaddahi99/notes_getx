import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/widgets/task/task_item_card.dart';

class SlidableCardListView extends StatelessWidget {
  SlidableCardListView({Key? key}) : super(key: key);
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SlidableAutoCloseBehavior(
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _taskController.tasks.length,
          itemBuilder: (context, index) {
            return Slidable(
              groupTag: "0",
              key: Key(_taskController.tasks[index].id.toString()),
              endActionPane: ActionPane(
                extentRatio: 0.18,
                motion: const ScrollMotion(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        _taskController
                            .deleteTask(_taskController.tasks[index].id);
                      },
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
                  ),
                ],
              ),
              child: TaskItemCard(
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}
