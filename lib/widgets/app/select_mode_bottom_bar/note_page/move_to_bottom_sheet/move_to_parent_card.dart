import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_card.dart';

class MoveToParentCard extends StatelessWidget {
  final bool moveToFromFolderScreen;
  final String? folderName;

  MoveToParentCard({
    super.key,
    required this.moveToFromFolderScreen,
    required this.folderName,
  });

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: moveToFromFolderScreen,
      child: MoveToCard(
        icon: Icons.turn_left_rounded,
        title: "parent_folder".tr,
        onTap: () async {
          List<Note?> selectedNotes = await NoteDatabaseService()
              .getNotesFromDb(_appController.selectedItems().toList());

          // selectedNotes is nullable so turn it to non null
          List<Note> selectedNotesWithoutNull =
              selectedNotes.whereType<Note>().toList();

          for (Note n in selectedNotesWithoutNull) {
            n.folderName = null;
          }

          await NoteDatabaseService().updateNotesInDb(selectedNotesWithoutNull);

          // Get notes in the folder, if there isn't any note, delete the folder
          var notesInFolder = await _appController.db.notes
              .where()
              .filter()
              .folderNameEqualTo(folderName)
              .findAll();

          if (notesInFolder.length == 1) {
            await NoteDatabaseService().deleteNotesFromDb([
              notesInFolder.first.id,
            ]);
            Get.back();
          }

          _appController.selectedItems.clear();
          _appController.selectedFolderNotes.clear();
          Get.back();
          _appController.isSelectMode.value = false;
        },
      ),
    );
  }
}
