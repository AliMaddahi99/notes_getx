import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/add_edit_task_controller.dart';

class AddEditTaskTextField extends StatelessWidget {
  AddEditTaskTextField({Key? key}) : super(key: key);

  final AddEditTaskController _addEditTaskController = Get.find();

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
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "What todo?",
                ),
                controller: _addEditTaskController.taskTextController,
                focusNode: _addEditTaskController.taskFocusNode,
                onChanged: (text) {
                  _addEditTaskController.isTextFieldNotEmpty.value =
                      text.isNotEmpty;
                },
                onSubmitted: _addEditTaskController.isTextFieldNotEmpty.value
                    ? (text) {
                        _addEditTaskController.addOrEdit();
                      }
                    : null,
              ),
            ),
            TextButton(
              onPressed: _addEditTaskController.isTextFieldNotEmpty.value
                  ? () {
                      _addEditTaskController.addOrEdit();
                    }
                  : () {},
              child: Text(
                "Done",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _addEditTaskController.isTextFieldNotEmpty.value
                        ? Colors.amber
                        : Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
