import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/widgets/app/delete_bottom_sheet.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet/folder_bottom_sheet.dart';

class FolderScreenMainAppBar extends StatelessWidget {
  final String folderName;
  FolderScreenMainAppBar({
    Key? key,
    required this.folderName,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();

  Stream<List<Note>> getNotesInFolder() {
    return _appController.db.notes
        .where()
        .filter()
        .folderNameEqualTo(folderName)
        .build()
        .watch(fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(folderName),
      actions: [
        StreamBuilder<List<Note>>(
          initialData: const [],
          stream: getNotesInFolder(),
          builder: (context, snapshot) {
            return PopupMenuButton<int>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              tooltip: "options".tr,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("rename".tr),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("delete".tr),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 1:
                    Get.bottomSheet(
                      FolderBottomSheet(
                        title: "rename_folder".tr,
                        notes: snapshot.data!,
                        isRename: true,
                        renameFromFolderScreen: true,
                      ),
                      enableDrag: false,
                      isDismissible: false,
                    );
                    break;
                  case 2:
                    // select the folder and it's notes
                    _appController.selectedItems.clear();
                    for (var note in snapshot.data!) {
                      _appController.selectItem(note.id);
                    }

                    Get.bottomSheet(
                      DeleteBottomSheet(
                        title: "delete_folder".tr,
                        message: "delete_item".trPluralParams("delete_items",
                            _appController.selectedItems.length, {
                          "item": _appController.selectedItems.length.toString()
                        }),
                        // message:
                        //     "Delete ${_appController.getSelectedItemsCount("item")}?",
                        folderName: folderName,
                        deleteFromFolderScreen: true,
                      ),
                    );
                    break;
                }
              },
            );
          },
        ),
      ],
    );
  }
}
