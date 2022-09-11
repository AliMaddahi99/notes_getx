import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';

class FolderNameTextField extends StatelessWidget {
  final List<Note>? notes;
  final bool isRename;

  FolderNameTextField({
    super.key,
    required this.notes,
    required this.isRename,
  });

  final FolderController _folderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _folderController.folderTextController
        ..text = isRename ? notes!.first.folderName! : ""
        ..selection = TextSelection(
            baseOffset: 0,
            extentOffset: _folderController.folderTextController.text.length),
      decoration: const InputDecoration(
        hintText: "Please enter text...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      onChanged: (value) {
        _folderController.isTextFieldEmpty.value = value.isEmpty;
      },
    );
  }
}
