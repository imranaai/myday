import 'package:flutter/material.dart';
import 'package:MyDay/HomeScreen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      checkFirstTime().then((isFirstTime) {
        if (isFirstTime) {
          // Navigate to the onboarding screens
          navigateToOnboarding();
        } else {
          // Navigate to the home screen
          navigateToHome();
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Add picture here
            Image.asset("assets/task.png"),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "My Day",
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.96,
              ),
            ),
            const Text(
              "Perfect App for daily To Do List",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;
    if (isFirstTime) {
      await prefs.setBool('first_time', false);
    }
    return isFirstTime;
  }

  void navigateToOnboarding() {
    // Navigate to onboarding screens
    Get.off(HomeScreen());
  }

  void navigateToHome() {
    // Navigate to home screen
    Get.off(HomeScreen());
  }
}
