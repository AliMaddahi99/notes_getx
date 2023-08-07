import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/screens/settings.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar({Key? key}) : super(key: key);

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(
        alignment: Alignment.centerRight,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _appController.pageViewId.value = 0;
                    _appController.pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                  icon: Icon(
                    _appController.pageViewId.value == 0
                        ? Icons.book_rounded
                        : Icons.book_outlined,
                  ),
                  tooltip: "notes".tr,
                ),
                IconButton(
                  onPressed: () {
                    _appController.pageViewId.value = 1;
                    _appController.pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                  icon: Icon(
                    _appController.pageViewId.value == 1
                        ? Icons.check_box_rounded
                        : Icons.check_box_outlined,
                  ),
                  tooltip: "tasks".tr,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.to(() => Settings()),
            icon: const Icon(Icons.settings_rounded),
            tooltip: "settings".tr,
          ),
        ],
      ),
    );
  }
}
