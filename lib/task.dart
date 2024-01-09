import 'package:get/get.dart';

class Task {
  late String title;
  late RxBool isCompleted;
  late RxBool isSelected;

  Task(this.title, {bool completed = false}) {
    isCompleted = RxBool(completed);
    isSelected = RxBool(false); // Initialize isSelected as false
  }
  
}

