
abstract class BookingAppStates {}

class BookingAppInitialState extends BookingAppStates {}

class HomeImageState extends BookingAppStates {}

class ImageHomeLoadingState extends BookingAppStates {}
class ImageHomeSuccessState extends BookingAppStates {}
class ImageHomeErrorState extends BookingAppStates {
  final String error;

  ImageHomeErrorState(this.error);
}


class AdsLoadingState extends BookingAppStates {}
class AdsSuccessState extends BookingAppStates {}
class AdsErrorState extends BookingAppStates {}

class BookingLoadingState extends BookingAppStates {}
class BookingSuccessState extends BookingAppStates {}
class BookingErrorState extends BookingAppStates {}
