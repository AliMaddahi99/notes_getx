import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/task/add_edit_task_controller.dart';
import 'package:notes_getx/styles/colors.dart';

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
              Container(
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? darkBottomSheet : Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          minLines: 1,
                          maxLines: 12,
                          maxLength: 2000,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            hintText: "what_todo".tr,
                          ),
                          controller: _addEditTaskController.taskTextController,
                          autofocus: true,
                          onChanged: (text) {
                            _addEditTaskController.isTextFieldNotEmpty.value =
                                text.isNotEmpty;
                          },
                          onSubmitted:
                              _addEditTaskController.isTextFieldNotEmpty.value
                                  ? (text) {
                                      _addEditTaskController.addOrEdit();
                                    }
                                  : null,
                        ),
                      ),
                      Container(
                        color: Get.isDarkMode ? darkBottomSheet : Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: _addEditTaskController
                                      .isTextFieldNotEmpty.value
                                  ? () {
                                      _addEditTaskController.addOrEdit();
                                    }
                                  : null,
                              child: Text(
                                "done".tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
