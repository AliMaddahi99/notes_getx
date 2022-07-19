import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final PageController pageController = PageController();
  var pageViewId = 0.obs;
  var isSelectMode = false.obs;
  var selectedItems = [].obs;

  void selectItem(int id) {
    selectedItems.contains(id)
        ? selectedItems.remove(id)
        : selectedItems.add(id);
  }

  String getSelectedItemsCount() {
    return selectedItems.length == 1
        ? "${selectedItems.length} item"
        : "${selectedItems.length} items";
  }
}
