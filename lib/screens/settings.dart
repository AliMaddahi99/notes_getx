import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("settings".tr),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Text("layout".tr),
              trailing: IconButton(
                onPressed: () {
                  _noteController.isGridView.value =
                      !_noteController.isGridView.value;
                },
                icon: _noteController.isGridView.value
                    ? const Icon(Icons.grid_view_rounded)
                    : const Icon(Icons.view_list_rounded),
                tooltip: _noteController.isGridView.value
                    ? "grid_view".tr
                    : "list_view".tr,
              ),
            ),
            Obx(
              () => ListTile(
                leading: Text("language".tr),
                trailing: TextButton(
                  onPressed: () {
                    _appController.isLanguagePersian.value
                        ? Get.updateLocale(const Locale('en', 'US'))
                        : Get.updateLocale(const Locale('fa', 'IR'));

                    _appController.isLanguagePersian.value =
                        !_appController.isLanguagePersian.value;
                  },
                  child: Text(
                    _appController.isLanguagePersian.value
                        ? "persian".tr
                        : "english".tr,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
