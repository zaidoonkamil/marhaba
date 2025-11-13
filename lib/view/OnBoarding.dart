import 'package:aa/core/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

import '../auth/view/login.dart';
import '../core/Navigation.dart';
import '../core/network/local/cache_helper.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 26.0),
        child: OnBoard(
          pageController: _pageController,
          onSkip: () {
            CacheHelper.saveData(key: 'onBoarding',value: true );
            navigateAndFinish(context, const Login());
          },
          onDone: () {
            CacheHelper.saveData(key: 'onBoarding',value: true );
            navigateAndFinish(context, const Login());
          },
          onBoardData: onBoardData,
          titleStyles: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.15,
          ),
          imageHeight: 220,
          imageWidth: 260,
          descriptionStyles: TextStyle(
            fontSize: 14,
            color: Colors.black45,
          ),
          pageIndicatorStyle: PageIndicatorStyle(
            width: 40,
            inactiveColor: Theme.of(context).dividerColor,
            activeColor: primaryColor,
            inactiveSize: const Size(6, 6),
            activeSize: const Size(8, 8),
          ),
          skipButton: TextButton(
            onPressed: () {
               CacheHelper.saveData(key: 'onBoarding',value: true );
              navigateAndFinish(context, const Login());
            },
            child: Text(
              "التالي",
              style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),
            ),
          ),
          nextButton: OnBoardConsumer(
            builder: (context, ref, child) {
              final state = ref.watch(onBoardStateProvider);
              return GestureDetector(
                onTap: () => _onNextTap(state,context),
                child: Container(
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient:  LinearGradient(
                      colors: [primaryColor,primaryColor],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? "الرئيسية" : "التالي",
                    style:  const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState,context) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
       CacheHelper.saveData(key: 'onBoarding',value: true );
      navigateAndFinish(context, const Login());
    }
  }
}

final List<OnBoardModel> onBoardData = [
  OnBoardModel(
    title: "تطبيق مرحبا",
    description:
    "تطبيق حجز مزارع و حجز بدلات العراس وقاعات \n للمناسبات الخاصة",
    imgUrl: "assets/images/logo.png",
  ),
  OnBoardModel(
    title: "حجز المزارع",
    description:
    "استمتع بأجمل الأوقات في أرقى المزارع! احجز \nمزرعتك الآن لقضاء يوم لا يُنسى وسط الطبيعة",
    imgUrl: 'assets/images/Rectangle 27.png',
  ),
  OnBoardModel(
    title: "حجز بدلات العرائس",
    description:
    "كوني الأجمل في يومك الكبير! اكتشفي أحدث \nتصاميم بدلات العرائس واحجزي فستان أحلامك \nبسهولة",
    imgUrl: 'assets/images/Rectangle 27 (1).png',
  ),
  OnBoardModel(
    title: " حجز القاعات للمناسبات",
    description:
    "حفلتك تستحق الأفضل! احجز القاعة المثالية\n لمناسبتك الخاصة واجعل لحظاتك لا تُنسى",
    imgUrl: 'assets/images/Rectangle 27 (2).png',
  ),
];