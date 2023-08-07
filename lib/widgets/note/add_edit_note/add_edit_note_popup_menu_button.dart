import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/add_edit_note_controller.dart';
import 'package:notes_getx/widgets/app/delete_bottom_sheet.dart';

class AddEditNotePopupMenuButton extends StatelessWidget {
  AddEditNotePopupMenuButton({super.key});

  final AddEditNoteController _addEditNoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      tooltip: "options".tr,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("delete".tr),
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          _addEditNoteController.args != null
              ? Get.bottomSheet(
                  DeleteBottomSheet(
                    title: "delete_note".tr,
                    message: "delete_note_message".tr,
                    deleteFromAddEditNoteScreen: true,
                  ),
                )
              : null;
        }
      },
    );
  }
}
