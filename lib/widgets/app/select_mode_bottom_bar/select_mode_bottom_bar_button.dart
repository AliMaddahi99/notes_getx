import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';

class SelectModeBottomBarButton extends StatelessWidget {
  final FutureOr<void> Function()? onPressed;
  final IconData icon;
  final String lable;
  SelectModeBottomBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.lable,
  });

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextButton(
        onPressed: _appController.selectedItems.isNotEmpty ? onPressed : null,
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(
              lable,
              style: const TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
