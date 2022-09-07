import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/select_mode_bottom_bar_button.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet.dart';

class RenameButton extends StatelessWidget {
  RenameButton({super.key});

  final AppController _appController = Get.find();

  Future<List<Note>> getNotesInFolder() async {
    var n = await NoteDatabaseService()
        .getNoteFromDb(_appController.selectedItems.first);

    return _appController.db.notes
        .where()
        .filter()
        .folderNameEqualTo(n!.folderName)
        .findAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
      initialData: const [],
      future: getNotesInFolder(),
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        return SelectModeBottomBarButton(
          onPressed: () {
            Get.bottomSheet(
              FolderBottomSheet(
                title: "Rename folder",
                notes: snapshot.data!,
                isRename: true,
              ),
              enableDrag: false,
              isDismissible: false,
            );
          },
          icon: Icons.drive_file_rename_outline_rounded,
          lable: "Rename",
        );
      },
    );
  }
}
