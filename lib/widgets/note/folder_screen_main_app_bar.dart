import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';

class FolderScreenMainAppBar extends StatelessWidget {
  final String folderName;
  FolderScreenMainAppBar({
    Key? key,
    required this.folderName,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();
  final FolderController _folderController = Get.find();

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
        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          tooltip: "Options",
          onSelected: (value) {
            switch (value) {
              case "Rename":
                break;
              case "Delete":
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
        ),
      ],
    );
  }
}
