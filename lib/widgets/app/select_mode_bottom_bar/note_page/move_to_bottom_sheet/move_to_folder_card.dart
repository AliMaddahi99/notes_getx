import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_card.dart';

class MoveToFolderCard extends StatelessWidget {
  final String? snapshotDataFolderName;
  final String? folderName;

  MoveToFolderCard({
    super.key,
    required this.snapshotDataFolderName,
    required this.folderName,
  });

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  Future<int> getNotesInFolderCount() => _appController.db.notes
      .where()
      .filter()
      .folderNameEqualTo(snapshotDataFolderName)
      .and()
      .isFolderEqualTo(false)
      .count();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: getNotesInFolderCount(),
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> noteCount) {
        return MoveToCard(
          icon: Icons.folder_rounded,
          title: snapshotDataFolderName!,
          notesInFolderCount: noteCount.data!.toString(),
          onTap: () async {
            List<Note?> selectedNotes = await NoteDatabaseService()
                .getNotesFromDb(_appController.selectedItems().toList());

            // selectedNotes is nullable so turn it to non null
            List<Note> selectedNotesWithoutNull =
                selectedNotes.whereType<Note>().toList();

            await _folderController.addNoteToExistingFolder(
                snapshotDataFolderName!, selectedNotesWithoutNull);

            _appController.selectedItems.clear();
            _appController.selectedFolderNotes.clear();
            Get.back();
            _appController.isSelectMode.value = false;

            // Get notes in the folder, if there isn't any note, delete the folder
            var notesInFolder = await _appController.db.notes
                .where()
                .filter()
                .folderNameEqualTo(folderName)
                .and()
                .not()
                .folderNameIsNull()
                .findAll();

            if (notesInFolder.length == 1) {
              await NoteDatabaseService().deleteNotesFromDb([
                notesInFolder.first.id,
              ]);
              Get.back();
            }
          },
        );
      },
    );
  }
}
