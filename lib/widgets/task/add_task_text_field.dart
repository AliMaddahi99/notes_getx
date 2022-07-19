import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';

class AddTaskTextField extends StatelessWidget {
  AddTaskTextField({Key? key}) : super(key: key);

  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: _taskController.isAddTaskTextViewVisible.value,
        child: Container(
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
                      controller: _taskController.addTaskTextEditingController,
                      focusNode: _taskController.addTaskTextFieldFocusNode,
                      onChanged: (text) {
                        _taskController.isTextFieldNotEmpty.value =
                            text.isNotEmpty;
                      },
                      onSubmitted: _taskController.isTextFieldNotEmpty.value
                          ? (text) => _taskController.addTask(title: text)
                          : null,
                    ),
                  ),
                ),
                IconButton(
                  splashRadius: 1,
                  onPressed: _taskController.isTextFieldNotEmpty.value
                      ? () => _taskController.addTask(
                          title:
                              _taskController.addTaskTextEditingController.text)
                      : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
