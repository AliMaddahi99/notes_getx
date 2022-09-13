import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/widgets/app/bottom_sheet_elevated_button.dart';

class CancelButton extends StatelessWidget {
  final bool fromMoveToBottomSheet;

  CancelButton({
    super.key,
    required this.fromMoveToBottomSheet,
  });

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomSheetElevatedButton(
      onPressed: () {
        if (fromMoveToBottomSheet) {
          _folderController.folderTextController.clear();
          _folderController.isTextFieldEmpty.value = true;
          Get.back();
        } else {
          _folderController.folderTextController.clear();
          _folderController.isTextFieldEmpty.value = true;
          _folderController.isFolderScreenOpen.value = false;
          _appController.isSelectMode.value = false;
          _appController.selectedItems.clear();
          _appController.selectedFolderNotes.clear();
          Get.back();
          _appController.isSelectMode.value = false;
        }
      },
      buttonText: "Cancel",
    );
  }
}
