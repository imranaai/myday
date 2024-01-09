import 'package:get/get.dart';
import 'package:MyDay/task.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;

  void addTask(String title) {
    taskList.add(Task(title));
  }

  void deleteTask(int index) {
    if (index >= 0 && index < taskList.length) {
      taskList.removeAt(index);
    }
  }
}
