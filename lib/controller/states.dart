
abstract class BookingAppStates {}

class BookingAppInitialState extends BookingAppStates {}

class HomeImageState extends BookingAppStates {}

class ImageHomeLoadingState extends BookingAppStates {}
class ImageHomeSuccessState extends BookingAppStates {}
class ImageHomeErrorState extends BookingAppStates {
  final String error;

  ImageHomeErrorState(this.error);
}

class FarmLoadingState extends BookingAppStates {}
class FarmSuccessState extends BookingAppStates {}
class FarmErrorState extends BookingAppStates {
  final String error;

  FarmErrorState(this.error);
}