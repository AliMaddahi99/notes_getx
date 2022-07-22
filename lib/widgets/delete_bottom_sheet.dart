import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';

class DeleteBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  DeleteBottomSheet({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();
  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 15.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 15.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onPressed: () {
                  _appController.pageViewId.value == 0
                      ? {
                          for (var n in _appController.selectedItems)
                            _noteController.deleteNote(n)
                        }
                      : {
                          for (var t in _appController.selectedItems)
                            _taskController.deleteTask(t)
                        };
                  _appController.selectedItems.clear();
                  _appController.isSelectMode.value = false;

                  // Two backs for deletion in add_edit_note
                  // just one back cuase error in add_edit_note on deletion
                  // because index of deleted item still is there,
                  // but there is nothing to build a list item
                  // therefore must go back to the list page and then delete
                  // then it works fine
                  Get.back();
                  Get.back();
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
