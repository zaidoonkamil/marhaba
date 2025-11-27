
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

class GetProfileLoadingState extends BookingAppStates {}
class GetProfileSuccessState extends BookingAppStates {}
class GetProfileErrorState extends BookingAppStates {}

class BookingLoadingState extends BookingAppStates {}
class BookingSuccessState extends BookingAppStates {}
class BookingErrorState extends BookingAppStates {}

class PendingLoadingState extends BookingAppStates {}
class PendingSuccessState extends BookingAppStates {}
class PendingErrorState extends BookingAppStates {}

class PostBookingLoadingState extends BookingAppStates {}
class PostBookingSuccessState extends BookingAppStates {}
class PostBookingErrorState extends BookingAppStates {}

class UpdateStateLoadingState extends BookingAppStates {}
class UpdateStateSuccessState extends BookingAppStates {}
class UpdateStateErrorState extends BookingAppStates {}
