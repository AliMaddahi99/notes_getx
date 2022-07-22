import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/widgets/delete_bottom_sheet.dart';

class SelectModeBottomNavigationBar extends StatelessWidget {
  SelectModeBottomNavigationBar({Key? key}) : super(key: key);

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      color: Colors.amber,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: _appController.selectedItems.isNotEmpty
                  ? () {
                      Get.bottomSheet(
                        DeleteBottomSheet(
                          title: _appController.pageViewId.value == 0
                              ? "Delete note"
                              : "Delete task",
                          message:
                              "Delete ${_appController.getSelectedItemsCount(_appController.pageViewId.value == 0 ? "item" : "task")}?",
                        ),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.delete_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
