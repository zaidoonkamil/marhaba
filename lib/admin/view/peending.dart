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

class Pending extends StatelessWidget {
  const Pending({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(c)=>BookingAppCubit()..getPending(),
      child: BlocConsumer<BookingAppCubit,BookingAppStates>(
        listener: (context,state){},
        builder: (context,index){
          var cubit = BookingAppCubit.get(context);
          return SafeArea(
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
                          Text('طلبات النشر',style: TextStyle(fontSize: 20),),
                          SizedBox(width: 24,height: 24,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      ConditionalBuilder(
                        condition: cubit.state is! PendingLoadingState ,
                        builder: (c){
                          return ConditionalBuilder(
                            condition:cubit.pendingModelModel.isNotEmpty,
                            builder: (c){
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cubit.pendingModelModel.length,
                                  itemBuilder:(context,index){
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            navigateTo(context,
                                              Details(
                                                title: cubit.pendingModelModel[index].title,
                                                images: cubit.pendingModelModel[index].images,
                                                price: cubit.pendingModelModel[index].price,
                                                desc: cubit.pendingModelModel[index].desc,
                                                province: cubit.pendingModelModel[index].province,
                                                phone: cubit.pendingModelModel[index].phone,
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
                                                              Expanded(child: Text(cubit.pendingModelModel[index].title,textAlign: TextAlign.end,)),
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
                                                                      Text(cubit.pendingModelModel[index].price,textAlign: TextAlign.end,),
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
                                                                    Text(cubit.pendingModelModel[index].province,textAlign: TextAlign.end,style: TextStyle(color: Colors.white),),
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
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(cubit.pendingModelModel[index].phone,textAlign: TextAlign.end,),
                                                                  SizedBox(width: 4,),
                                                                  Image.asset('assets/images/solar_phone-outline (1).png',scale: 1.2,)
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              InkWell(
                                                                onTap: (){
                                                                  cubit.updateState(
                                                                    id: cubit.pendingModelModel[index].id.toString(),
                                                                    type: cubit.pendingModelModel[index].type,
                                                                    state: "rejected",
                                                                  );
                                                                },
                                                                child: Container(
                                                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color: Color(0XFFFF5D60),
                                                                    ),
                                                                    child: Icon(Icons.delete,color: Colors.white,)),
                                                              ),
                                                              InkWell(
                                                                onTap: (){
                                                                  cubit.updateState(
                                                                    id: cubit.pendingModelModel[index].id.toString(),
                                                                    type: cubit.pendingModelModel[index].type,
                                                                    state: "accepted",
                                                                  );
                                                                },
                                                                child: Container(
                                                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color: Colors.green,
                                                                    ),
                                                                    child: Icon(Icons.check_circle_outline_sharp,color: Colors.white,)),
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
                                                          "$url/uploads/${cubit.pendingModelModel[index].images[0]}",
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
                                      child: Text('لا يوجد بيانات لعرضها',
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
          );
        },),
    );
  }
}
