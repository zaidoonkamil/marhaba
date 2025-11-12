import 'package:aa/auth/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Navigation.dart';
import 'network/local/cache_helper.dart';

String token='';
String id='';
String adminOrUser='' ;
String logo='logo.png';

Color primaryColor=Color(0XFF3064E8);
const Color secoundColor= Color(0XFF082A5C);
const Color thirdColor= Color(0XFFF5553C);

List<String> province=[
  "بغداد",
  "نينوى",
  "البصرة",
  "صلاح الدين",
  "دهوك",
  "أربيل",
  "السليمانية",
  "ديالى",
  "واسط",
  "ميسان",
  "ذي قار",
  "المثنى",
  "بابل",
  "كربلاء",
  "النجف",
  "الانبار",
  "الديوانية",
  "كركوك",
];

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    token='';
    adminOrUser='' ;
    id='' ;
    if (value)
    {
      CacheHelper.removeData(key: 'role',);
      CacheHelper.removeData(key: 'id',);
      navigateTo(context, const Login(),);
    }
  });
}