import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:MyDay/taskCon.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE dd MMMM yyyy').format(now);
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          _addTaskDialog(context);
        },
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber[50],
          ),
          child: const Icon(
            Icons.add,
            color: Colors.black87,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 16,
              left: 16,
              child: Text(
                "My day",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Positioned(
              top: 56,
              left: 16,
              child: Text(
                formattedDate,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Positioned(
              child: Container(
                padding: const EdgeInsets.only(top: 90),
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 20,
                child: Obx(() => ListView.builder(
                    itemCount: taskController.taskList.isEmpty
                        ? 1
                        : taskController.taskList.length,
                    itemBuilder: (context, index) {
                      if (taskController.taskList.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.hourglass_empty,
                                  size: 60,
                                  color: Colors.orange,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'No tasks added',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Tap on the add icon below to add tasks.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        final task = taskController.taskList[index];
                        return Obx(
                          () => Card(
                            color: Colors.amber[50],
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            elevation: 2,
                            child: ListTile(
                              leading: IconButton(
                                icon: task.isCompleted.value
                                    ? const Icon(Icons.check_box)
                                    : const Icon(Icons.check_box_outline_blank),
                                onPressed: () {
                                  task.isCompleted
                                      .toggle(); // Toggles the checkbox state
                                },
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      task.title,
                                      style: TextStyle(
                                        decoration: task.isCompleted.value
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      taskController.deleteTask(index);
                                    },
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: task.isSelected.value
                                      ? Colors.yellow
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  task.isSelected
                                      .toggle(); // Toggle isSelected when star is pressed
                                },
                              ),
                            ),
                          ),
                        );
                      }
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addTaskDialog(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: TextField(
              controller: taskController,
              decoration: const InputDecoration(hintText: 'Enter Task'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    String taskTitle = taskController.text.trim();
                    if (taskTitle.isNotEmpty) {
                      Get.back();
                      _addTask(taskTitle);
                    }
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }

  void _addTask(String title) {
    taskController.addTask(title);
  }
}
