import 'package:aa/admin/view/home.dart';
import 'package:aa/view/HomeScreen.dart';
import 'package:flutter/material.dart';

import '../auth/view/login.dart';
import '../core/Constant.dart';
import '../core/Navigation.dart';
import '../core/navigation_bar/navigation_bar.dart';
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
      if(CacheHelper.getData(key: 'token') == null){
        token='';
        if (onBoarding == true) {
          widget = BottomNavBar();
        } else {
          widget = OnBoarding();
        }
      }else{
        if(CacheHelper.getData(key: 'role') == null){
          widget = BottomNavBar();
          adminOrUser='user';
        }else{
          adminOrUser = CacheHelper.getData(key: 'role');
          if (adminOrUser == 'admin') {
            widget = Home();
          }else{
            widget = BottomNavBar();
          }
        }
        token = CacheHelper.getData(key: 'token') ;
        id = CacheHelper.getData(key: 'id') ??'' ;
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
