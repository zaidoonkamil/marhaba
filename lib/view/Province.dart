import 'package:aa/controller/cubit.dart';
import 'package:aa/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/Constant.dart';
import '../core/Navigation.dart';
import 'Booking.dart';

class Province extends StatelessWidget {
  const Province({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>BookingAppCubit(),
    child: BlocConsumer<BookingAppCubit,BookingAppStates>(
        listener: (context,state){},
        builder: (context,index){
          var cubit = BookingAppCubit.get(context);
          return SafeArea(
            child:Scaffold(
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
                              navigateBack(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black87,
                              size: 26,
                            ),
                          ),
                          Text('فلتر',style: TextStyle(fontSize: 20),),
                          SizedBox(width: 34,height: 24,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: province.length,
                        itemBuilder:(context,index){
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  filter=province[index];
                                  cubit.booking=[];
                                  cubit.lastDocument = null;
                                  //   cubit.bookingFarmFunc(name: title);
                                  cubit.homeImageState();
                                  navigateAndFinish(context, Booking(title: title));
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
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/fluent_edit-20-regular.png',

                                        ),
                                        Text('           ${province[index]}',),
                                        Text(': المحافظة'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 18,),
                            ],
                          );
                        },),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          navigateBack(context);
                        },
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text('حفظ',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    ),
    );
  }
}
