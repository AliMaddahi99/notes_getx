import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/widgets/task/dismissible_task_item_card.dart';

class ReorderableTaskCardListView extends StatelessWidget {
  ReorderableTaskCardListView({Key? key}) : super(key: key);

  final TaskController _taskController = Get.put(TaskController());
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          shadowColor: Colors.white,
        ),
        child: ReorderableListView.builder(
          key: const PageStorageKey<String>("tasksPage"),
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var item = _taskController.tasks.removeAt(oldIndex);
            _taskController.tasks.insert(newIndex, item);
          },
          onReorderStart: (index) {
            _appController.isSelectMode.value = true;
            if (_appController.selectedItems.isEmpty) {
              _appController.selectItem(_taskController.tasks[index].id);
            }
          },
          padding: const EdgeInsets.all(8.0),
          itemCount: _taskController.tasks.length,
          itemBuilder: (context, index) {
            return DismissibleTaskItemCard(
              key: Key(_taskController.tasks[index].id.toString()),
              index: index,
            );
          },
        ),
      ),
    );
  }
}
