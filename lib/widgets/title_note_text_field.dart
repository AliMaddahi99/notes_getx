import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/add_edit_note_controller.dart';

class TitleNoteTextField extends StatelessWidget {
  final String? hintText;
  final double? fontSize;
  final TextEditingController? controller;

  TitleNoteTextField({
    Key? key,
    this.hintText,
    this.fontSize,
    this.controller,
  }) : super(key: key);

  final AddEditNoteController _addEditNoteController =
      Get.put(AddEditNoteController());

  void toggleSaveButtonVisibility() {
    _addEditNoteController.saveButtonVisibility()
        ? _addEditNoteController.isSaveButtonVisible.value = true
        : _addEditNoteController.isSaveButtonVisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 4000000000,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
      style: TextStyle(fontSize: fontSize),
      toolbarOptions: const ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      onChanged: (text) {
        toggleSaveButtonVisibility();
      },
    );
  }
}
