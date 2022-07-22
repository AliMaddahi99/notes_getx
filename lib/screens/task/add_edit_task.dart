import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/add_edit_task_controller.dart';
import 'package:notes_getx/widgets/task/add_edit_task_text_field.dart';

class AddEditTask extends StatelessWidget {
  AddEditTask({Key? key}) : super(key: key);

  final AddEditTaskController _addEditTaskController =
      Get.put(AddEditTaskController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _addEditTaskController.addOrEdit();
        return true;
      },
      child: GestureDetector(
        onTap: () {
          _addEditTaskController.addOrEdit();
        },
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: AddEditTaskTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
