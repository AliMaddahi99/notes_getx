import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isar/isar.dart';

class AppController extends GetxController {
  PageController pageController = PageController();
  late Isar db;
  var pageViewId = 0.obs;
  var isSelectMode = false.obs;
  var selectedItems = <int>[].obs;
  var isLanguagePersian = false.obs;

  // while 1 folder selected, store chlidren notes of that folder(s)
  // in this variable, when delete button clicked,
  // delete folder from selectedItems[],
  // and delete children from selectedFolderNotes[]
  var selectedFolderNotes = <int>[].obs;

  void selectItem(int id) {
    selectedItems.contains(id)
        ? selectedItems.remove(id)
        : selectedItems.add(id);
  }

  void selectFolderNotes(int id) {
    selectedFolderNotes.contains(id)
        ? selectedFolderNotes.remove(id)
        : selectedFolderNotes.add(id);
  }

  // String getSelectedItemsCount(String message) {
  //   return selectedItems.length == 1
  //       ? "${selectedItems.length} $message"
  //       : "${selectedItems.length} ${message}s";
  // }

  @override
  void onInit() {
    // Save and read Layout mode, Gridview/Listview
    var languageIsPersian = GetStorage().read("language");
    if (languageIsPersian != null) {
      isLanguagePersian.value = languageIsPersian;
    }
    ever(isLanguagePersian, (_) {
      GetStorage().write("language", isLanguagePersian.value);
    });

    super.onInit();
  }
}
