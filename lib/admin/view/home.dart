import 'package:aa/admin/view/HomeScreen.dart';
import 'package:aa/admin/view/peending.dart';
import 'package:aa/core/Navigation.dart';
import 'package:aa/view/profile.dart';
import 'package:flutter/material.dart';

import 'add_ads.dart';
import 'add_cat.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        navigateTo(context, HomeScreen());
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blue,
                          ),
                          child: Icon(Icons.remove_red_eye_outlined,color: Colors.white,size: 34,)),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        navigateTo(context, AddAds());
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0XFFFF5D60),
                          ),
                          child: Icon(Icons.add_a_photo_outlined,color: Colors.white,size: 34,)),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        navigateTo(context, AddCat());
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.green,
                          ),
                          child: Icon(Icons.add,color: Colors.white,size: 34,)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        navigateTo(context, Profile());
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blue,
                          ),
                          child: Icon(Icons.person,color: Colors.white,size: 34,)),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        navigateTo(context, Pending());
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.orange,
                          ),
                          child: Icon(Icons.account_balance_outlined,color: Colors.white,size: 34,)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
