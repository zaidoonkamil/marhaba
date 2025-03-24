import 'package:aa/core/Navigation.dart';
import 'package:aa/core/widgets/Card_Home.dart';
import 'package:aa/view/Booking.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cubit.dart';
import '../controller/states.dart';
import '../core/Constant.dart';
import '../core/network/remote/dio_helper.dart';
import '../core/widgets/CircularProgress.dart';
import '../core/widgets/show_toast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static CarouselController carouselController = CarouselController();
  static const List<String> stringWithoutBrackets = [
    'assets/images/Rectangle 27.png',
    'assets/images/Rectangle 27 (1).png',
    'assets/images/Rectangle 27 (2).png',
  ];
  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> BookingAppCubit()..getAds(),
    child: BlocConsumer<BookingAppCubit, BookingAppStates>(
      listener: (context, state) {
        if(state is ImageHomeErrorState){
          showToast(
              text: state.error,
              color: Colors.red,
          );
        }
      },
      builder: (context,index){
      var cubit = BookingAppCubit.get(context);
      return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('مرحبا',style: TextStyle(
                                  fontSize: 20,
                                ),textAlign: TextAlign.end,),
                                Text('بعودتك مجددا',style: TextStyle(
                                  fontSize: 12,
                                ),),
                              ],
                            ),
                            SizedBox(width: 4,),
                            Image.asset('assets/images/logo.png',scale: 5,),
                          ],
                        ),
                      ),
                      SizedBox(height: 22,),
                      ConditionalBuilder(
                        condition: cubit.state is AdsErrorState || cubit.state is AdsSuccessState || cubit.state is HomeImageState ,
                        builder:(c){
                          return ConditionalBuilder(
                              condition: cubit.getAdsModel.isNotEmpty,
                              builder: (context){
                                return Column(
                                  children: [
                                    CarouselSlider(
                                      items: cubit.getAdsModel.expand((entry) =>
                                          entry.images.map((imageUrl) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                              width: double.maxFinite,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  "$url/uploads/$imageUrl",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            );
                                          },
                                        );},
                                )).toList(),
                                      options: CarouselOptions(
                                        height: 160,
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
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: cubit.getAdsModel.asMap().entries.map((entry) {
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
                                  ],
                                );
                              },
                              fallback: (context)=> Container(),
                          );
                          },
                          fallback: (c)=> CircularProgress(),
                      ),
                      SizedBox(height: 16,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: Column(
                          children: [
                            CardHome(
                              title: 'حجز المزارع',
                              desc: 'استمتع بأجمل الأوقات في أرقى المزارع احجــــز مزرعتك الآن لقضاء يوم لا يُنسى وسط الطبيعة',
                              color: Color(0XFF366FFF),
                              image: 'assets/images/home/Rectangle 28.png',
                              color2:  Color(0XFF5BA7FF),
                              onTap: (){
                                navigateTo(context, Booking(
                                  province: '',
                                  title: 'حجز المزارع',),
                                );
                              },
                            ),
                            CardHome(
                              onTap: (){
                                navigateTo(context, Booking(
                                  province: '',
                                  title: 'حجز القاعات',),
                                );
                              },
                              title: 'حجز قاعات\nاعــــــراس\nومناسبـات',
                              desc: 'حفلتك تستحق الأفضل! احجز القاعة المثالية لمناسبتك الخاصة واجعل لحظاتك لا تُنســـــى',
                              color: Color(0XFFF5553C),
                              image: 'assets/images/home/Rectangle 28 (1).png',
                              color2:  Color(0XFFB6EA2E),
                            ),
                            CardHome(
                              onTap: (){
                                navigateTo(context, Booking(
                                  province: '',
                                  title: 'حجز الفساتين',),
                                );
                              },
                              title: 'حجز فساتين\nوجلســــــات\nتجميــــــــل',
                              desc: 'كوني الأجمل في يومك الكبير! اكتشفي أحــدث تصاميم بدلات العرائس واحجزي فستان أحلامك',
                              color: Color(0XFF8D46E4),
                              image: 'assets/images/home/Rectangle 28 (2).png',
                              color2:  Color(0XFF0A61E4),
                            ),
                            CardHome(
                              onTap: (){
                                navigateTo(context, Booking(
                                  title: 'اقسام اخرئ',
                                  province: '',
                                ),
                                );
                              },
                              title: 'حجز كوشـــات\nجلسات تصوير\nو اقسام اخــرئ',
                              desc: 'كل ما تحتاجه لإضفاء لمسة فريدة على مناسباتك نقدم لك تجربة راقية تلبي جميع احتياجاتــــــــك',
                              color: Color(0XFF366FFF),
                              image: 'assets/images/home/Rectangle 28 (3).png',
                              color2:  Color(0XFF5BA7FF),
                            ),
                          ],
                        ),
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
