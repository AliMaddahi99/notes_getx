import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NoteController extends GetxController {
  ScrollController scrollController = ScrollController();

  var isGridView = false.obs;
  var isMoveToVisible = false.obs;
  var isRenameVisible = false.obs;
  var isDeleteVisible = false.obs;

  @override
  void onInit() {
    // Save and read Layout mode, Gridview/Listview
    var layoutIsGridView = GetStorage().read("layout");
    if (layoutIsGridView != null) {
      isGridView.value = layoutIsGridView;
    }
    ever(isGridView, (_) {
      GetStorage().write("layout", isGridView.value);
    });

    super.onInit();
  }
}
