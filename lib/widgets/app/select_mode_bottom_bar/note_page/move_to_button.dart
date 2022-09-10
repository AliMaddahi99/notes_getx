import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_bottom_sheet.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/select_mode_bottom_bar_button.dart';

class MoveToButton extends StatelessWidget {
  final bool moveToFromFolderScreen;
  final String? folderName;

  const MoveToButton({
    super.key,
    required this.moveToFromFolderScreen,
    required this.folderName,
  });

  @override
  Widget build(BuildContext context) {
    return SelectModeBottomBarButton(
      onPressed: () {
        Get.bottomSheet(
          MoveToBottomSheet(
            moveToFromFolderScreen: moveToFromFolderScreen,
            folderName: folderName,
          ),
        );
      },
      icon: Icons.drive_file_move_rounded,
      lable: "Move to",
    );
  }
}
