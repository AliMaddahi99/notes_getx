import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/folder_card.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_card.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/new_folder_card.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/parent_card.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet/folder_bottom_sheet.dart';

class MoveToBottomSheet extends StatelessWidget {
  final bool moveToFromFolderScreen;
  final String? folderName;

  MoveToBottomSheet({
    super.key,
    required this.moveToFromFolderScreen,
    required this.folderName,
  });

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  int gridCrossAxisCount(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var count = width > 768 ? 4 : 2;

    return count;
  }

  Stream<List<Note>> getFolders() {
    return _appController.db.notes
        .where()
        .filter()
        .isFolderEqualTo(true)
        .build()
        .watch(initialReturn: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Note>>(
      initialData: const [],
      stream: getFolders(),
      builder: (context, snapshot) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "Select folder",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridCrossAxisCount(context),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 16.0,
                    mainAxisExtent: 180.0,
                  ),
                  itemCount: 2 + snapshot.data!.length,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return NewFolderCard(folderName: folderName);
                      case 1:
                        return ParentCard(
                          moveToFromFolderScreen: moveToFromFolderScreen,
                          folderName: folderName,
                        );
                      default:
                        return MoveToFolderCard(
                            snapshotDataFolderName:
                                snapshot.data![index - 2].folderName,
                            folderName: folderName);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
