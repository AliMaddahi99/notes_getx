import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/fab_animation_controller.dart';
import 'package:notes_getx/widgets/note/fab_options_menu/fab_options_menu.dart';

class OverlayFABOptionsMenu extends StatelessWidget {
  OverlayFABOptionsMenu({super.key});

  final FABAnimationContoller _fabAnimationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _fabAnimationController.doAnimation(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FABOptionsMenu(),
      ),
    );
  }
}
