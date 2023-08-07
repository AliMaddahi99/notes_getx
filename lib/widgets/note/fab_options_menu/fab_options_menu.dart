import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/fab_animation_controller.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/note/fab_options_menu/fab_options_menu_delegate.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet/folder_bottom_sheet.dart';

class FABOptionsMenu extends StatelessWidget {
  FABOptionsMenu({super.key});

  final double btnSize = 56.0;

  final FABAnimationContoller _fabAnimationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FABOptionsMenuDelegate(
        animation: _fabAnimationController.animationController,
        btnSize: btnSize,
      ),
      children: [
        FloatingActionButton(
          heroTag: null,
          tooltip: "new_folder".tr,
          onPressed: () {
            _fabAnimationController.doAnimation();

            Get.bottomSheet(
              FolderBottomSheet(title: "new_folder".tr, notes: null),
              enableDrag: false,
              isDismissible: false,
            );
          },
          child: const Icon(Icons.create_new_folder_rounded),
        ),
        FloatingActionButton(
          heroTag: null,
          tooltip: "add_note".tr,
          onPressed: () {
            _fabAnimationController.doAnimation();

            Get.to(
              () => AddEditNote(),
              transition: Transition.cupertino,
            );
          },
          child: const Icon(Icons.note_add_rounded),
        ),
        FloatingActionButton(
          heroTag: null,
          tooltip: "options".tr,
          onPressed: () => _fabAnimationController.doAnimation(),
          child: const Icon(Icons.more_vert_rounded),
        ),
      ],
    );
  }
}
