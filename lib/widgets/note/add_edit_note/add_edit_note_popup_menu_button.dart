import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/add_edit_note_controller.dart';
import 'package:notes_getx/widgets/app/delete_bottom_sheet.dart';

class AddEditNotePopupMenuButton extends StatelessWidget {
  AddEditNotePopupMenuButton({super.key});

  final AddEditNoteController _addEditNoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      tooltip: "Options",
      onSelected: (value) {
        switch (value) {
          case "Delete":
            _addEditNoteController.args != null
                ? Get.bottomSheet(
                    DeleteBottomSheet(
                      title: "Delete note",
                      message: "Delete this note?",
                      deleteFromAddEditNoteScreen: true,
                    ),
                  )
                : null;
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return {
          "Delete",
        }.map((choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
