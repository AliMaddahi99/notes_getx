import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/tasks/controllers/task_controller.dart';
import 'package:notes_getx/tasks/screens/edit_task.dart';

class TaskItemCard extends StatelessWidget {
  final int index;

  TaskItemCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final TaskController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => EditTodo(),
            arguments: [index, _controller.tasks[index].title],
          );
        },
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
            child: Row(
              children: [
                Obx(
                  () => Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      value: _controller.tasks[index].isDone,
                      onChanged: (done) {
                        var changed = _controller.tasks[index];
                        changed.isDone = done!;
                        _controller.tasks[index] = changed;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    _controller.tasks[index].title,
                    style: _controller.tasks[index].isDone
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                          )
                        : const TextStyle(
                            decoration: TextDecoration.none,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
