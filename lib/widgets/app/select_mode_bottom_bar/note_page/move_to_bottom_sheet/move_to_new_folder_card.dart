import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_card.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet/folder_bottom_sheet.dart';

class MoveToNewFolderCard extends StatelessWidget {
  final String? folderName;

  MoveToNewFolderCard({
    super.key,
    required this.folderName,
  });

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return MoveToCard(
      icon: Icons.create_new_folder_rounded,
      title: "New folder",
      onTap: () async {
        var selectedNotes = await NoteDatabaseService()
            .getNotesFromDb(_appController.selectedItems.toList());

        // selectedNotes is nullable so turn it to non null
        List<Note> selectedNotesWithoutNull =
            selectedNotes.whereType<Note>().toList();

        Get.bottomSheet(
          FolderBottomSheet(
            title: "New folder",
            notes: selectedNotesWithoutNull,
            fromMoveToBottomSheet: true,
            folderName: folderName,
          ),
          enableDrag: false,
          isDismissible: false,
        );
      },
    );
  }
}
