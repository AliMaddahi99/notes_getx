import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/tasks/controllers/task_controller.dart';

class AddTaskTextField extends StatelessWidget {
  AddTaskTextField({Key? key}) : super(key: key);

  final TaskController _controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Obx(
        () => Row(
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "What todo?",
                  ),
                  controller: _controller.addTaskTextEditingController,
                  focusNode: _controller.addTaskTextFieldFocusNode,
                  onChanged: (text) {
                    _controller.isTextFieldNotEmpty.value = text.isNotEmpty;
                  },
                  onSubmitted: _controller.isTextFieldNotEmpty.value
                      ? (text) => _controller.addTask(title: text)
                      : null,
                ),
              ),
            ),
            IconButton(
              splashRadius: 1,
              onPressed: _controller.isTextFieldNotEmpty.value
                  ? () => _controller.addTask(
                      title: _controller.addTaskTextEditingController.text)
                  : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
