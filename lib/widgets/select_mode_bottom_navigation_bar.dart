import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/delete_bottom_sheet.dart';

class SelectModeBottomNavigationBar extends StatelessWidget {
  SelectModeBottomNavigationBar({Key? key}) : super(key: key);

  final AppController _appController = Get.find();

  Future<bool> isDeleteEnalbe() async {
    List<Note?> selectedNotes = await NoteDatabaseService()
        .getNotesFromDb(_appController.selectedItems.toList());

    List<Note?> selectedFolders =
        selectedNotes.where((note) => note!.isFolder).toList();

    if ((selectedNotes.length == 1 && selectedFolders.length == 1) ||
        (selectedFolders.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FutureBuilder<bool>(
        initialData: true,
        future: isDeleteEnalbe(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return Container(
            height: 80.0,
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                snapshot.data!
                    ? IconButton(
                        onPressed: _appController.selectedItems.isNotEmpty
                            ? () {
                                Get.bottomSheet(
                                  DeleteBottomSheet(
                                    title: _appController.pageViewId.value == 0
                                        ? "Delete note"
                                        : "Delete task",
                                    message:
                                        "Delete ${_appController.getSelectedItemsCount(_appController.pageViewId.value == 0 ? "item" : "task")}?",
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.0),
                                    ),
                                  ),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.delete_rounded),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
