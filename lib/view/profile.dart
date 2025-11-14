import 'package:aa/auth/view/login.dart';
import 'package:aa/controller/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/show_toast.dart';
import '../controller/cubit.dart';
import '../core/Constant.dart';
import '../core/Navigation.dart';
import '../core/widgets/custom_text_field.dart';
import 'how_as.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingAppCubit()..getProfile(context: context),
      child: BlocConsumer<BookingAppCubit,BookingAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=BookingAppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: token == ''? Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    navigateTo(context, Login());
                  },
                  child: Text(
                    "سجّل الدخول أولًا",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
                  :ConditionalBuilder(
                  condition:  cubit.profileModel != null,
                  builder: (context){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 24,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset('assets/images/$logo',height: 80,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.profileModel!.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4,),
                                  Text(
                                    cubit.profileModel!.phone,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 60,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Color(0XFFF9FAFA),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade300 ,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FaIcon(FontAwesomeIcons.imagePortrait,color: primaryColor, size: 20),
                                      Text(cubit.profileModel!.name.toString(),style: TextStyle(color: Color(0XFF949D9E)),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Color(0XFFF9FAFA),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade300 ,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FaIcon(FontAwesomeIcons.phone,color: primaryColor, size: 20),
                                      Text(cubit.profileModel!.phone.toString(),style: TextStyle(color: Color(0XFF949D9E)),),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(height: 8,),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(horizontal: 12),
                              //   decoration: BoxDecoration(
                              //     color: Color(0XFFF9FAFA),
                              //     borderRadius: BorderRadius.circular(8),
                              //     border: Border.all(
                              //       color: Colors.grey.shade300 ,
                              //       width: 1,
                              //     ),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         FaIcon(FontAwesomeIcons.location,color: primaryColor, size: 20),
                              //         Text(cubit.profileModel!.location.toString(),style: TextStyle(color: Color(0XFF949D9E)),),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 60,),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      title: Text("هل حقا ترغب في تسجيل الخروج ؟",
                                        style: TextStyle(fontSize: 18),
                                        textAlign: TextAlign.center,),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("إلغاء",style: TextStyle(color: primaryColor),),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () {
                                              signOut(context);
                                            },
                                            child: Text("نعم",style: TextStyle(color: Colors.white),),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 41,
                                width: double.maxFinite,
                                color: primaryColor.withOpacity(0.1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FaIcon(FontAwesomeIcons.signOutAlt,color: primaryColor, size: 18),
                                    Text(
                                      'تسجيل الخروج',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: 0,height: 2,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      title: Text("هل حقا ترغب في حذف الحساب ؟",
                                        style: TextStyle(fontSize: 18),
                                        textAlign: TextAlign.center,),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("إلغاء",style: TextStyle(color: primaryColor),),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              showToast(
                                                  text: 'تم ارسال طلبك وسوف يتم الرد عليك قريبا',
                                                  color: primaryColor);
                                            },
                                            child: Text("نعم",style: TextStyle(color: Colors.white),),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 41,
                                width: double.maxFinite,
                                color: primaryColor.withOpacity(0.1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FaIcon(FontAwesomeIcons.trash,color: primaryColor, size: 18),
                                    Text(
                                      'حذف الحساب',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: 0,height: 10,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  fallback: (c)=>Center(child: CircularProgressIndicator(color: primaryColor,))
              ),
            ),
          );
        },
      ),
    );
  }
}
