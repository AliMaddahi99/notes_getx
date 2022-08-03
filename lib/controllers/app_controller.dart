import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class AppController extends GetxController {
  PageController pageController = PageController();
  var pageViewId = 0.obs;
  var isSelectMode = false.obs;
  var selectedItems = [].obs;

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

  // @override
  // void onInit() {
  //   // Save and read PageView
  //   var pageView = GetStorage().read("page");
  //   if (pageView != null) {
  //     pageViewId.value = pageView;
  //   }
  //   ever(pageViewId, (_) {
  //     GetStorage().write("page", pageViewId.value);
  //   });

  // super.onInit();
  // }
}
