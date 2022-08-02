import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_getx/models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  var deletedTaskToUndo = [].obs;
  var isAddEditTaskScreen = false.obs;

  void deleteTask(int id) {
    tasks.removeWhere((task) => task.id == id);
  }

  @override
  void onInit() {
    // Save and read tasks
    var storedTasks = GetStorage().read<List>("tasks");
    if (storedTasks != null) {
      tasks = storedTasks.map((e) => TaskModel.fromJson(e)).toList().obs;
    }

    ever(tasks, (_) {
      GetStorage().write("tasks", tasks.toList());
    });
    super.onInit();
  }
}
