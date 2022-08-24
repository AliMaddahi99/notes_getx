import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/models/note.dart';

class DeleteBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final bool deleteFromAddEditNoteScreen;
  DeleteBottomSheet({
    Key? key,
    required this.title,
    required this.message,
    this.deleteFromAddEditNoteScreen = false,
  }) : super(key: key);

  final AppController _appController = Get.find();
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
                onPressed: () async {
                  _appController.pageViewId.value == 0
                      ? {
                          await _appController.db.writeTxn((isar) async {
                            await isar.notes.deleteAll(
                                _appController.selectedItems.toList());

                            // while delete from add_edit_note
                            // it need to Get.back() twice,
                            // one for closing bottomSheet
                            // and antother for go back to list of notes
                            // this one will close bottomsheet in add_edit_note
                            if (deleteFromAddEditNoteScreen) {
                              Get.back();
                            }
                          })
                        }
                      : {
                          for (var t in _appController.selectedItems)
                            _taskController.deleteTask(t)
                        };

                  _appController.selectedItems.clear();
                  _appController.isSelectMode.value = false;
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
