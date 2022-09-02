import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';

class CardCheckbox extends StatelessWidget {
  final int itemId;
  final bool isNoteOrFolderCard;
  CardCheckbox({
    super.key,
    required this.itemId,
    required this.isNoteOrFolderCard,
  });

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: _appController.isSelectMode.value,
        child: Transform.scale(
          scale: 1.3,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isNoteOrFolderCard ? 10.0 : 0,
              vertical: isNoteOrFolderCard ? 5.0 : 0,
            ),
            child: Checkbox(
              splashRadius: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              value: _appController.selectedItems.contains(itemId),
              onChanged: (checked) {
                _appController.selectItem(itemId);
              },
            ),
          ),
        ),
      ),
    );
  }
}
