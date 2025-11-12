import 'package:flutter/material.dart';
import '../../core/network/local/cache_helper.dart';
import '../auth/view/login.dart';
import '../core/Constant.dart';
import '../core/Navigation.dart';

class HowAs extends StatelessWidget {
  const HowAs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        token != ''? GestureDetector(
                            onTap: (){
                              navigateBack(context);
                            },
                            child: Icon(Icons.arrow_back_ios_new)):Container(),
                        const Text(
                          textAlign: TextAlign.right,
                          'سياسة الاستخدام',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 22),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 12,),
                           Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'ةيسمةنؤ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                        ],
                      ),
                    ),
                    SizedBox(height: 26,),
                  ],
                ),
              ),
            ),
            token != ''? Container():Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    CacheHelper.saveData(key: 'onBoarding',value: true );
                    navigateAndFinish(context, Login());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
                    margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('موافق',style: TextStyle(fontSize: 16,color: Colors.white),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
