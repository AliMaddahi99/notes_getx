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
                ? "delete_note".tr
                : "delete_task".tr,
            message: "delete_bottom_sheet_message".trPluralParams(
              "delete_bottom_sheet_message_plural".tr,
              _appController.selectedItems.length,
              {
                "count": _appController.selectedItems.length.toString(),
                "what": _appController.pageViewId.value == 0
                    ? "item".tr
                    : "task".tr,
                "whaat": _appController.pageViewId.value == 0
                    ? "itemp".tr
                    : "taskp".tr,
              },
              // message:
              //     "Delete ${_appController.getSelectedItemsCount(_appController.pageViewId.value == 0 ? "item" : "task")}?",
            ),
            deleteFromFolderScreen: deleteFromFolderScreen,
            folderName: folderName,
          ),
        );
      },
      icon: Icons.delete_rounded,
      lable: "delete".tr,
    );
  }
}
