import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/controllers/task/edit_task_controller.dart';

class EditTodo extends StatelessWidget {
  EditTodo({Key? key}) : super(key: key);

  final EditTaskController _editTaskController = Get.put(EditTaskController());
  final TaskController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var id = _editTaskController.args[0];
    var edited = _controller.tasks[id];
    var title = _editTaskController.args[1];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 4.0,
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextField(
          decoration: const InputDecoration(
            hintText: "Edit todo title",
            border: InputBorder.none,
          ),
          controller: _editTaskController.editTaskTextEditingController,
          focusNode: _editTaskController.editTaskTextFieldFocusNode,
          onChanged: (text) {
            if (text.isEmpty) {
              edited.title = title;
              _controller.tasks[id] = edited;
            } else {
              edited.title = text;
              _controller.tasks[id] = edited;
            }
          },
        ),
      ),
    );
  }
}
