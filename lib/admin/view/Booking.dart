import 'package:aa/controller/cubit.dart';
import 'package:aa/controller/states.dart';
import 'package:aa/core/Navigation.dart';
import 'package:aa/core/network/remote/dio_helper.dart';
import 'package:aa/core/widgets/CircularProgress.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Details.dart';
import 'HomeScreen.dart';

class Booking extends StatelessWidget {
  const Booking({super.key, required this.title, required this.province,});

  final String title;
  final String province;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(c)=>BookingAppCubit()..getBooking(
        province: province,
        name: title,
      ),
      child: BlocConsumer<BookingAppCubit,BookingAppStates>(
          listener: (context,state){},
          builder: (context,index){
            var cubit = BookingAppCubit.get(context);
            return WillPopScope(
              onWillPop: () async {
                navigateAndFinish(context,HomeScreen());
                return true;
              },
              child: SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
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
                          ConditionalBuilder(
                            condition: cubit.state is BookingSuccessState ,
                              builder: (c){
                                return ConditionalBuilder(
                                  condition:cubit.getBookingModel.isNotEmpty,
                                    builder: (c){
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: cubit.getBookingModel.length,
                                          itemBuilder:(context,index){
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    navigateTo(context,
                                                      Details(
                                                        title: cubit.getBookingModel[index].title,
                                                        images: cubit.getBookingModel[index].images,
                                                        price: cubit.getBookingModel[index].price,
                                                        desc: cubit.getBookingModel[index].desc,
                                                        province: cubit.getBookingModel[index].province,
                                                        phone: cubit.getBookingModel[index].phone,
                                                      ),);
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
                                                                      Expanded(child: Text(cubit.getBookingModel[index].title,textAlign: TextAlign.end,)),
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
                                                                              Text(cubit.getBookingModel[index].price,textAlign: TextAlign.end,),
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
                                                                            Text(cubit.getBookingModel[index].province,textAlign: TextAlign.end,style: TextStyle(color: Colors.white),),
                                                                            SizedBox(width: 4,),
                                                                            Image.asset('assets/images/mingcute_location-line (1).png',scale: 1.2,)
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height: 10,),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap: (){
                                                                              cubit.deleteBooking(
                                                                                id: cubit.getBookingModel[index].id.toString(),
                                                                              );
                                                                              // cubit.getBookingModel.removeWhere((item) => item.id == cubit.getBookingModel[index].id);
                                                                            },
                                                                            child: Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(4),
                                                                                  color: Color(0XFFFF5D60),
                                                                                ),
                                                                                child: Icon(Icons.delete,color: Colors.white,)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(cubit.getBookingModel[index].phone,textAlign: TextAlign.end,),
                                                                          SizedBox(width: 4,),
                                                                          Image.asset('assets/images/solar_phone-outline (1).png',scale: 1.2,)
                                                                        ],
                                                                      ),
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
                                                                  "$url/uploads/${cubit.getBookingModel[index].images[0]}",
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
            );
          },),
    );
  }
}
