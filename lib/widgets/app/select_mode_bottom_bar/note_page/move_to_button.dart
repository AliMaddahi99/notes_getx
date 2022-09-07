import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/select_mode_bottom_bar_button.dart';

class MoveToButton extends StatelessWidget {
  MoveToButton({super.key});

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
