import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/delete_icon_button.dart';

class SelectModeBottomNavigationBar extends StatelessWidget {
  final String? folderName;
  final bool deleteFromFolderScreen;
  SelectModeBottomNavigationBar({
    Key? key,
    this.folderName,
    this.deleteFromFolderScreen = false,
  }) : super(key: key);

  final AppController _appController = Get.find();

  Future<bool> isDeleteEnalbe() async {
    List<Note?> selectedNotes = await NoteDatabaseService()
        .getNotesFromDb(_appController.selectedItems.toList());

    List<Note?> selectedFolders =
        selectedNotes.where((note) => note!.isFolder).toList();

    if ((selectedNotes.length == 1 && selectedFolders.length == 1) ||
        (selectedFolders.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FutureBuilder<bool>(
        initialData: true,
        future: isDeleteEnalbe(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return Container(
            height: 80.0,
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _appController.pageViewId.value == 0
                    ? snapshot.data!
                        ? DeleteIconButton(
                            deleteFromFolderScreen: deleteFromFolderScreen,
                            folderName: folderName,
                          )
                        : const SizedBox.shrink()
                    : DeleteIconButton(
                        deleteFromFolderScreen: deleteFromFolderScreen,
                        folderName: folderName,
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
