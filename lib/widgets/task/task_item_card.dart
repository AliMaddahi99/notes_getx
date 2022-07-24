import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/screens/task/add_edit_task.dart';

class TaskItemCard extends StatelessWidget {
  final int index;
  TaskItemCard({Key? key, required this.index}) : super(key: key);

  final AppController _appController = Get.find();
  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Obx(
        () => InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(16.0),
          onTap: () {
            if (_appController.isSelectMode.value) {
              _appController.selectItem(_taskController.tasks[index].id);
            } else {
              _taskController.isAddEditTaskScreen.value = true;
              _appController.selectedItems.clear();
              Get.to(
                () => AddEditTask(),
                opaque: false,
                arguments: index,
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(0.0, 13.0, 4.0, 14.0),
            child: Row(
              children: [
                Obx(
                  () => !_appController.isSelectMode.value
                      ? Checkbox(
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
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ReorderableDragStartListener(
                            index: index,
                            child: const Icon(Icons.drag_handle_rounded),
                          ),
                        ),
                ),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
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
                Visibility(
                  visible: _appController.isSelectMode.value,
                  child: Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      splashRadius: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      value: _appController.selectedItems
                          .contains(_taskController.tasks[index].id),
                      onChanged: (checked) {
                        _appController
                            .selectItem(_taskController.tasks[index].id);
                      },
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
