import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/styles/colors.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_folder_card.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_new_folder_card.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_parent_card.dart';

class MoveToBottomSheet extends StatelessWidget {
  final bool moveToFromFolderScreen;
  final String? folderName;

  MoveToBottomSheet({
    super.key,
    required this.moveToFromFolderScreen,
    required this.folderName,
  });

  final AppController _appController = Get.find();

  int gridCrossAxisCount(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width > 768 ? 4 : 2;
  }

  Stream<List<Note>> getFolders() {
    return _appController.db.notes
        .where()
        .filter()
        .isFolderEqualTo(true)
        .build()
        .watch(fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Note>>(
      initialData: const [],
      stream: getFolders(),
      builder: (context, snapshot) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? darkBottomSheet : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "select_folder".tr,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
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

                  // 2 is because of MoveToNewFolderCard and MoveToFolderCard
                  itemCount: 2 + snapshot.data!.length,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return MoveToNewFolderCard(folderName: folderName);
                      case 1:
                        return MoveToParentCard(
                          moveToFromFolderScreen: moveToFromFolderScreen,
                          folderName: folderName,
                        );
                      default:
                        return MoveToFolderCard(
                          snapshotDataFolderName:
                              snapshot.data![index - 2].folderName,
                          folderName: folderName,
                        );
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
