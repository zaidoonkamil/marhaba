import 'package:aa/controller/cubit.dart';
import 'package:aa/core/Constant.dart';
import 'package:aa/core/Navigation.dart';
import 'package:aa/core/widgets/CircularProgress.dart';
import 'package:aa/view/Details.dart';
import 'package:aa/view/HomeScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/states.dart';
import '../core/widgets/show_toast.dart';
import 'Province.dart';

class Booking extends StatelessWidget {
  const Booking({super.key, required this.title,});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(c)=>BookingAppCubit()..bookingFarmFunc(name: title,newFilter: filter),
      child: BlocConsumer<BookingAppCubit,BookingAppStates>(
          listener: (context,state){
            if(state is FarmErrorState){
              showToast(
                text: state.error,
                color: Colors.red,
                context: context,
              );
            }
          },
          builder: (context,index){
            var cubit = BookingAppCubit.get(context);
            return WillPopScope(
              onWillPop: () async {
                filter='';
                navigateAndFinish(context,HomeScreen());
                return true;
              },
              child: SafeArea(
                child: Scaffold(
                  body: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!cubit.isLoading &&
                          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                        cubit.bookingFarmFunc(name: title);
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    navigateAndFinish(context, HomeScreen());
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.black87,
                                    size: 26,
                                  ),
                                ),
                                Text(title,style: TextStyle(fontSize: 20),),
                                SizedBox(width: 24,height: 24,),
                              ],
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: (){
                                   navigateTo(context, Province(title: title,));
                              },
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text('فلتر حسب المحافظة',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ),
                            SizedBox(height: 16,),
                            ConditionalBuilder(
                                condition: cubit.state is FarmSuccessState ,
                                builder: (c){
                                  return ConditionalBuilder(
                                      condition:cubit.booking.isNotEmpty,
                                      builder: (c){
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: cubit.booking.length,
                                            itemBuilder:(context,index){
                                              return Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      navigateTo(context,
                                                          Details(
                                                            title: cubit.booking[index].title,
                                                            images: cubit.booking[index].images,
                                                            price: cubit.booking[index].price,
                                                            desc: cubit.booking[index].desc,
                                                            province: cubit.booking[index].province,
                                                            phone: cubit.booking[index].phone,
                                                          ));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.2),
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                            offset: Offset(2, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Expanded(child: Text(cubit.booking[index].title,textAlign: TextAlign.end,)),
                                                                        SizedBox(width: 4,),
                                                                        Image.asset('assets/images/akar-icons_home.png',scale: 1.2,)
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text('د.ع',textAlign: TextAlign.end,),
                                                                                Text(cubit.booking[index].price,textAlign: TextAlign.end,),
                                                                              ],
                                                                            ),
                                                                            SizedBox(width: 4,),
                                                                            Image.asset('assets/images/solar_tag-price-outline.png',scale: 1.2,)
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(4),
                                                                            color: Color(0XFFFF5D60),
                                                                          ),
                                                                          child: Row(
                                                                            children: [
                                                                              Text(cubit.booking[index].province,textAlign: TextAlign.end,style: TextStyle(color: Colors.white),),
                                                                              SizedBox(width: 4,),
                                                                              Image.asset('assets/images/mingcute_location-line (1).png',scale: 1.2,)
                                                                            ],
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Expanded(child: Text(cubit.booking[index].phone,textAlign: TextAlign.end,)),
                                                                        SizedBox(width: 4,),
                                                                        Image.asset('assets/images/solar_phone-outline (1).png',scale: 1.2,)
                                                                      ],
                                                                    ),
                                                                  ],),
                                                              ),
                                                            ),
                                                            Column(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                  child: Image.network(
                                                                    cubit.booking[index].images[0],
                                                                    width: 110,
                                                                    height: 110,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ],),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 14,),
                                                ],
                                              );
                                            });
                                      },
                                      fallback: (c)=>Column(
                                        children: [
                                          SizedBox(height: 30,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text('حدث خطأ اثناء جلب البيانات',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                  );
                                },
                              fallback: (c)=>ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                  itemBuilder: (c,i){
                                return CircularProgress();
                              },),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },),
    );
  }
}
