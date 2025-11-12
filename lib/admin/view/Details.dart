import 'package:aa/controller/cubit.dart';
import 'package:aa/controller/states.dart';
import 'package:aa/core/Constant.dart';
import 'package:aa/core/Navigation.dart';
import 'package:aa/core/network/remote/dio_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.title,
    required this.images,
    required this.price,
    required this.desc,
    required this.province,
    required this.phone,
  });

  static const List<String> stringWithoutBrackets = [
    'assets/images/Rectangle 27.png',
    'assets/images/Rectangle 27 (1).png',
    'assets/images/Rectangle 27 (2).png',
  ];
  static CarouselController carouselController = CarouselController();
  static int currentIndex = 0;
  final String title;
  final List<String> images;
  final String price;
  final String desc;
  final String province;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> BookingAppCubit(),
      child: BlocConsumer<BookingAppCubit, BookingAppStates>(
        listener: (context,state){

        },
      builder: (context,index){
        var cubit = BookingAppCubit.get(context);
        return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 22,),
                Stack(
                  children: [
                    CarouselSlider(
                      items:images.map((entry) {
                        // String imagePath = entry.image.toString();
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: double.maxFinite,
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                child: Image.network(
                                  "$url/uploads/$entry",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 0.85,
                        enlargeCenterPage: true,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 6),
                        autoPlayAnimationDuration:
                        const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          currentIndex=index;
                          cubit.homeImageState();
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        navigateBack(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 34,vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white
                        ),
                        child: Icon(Icons.arrow_back_ios_new_outlined,size: 32,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () {
                        carouselController.animateTo(
                          entry.key.toDouble(),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        width: currentIndex == entry.key ? 34 : 8,
                        height: 7.0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == entry.key
                                ? primaryColor
                                : Color(0XFFC1D1F9)),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      SizedBox(height: 22,),
                      Row(
                        children: [
                          Expanded(child: Text(title,textAlign: TextAlign.end,style: TextStyle(fontSize: 20,),)),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Text(desc,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 12,),
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 2.0),
                                      child: Text(province,style: TextStyle(color: Colors.white,fontSize: 16),),
                                    ),
                                    SizedBox(width: 4,),
                                    Image.asset('assets/images/mingcute_location-line (1).png'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 2.0),
                                        child: Row(
                                          children: [
                                            Text('د.ع',style: TextStyle(color: Colors.white,fontSize: 20),),
                                            Text(price,style: TextStyle(color: Colors.white,fontSize: 20),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Image.asset('assets/images/solar_tag-price-outline (1).png'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12.0),
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF22C05D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Text(phone,style: TextStyle(color: Colors.white,fontSize: 20),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }, ),
    );
  }
}
