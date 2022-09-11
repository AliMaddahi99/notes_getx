import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/screens/note/folder_screen.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/bottom_sheet_elevated_button.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet/cancel_button.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet/ok_button.dart';

class FolderBottomSheet extends StatelessWidget {
  final String title;
  final List<Note>? notes;
  final bool isRename;
  final bool renameFromFolderScreen;
  final bool fromMoveToBottomSheet;
  final String? folderName;

  FolderBottomSheet({
    Key? key,
    required this.title,
    required this.notes,
    this.isRename = false,
    this.renameFromFolderScreen = false,
    this.fromMoveToBottomSheet = false,
    this.folderName,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  @override
  Widget build(BuildContext context) {
    _folderController.isFolderScreenOpen.value = true;
    if (isRename) {
      _folderController.isTextFieldEmpty.value = false;
    }

    return WillPopScope(
      onWillPop: () async =>
          _folderController.isFolderScreenOpen.value ? false : true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 200.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              autofocus: true,
              controller: _folderController.folderTextController
                ..text = isRename ? notes!.first.folderName! : ""
                ..selection = TextSelection(
                    baseOffset: 0,
                    extentOffset:
                        _folderController.folderTextController.text.length),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CancelButton(fromMoveToBottomSheet: fromMoveToBottomSheet),
                OKButton(
                  notes: notes,
                  isRename: isRename,
                  renameFromFolderScreen: renameFromFolderScreen,
                  fromMoveToBottomSheet: fromMoveToBottomSheet,
                  folderName: folderName,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
