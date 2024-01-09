import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MyDay/Splash/splashscreen.dart';
import 'package:MyDay/taskCon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Day',
      home: SplashScreen(),
    );
  }
}
