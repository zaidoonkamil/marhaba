import 'package:aa/controller/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/network/remote/dio_helper.dart';
import '../core/widgets/show_toast.dart';
import '../model/GetAdsModel.dart';
import '../model/GetBookingModel.dart';

class BookingAppCubit extends Cubit<BookingAppStates> {
  BookingAppCubit() : super(BookingAppInitialState());

  static BookingAppCubit get(context) => BlocProvider.of(context);

  void homeImageState() {
    emit(HomeImageState());
  }

  List<GetAds> getAdsModel = [];
  void getAds() {
    emit(AdsLoadingState());
    DioHelper.getData(
      url: '/ads',
    ).then((value) {
      getAdsModel = (value.data as List)
          .map((item) => GetAds.fromJson
        (item as Map<String, dynamic>)).toList();
      emit(AdsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(text: error.toString(), color: Colors.redAccent);
        print(error.toString());
        emit(AdsErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  String duc='';
  List<GetBooking> getBookingModel = [];
  void getBooking({required String province,required String name}) {
    emit(BookingLoadingState());
      if (name == 'حجز المزارع') {
        duc = 'farm';
      } else if (name == 'حجز القاعات') {
        duc = 'hall';
      }else if(name=='اقسام اخرئ'){
        duc='anothe';
      } else {
        duc = 'adress';
      }
    DioHelper.getData(
      url: '/$duc?province=$province',
    ).then((value) {
      getBookingModel = (value.data as List)
          .map((item) => GetBooking.fromJson
        (item as Map<String, dynamic>)).toList();
      emit(BookingSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(text: error.toString(), color: Colors.redAccent);
        print(error.toString());
        emit(BookingErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

}

String filter='';
List<String> imageUrls = [];

// final FirebaseFirestore firestore =
//     FirebaseFirestore.instance;
//
// Future<void> fetchImages() async {
//   try {
//       emit(ImageHomeLoadingState());
//       QuerySnapshot snapshot = await firestore.
//       collection("ads").get();
//
//       List<String> urls = snapshot.docs
//           .map((doc) => doc["image"] as String).toList();
//       imageUrls = urls;
//       emit(ImageHomeSuccessState());
//   } catch (e) {
//     emit(ImageHomeErrorState("Error fetching images: $e"));
//   }
// }

//
// bool isLoading = false;
// String duc='';
// List<BookingFarm> booking = [];
// String currentCategory = '';
// DocumentSnapshot? lastDocument;
//
//
//
// Future<void> bookingFarmFunc({required String name, String? newFilter}) async {
//   if (isLoading) return;
//
//   if (newFilter != null) {
//     filter = newFilter;
//     booking.clear();
//     lastDocument = null;
//   }
//
//   if (name == 'حجز المزارع') {
//     duc = 'farm';
//   } else if (name == 'حجز القاعات') {
//     duc = 'Suits';
//   }else if(name=='اقسام اخرئ'){
//     duc='Other';
//   } else {
//     duc = 'hall';
//   }
//
//   isLoading = true;
//   emit(HomeImageState());
//
//   Query query = FirebaseFirestore.instance.collection(duc);
//
//   if (filter.isNotEmpty) {
//     query = query.where('province', isEqualTo: filter);
//   }
//
//   if (lastDocument != null) {
//     query = query.startAfterDocument(lastDocument!);
//   }
//
//   QuerySnapshot snapshot = await query.limit(5).get();
//
//   if (snapshot.docs.isNotEmpty) {
//     lastDocument = snapshot.docs.last;
//     List<BookingFarm> newFarms = snapshot.docs.map((doc) {
//       return BookingFarm(
//         title: doc["title"],
//         images: List<String>.from(doc["image"]),
//         price: doc["price"],
//         desc: doc["desc"],
//         province: doc["province"],
//         phone: doc["phone"],
//       );
//     }).toList();
//
//     booking.addAll(newFarms);
//   }
//
//   isLoading = false;
//   if (!isClosed) emit(FarmSuccessState());
// }
