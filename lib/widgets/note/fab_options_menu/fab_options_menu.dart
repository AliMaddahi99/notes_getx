import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/note/fab_options_menu/fab_options_menu_delegate.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet/folder_bottom_sheet.dart';

class FABOptionsMenu extends StatefulWidget {
  const FABOptionsMenu({super.key});

  @override
  State<FABOptionsMenu> createState() => _FABOptionsMenuState();
}

class _FABOptionsMenuState extends State<FABOptionsMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final double btnSize = 56.0;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FABOptionsMenuDelegate(
        animation: animationController,
        btnSize: btnSize,
      ),
      children: <IconData>[
        Icons.delete_rounded,
        Icons.create_new_folder_rounded,
        Icons.note_add_rounded,
        Icons.more_vert_rounded,
      ].map<Widget>(buildButton).toList(),
    );
  }

  Widget buildButton(IconData icon) {
    return RawMaterialButton(
      constraints: BoxConstraints(minWidth: btnSize, minHeight: btnSize),
      fillColor: Colors.amber,
      elevation: 0,
      shape: const CircleBorder(),
      child: Icon(icon),
      onPressed: () {
        animationController.status == AnimationStatus.completed
            ? animationController.animateBack(
                0.0,
                curve: Curves.fastOutSlowIn,
              )
            : animationController.animateTo(
                1.0,
                curve: Curves.fastOutSlowIn,
              );

        if (icon == Icons.note_add_rounded) {
          Get.to(
            () => AddEditNote(),
            transition: Transition.cupertino,
          );
        } else if (icon == Icons.create_new_folder_rounded) {
          Get.bottomSheet(
            FolderBottomSheet(title: "New folder", notes: null),
            enableDrag: false,
            isDismissible: false,
          );
        } else if (icon == Icons.delete_rounded) {}
      },
    );
  }
}
