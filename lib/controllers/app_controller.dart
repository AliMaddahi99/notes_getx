import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class AppController extends GetxController {
  PageController pageController = PageController();
  var pageViewId = 0.obs;
  var isSelectMode = false.obs;
  var selectedItems = <int>[].obs;
  late Isar db;

  void selectItem(int id) {
    selectedItems.contains(id)
        ? selectedItems.remove(id)
        : selectedItems.add(id);
  }

  String getSelectedItemsCount(String message) {
    return selectedItems.length == 1
        ? "${selectedItems.length} $message"
        : "${selectedItems.length} ${message}s";
  }
}
