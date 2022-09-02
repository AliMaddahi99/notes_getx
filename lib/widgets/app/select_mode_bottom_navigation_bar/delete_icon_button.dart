import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/widgets/app/delete_bottom_sheet/delete_bottom_sheet.dart';

class DeleteIconButton extends StatelessWidget {
  final String? folderName;
  final bool deleteFromFolderScreen;
  DeleteIconButton({
    super.key,
    this.folderName,
    this.deleteFromFolderScreen = false,
  });

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _appController.selectedItems.isNotEmpty
          ? () {
              Get.bottomSheet(
                DeleteBottomSheet(
                  title: _appController.pageViewId.value == 0
                      ? "Delete note"
                      : "Delete task",
                  message:
                      "Delete ${_appController.getSelectedItemsCount(_appController.pageViewId.value == 0 ? "item" : "task")}?",
                  deleteFromFolderScreen: deleteFromFolderScreen,
                  folderName: folderName,
                ),
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
              );
            }
          : null,
      icon: const Icon(Icons.delete_rounded),
    );
  }
}
