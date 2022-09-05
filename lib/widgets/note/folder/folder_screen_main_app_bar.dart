import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/widgets/app/delete_bottom_sheet.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet.dart';

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
        .watch(initialReturn: true);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(folderName),
      actions: [
        Obx(
          () => _appController.pageViewId.value == 0
              ? IconButton(
                  onPressed: () {
                    _noteController.isGridView.value =
                        !_noteController.isGridView.value;
                  },
                  icon: _noteController.isGridView.value
                      ? const Icon(Icons.view_list_rounded)
                      : const Icon(Icons.grid_view_rounded),
                  tooltip: _noteController.isGridView.value
                      ? "List view"
                      : "Grid view",
                )
              : const SizedBox.shrink(),
        ),
        StreamBuilder<List<Note>>(
          initialData: const [],
          stream: getNotesInFolder(),
          builder: (context, snapshot) {
            return PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              tooltip: "Options",
              onSelected: (value) {
                switch (value) {
                  case "Rename":
                    Get.bottomSheet(
                      FolderBottomSheet(
                        title: "Rename folder",
                        notes: snapshot.data!,
                        isRename: true,
                      ),
                      enableDrag: false,
                      isDismissible: false,
                    );
                    break;
                  case "Delete":
                    // select the folder and it's notes
                    _appController.selectedItems.clear();
                    for (var note in snapshot.data!) {
                      _appController.selectItem(note.id);
                    }

                    Get.bottomSheet(
                      DeleteBottomSheet(
                        title: "Delete folder",
                        message:
                            "Delete ${_appController.getSelectedItemsCount("item")}?",
                        folderName: folderName,
                        deleteFromFolderScreen: true,
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {"Rename", "Delete"}.map((choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          },
        ),
      ],
    );
  }
}
