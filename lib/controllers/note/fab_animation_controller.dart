import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FABAnimationContoller extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void doAnimation() {
    if (animationController.status == AnimationStatus.completed) {
      animationController.animateBack(
        0.0,
        curve: Curves.fastOutSlowIn,
      );
      Get.back();
    } else {
      animationController.animateTo(
        1.0,
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
