import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/select_mode_bottom_bar_button.dart';

class MoveToButton extends StatelessWidget {
  final String? folderName;
  final bool deleteFromFolderScreen;
  MoveToButton({
    super.key,
    this.folderName,
    this.deleteFromFolderScreen = false,
  });

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SelectModeBottomBarButton(
      onPressed: () {},
      icon: Icons.drive_file_move_rounded,
      lable: "Move to",
    );
  }
}
