import 'package:aa/view/HomeScreen.dart';
import 'package:flutter/material.dart';

import '../core/Navigation.dart';
import '../core/network/local/cache_helper.dart';
import 'OnBoarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Widget? widget;
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      if (onBoarding != null) {
        widget = const HomeScreen();
      } else {
        widget = OnBoarding();
      }
      navigateAndFinish(context, widget);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                height: 170,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
