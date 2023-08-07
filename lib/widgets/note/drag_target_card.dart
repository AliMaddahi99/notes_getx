import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet/folder_bottom_sheet.dart';
import 'package:notes_getx/widgets/note/folder/folder_card.dart';
import 'package:notes_getx/widgets/note/long_press_draggable_note_card.dart';

class DragTargetCard extends StatelessWidget {
  final Note note;

  DragTargetCard({super.key, required this.note});

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return note.isFolder
            ? FolderCard(
                note: note,
                highlighted: candidateData.isNotEmpty,
              )
            : LongPressDraggableNoteCard(
                note: note,
                highlighted: candidateData.isNotEmpty,
              );
      },
      onWillAccept: (data) {
        return (data as Note).id != note.id;
      },
      onAccept: (data) async {
        if (note.isFolder) {
          await _folderController.addNoteToExistingFolder(
            note.folderName!,
            [data as Note],
          );
          _appController.isSelectMode.value = false;
        } else {
          Get.bottomSheet(
            FolderBottomSheet(
              title: "new_folder".tr,
              notes: [note, data as Note],
            ),
            enableDrag: false,
            isDismissible: false,
          );
        }
      },
    );
  }
}
