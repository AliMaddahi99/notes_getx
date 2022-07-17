import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/tasks/controllers/task_controller.dart';

import 'package:notes_getx/tasks/widgets/task_item_card.dart';

class DismissibleCardListView extends StatelessWidget {
  DismissibleCardListView({Key? key}) : super(key: key);
  final TaskController _controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Dismissible(
                    key: Key(_controller.tasks[index].id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (_) {
                      _controller.deleteTodo(id: index);
                    },
                    child: TaskItemCard(
                      index: index,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              );
            },
            itemCount: _controller.tasks.length,
          ),
        ),
      ),
    );
  }
}
