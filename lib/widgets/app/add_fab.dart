import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';

class AddFAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? tooltip;
  AddFAB({super.key, required this.onPressed, this.tooltip});

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: !_appController.isSelectMode.value
            ? FloatingActionButton(
                onPressed: onPressed,
                tooltip: tooltip,
                child: const Icon(Icons.add_rounded),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
