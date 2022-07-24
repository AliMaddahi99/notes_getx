import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';

class NoItem extends StatelessWidget {
  NoItem({Key? key}) : super(key: key);

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Icon(
                _appController.pageViewId.value == 0
                    ? Icons.note_alt_rounded
                    : Icons.task_rounded,
                size: 56.0,
                color: Colors.amber.shade200,
              ),
            ),
            Text(
              _appController.pageViewId.value == 0
                  ? "No notes here yet"
                  : "No tasks here yet",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
