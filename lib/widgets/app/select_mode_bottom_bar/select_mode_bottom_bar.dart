import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/styles/colors.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/delete_button.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_button.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/rename_button.dart';

class SelectModeBottomBar extends StatelessWidget {
  final String? folderName;
  final bool deleteFromFolderScreen;
  SelectModeBottomBar({
    Key? key,
    this.folderName,
    this.deleteFromFolderScreen = false,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();

  Future<void> buttonsVisibility() async {
    List<Note?> selectedItems = await NoteDatabaseService()
        .getNotesFromDb(_appController.selectedItems.toList());

    List<Note?> selectedFolders =
        selectedItems.where((note) => note!.isFolder).toList();

    if (selectedFolders.isEmpty) {
      _noteController.isDeleteVisible.value = true;
      _noteController.isMoveToVisible.value = true;
      _noteController.isRenameVisible.value = false;
    } else if ((selectedItems.length == 1 && selectedFolders.length == 1)) {
      _noteController.isDeleteVisible.value = true;
      _noteController.isMoveToVisible.value = false;
      _noteController.isRenameVisible.value = true;
    } else {
      _noteController.isDeleteVisible.value = false;
      _noteController.isMoveToVisible.value = false;
      _noteController.isRenameVisible.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FutureBuilder<void>(
        future: buttonsVisibility(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Container(
            height: 80.0,
            color: Get.isDarkMode ? darkPrimaryColor : primaryColor,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _appController.pageViewId.value == 0
                    ? [
                        _noteController.isDeleteVisible.value
                            ? DeleteButton(
                                deleteFromFolderScreen: deleteFromFolderScreen,
                                folderName: folderName,
                              )
                            : const SizedBox.shrink(),
                        _noteController.isRenameVisible.value
                            ? RenameButton()
                            : const SizedBox.shrink(),
                        _noteController.isMoveToVisible.value
                            ? MoveToButton(
                                moveToFromFolderScreen: deleteFromFolderScreen,
                                folderName: folderName,
                              )
                            : const SizedBox.shrink(),
                      ]
                    : [
                        DeleteButton(
                          deleteFromFolderScreen: deleteFromFolderScreen,
                          folderName: folderName,
                        ),
                      ],
              ),
            ),
          );
        },
      ),
    );
  }
}
