import 'package:aa/controller/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/BookingFarm.dart';

class BookingAppCubit extends Cubit<BookingAppStates> {
  BookingAppCubit() : super(BookingAppInitialState());

  static BookingAppCubit get(context) => BlocProvider.of(context);

  void homeImageState() {
    emit(HomeImageState());
  }

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<void> fetchImages() async {
    try {
        emit(ImageHomeLoadingState());
        QuerySnapshot snapshot = await firestore.
        collection("ads").get();

        List<String> urls = snapshot.docs
            .map((doc) => doc["image"] as String).toList();
        imageUrls = urls;
        emit(ImageHomeSuccessState());
    } catch (e) {
      emit(ImageHomeErrorState("Error fetching images: $e"));
    }
  }

  bool isLoading = false;
  String duc='';
  List<BookingFarm> booking = [];
  String currentCategory = '';
  DocumentSnapshot? lastDocument;

  Future<void> bookingFarmFunc({required String name, String? newFilter}) async {
    if (isLoading) return;

    if (newFilter != null) {
      filter = newFilter;
      booking.clear();
      lastDocument = null;
    }

    if (name == 'حجز المزارع') {
      duc = 'farm';
    } else if (name == 'حجز القاعات') {
      duc = 'Suits';
    }else if(name=='اقسام اخرئ'){
      duc='Other';
    } else {
      duc = 'hall';
    }

    isLoading = true;
    emit(HomeImageState());

    Query query = FirebaseFirestore.instance.collection(duc);

    if (filter.isNotEmpty) {
      query = query.where('province', isEqualTo: filter);
    }

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    QuerySnapshot snapshot = await query.limit(5).get();

    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
      List<BookingFarm> newFarms = snapshot.docs.map((doc) {
        return BookingFarm(
          title: doc["title"],
          images: List<String>.from(doc["image"]),
          price: doc["price"],
          desc: doc["desc"],
          province: doc["province"],
          phone: doc["phone"],
        );
      }).toList();

      booking.addAll(newFarms);
    }

    isLoading = false;
    if (!isClosed) emit(FarmSuccessState());
  }
}

String filter='';
List<String> imageUrls = [];
// Future<void> bookingFarmFunc({required String name}) async {
//   if(name=='حجز المزارع') {
//     duc='farm';
//   }else if(name=='حجز القاعات'){
//     duc='Suits';
//   }else{duc='hall';}
//   emit(HomeImageState());
//
//   QuerySnapshot snapshot;
//     if(filter != ''){
//       snapshot = await FirebaseFirestore.instance
//           .collection(duc)
//           .where('province',isEqualTo: filter)
//           .get();
//
//     }else{
//       snapshot = await FirebaseFirestore.instance
//           .collection(duc)
//           .get();
//     }
//
//   if (snapshot.docs.isNotEmpty) {
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
//     booking.addAll(newFarms);
//     if (!isClosed) emit(HomeImageState());
//
//   } else {
//     if (!isClosed) emit(HomeImageState());
//   }
// }
