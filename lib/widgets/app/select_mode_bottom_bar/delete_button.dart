import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/widgets/app/delete_bottom_sheet.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/select_mode_bottom_bar_button.dart';

class DeleteButton extends StatelessWidget {
  final String? folderName;
  final bool deleteFromFolderScreen;
  DeleteButton({
    super.key,
    this.folderName,
    this.deleteFromFolderScreen = false,
  });

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SelectModeBottomBarButton(
      onPressed: () {
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
        );
      },
      icon: Icons.delete_rounded,
      lable: "Delete",
    );
  }
}
