import 'package:aa/view/SplashScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'bloc_observer.dart';
import 'core/Theme.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booking app',
      theme: ThemeService().lightTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(), 
    );
  }
}