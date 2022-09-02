import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/widgets/app/delete_bottom_sheet.dart';

class AddEditNotePopupMenuButton extends StatelessWidget {
  const AddEditNotePopupMenuButton({super.key});

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
            Get.bottomSheet(
              DeleteBottomSheet(
                title: "Delete note",
                message: "Delete this note?",
                deleteFromAddEditNoteScreen: true,
              ),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return {"Delete"}.map((choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
