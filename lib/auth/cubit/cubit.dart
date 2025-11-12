import 'package:aa/auth/cubit/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/remote/dio_helper.dart';
import '../../../core/widgets/show_toast.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void validation(){
    emit(ValidationState());
  }

  bool isPasswordHidden = true;
  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(PasswordVisibilityChanged());
  }

  bool isPasswordHidden2 = true;
  void togglePasswordVisibility2() {
    isPasswordHidden2 = !isPasswordHidden2;
    emit(PasswordVisibilityChanged());
  }


  signUp({required String name, required String phone, required String password, required String location, required String role, required BuildContext context,}){
    emit(SignUpLoadingState());
    DioHelper.postData(
      url: '/users',
      data:
      {
        'name': name,
        'phone': phone,
        'role': role,
        'location': location,
        'password': password,
      },
    ).then((value) {
      emit(SignUpSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        print(error.response?.data["error"]);
        showToast(
          text: error.response?.data["error"],
          color: Colors.red,
        );
        emit(SignUpErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  String? token;
  String? role;
  String? id;
  String? phonee;
  bool? isVerified;

  signIn({required String phone, required String password,required BuildContext context,}){
    emit(LoginLoadingState());
    DioHelper.postData(
      url: '/login',
      data:
      {
        'phone': phone,
        'password': password,
      },
    ).then((value) {
     token=value.data['token'];
     role=value.data['user']['role'];
     id=value.data['user']['id'].toString();
     phonee=value.data['user']['phone'].toString();
     isVerified=value.data['user']['isVerified'];
     emit(LoginSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToast(
          text: error.response?.data["error"],
          color: Colors.red,
        );
        emit(LoginErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  sendOtp({required String phone ,required BuildContext context,}){
    emit(LoginLoadingState());
    DioHelper.postData(
      url: '/send-otp',
      data: {
        'phone': phone ,
      },
    ).then((value) {
      emit(LoginSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToast(
          text: error.response?.data["error"],
          color: Colors.red,
        );
        emit(LoginErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  verifyOtp({required String phone ,required String code ,required BuildContext context,}){
    emit(VerifyOtpLoadingState());
    DioHelper.postData(
      url: '/verify-otp',
      data: {
        'phone': phone ,
        'code': code ,
      },
    ).then((value) {
      emit(VerifyOtpSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToast(
          text: error.response?.data["error"],
          color: Colors.red,
        );
        emit(VerifyOtpErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

}