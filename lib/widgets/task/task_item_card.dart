import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/screens/task/add_edit_task.dart';

class TaskItemCard extends StatelessWidget {
  final int index;

  TaskItemCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Obx(
        () => GestureDetector(
          onTap: () {
            Get.to(
              () => AddEditTask(),
              opaque: false,
              arguments: index,
            );
            _taskController.isAddEditTaskScreen.value = true;
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
              child: Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      value: _taskController.tasks[index].isDone,
                      onChanged: (done) {
                        var changed = _taskController.tasks[index];
                        changed.isDone = done!;
                        _taskController.tasks[index] = changed;
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _taskController.tasks[index].title,
                      style: _taskController.tasks[index].isDone
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            )
                          : const TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
