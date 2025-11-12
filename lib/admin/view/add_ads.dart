import 'dart:io';
import 'dart:typed_data';

import 'package:aa/core/Navigation.dart';
import 'package:aa/core/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/widgets/show_toast.dart';
import 'home.dart';

class AddAds extends StatefulWidget {
  @override
  _AddAdsState createState() => _AddAdsState();
}

class _AddAdsState extends State<AddAds> {

  bool _isUploading = false;
  List<XFile> selectedImages = [];

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> resultList = await picker.pickMultiImage();

    if (resultList.isNotEmpty) {
      setState(() {
        selectedImages = resultList;
      });
    }
  }
  void uploadImages() async {

    if (selectedImages.isEmpty) {
      showToast(text: "❌ الرجاء اختيار صور أولاً!", color: Colors.redAccent);
      return;
    }

    setState(() {
      _isUploading = true;
    });
    try {
      FormData formData = FormData();
      for (var file in selectedImages) {
        formData.files.add(
            MapEntry(
          "images",
          await MultipartFile.fromFile(
              file.path, filename: file.name,
            contentType: MediaType('image', 'jpeg'),
          ),
        ));
      }
      DioHelper.postData(
        url: '/ads',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      ).then((value) {
        print("✅ تم رفع البيانات بنجاح: ${value.data}");
        showToast(text: "✅ تم رفع الصور بنجاح!", color: Colors.green);
      }).catchError((error) {
        if (error is DioException) {
          print("❌ DioError: ${error.response?.data ?? error.message}");
        } else {
          print("❌ Unknown Error: $error");
        }
      }).whenComplete(() {
        setState(() {
          _isUploading = false;
        });
      });

    } catch (error) {
      print("❌ Error: $error");
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 22,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        navigateAndFinish(context, Home());
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black87,
                        size: 26,
                      ),
                    ),
                    Row(
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

                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectedImages.isNotEmpty
                        ? SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.file(File(selectedImages[index].path), height: 150),
                          );
                        },
                      ),
                    ) : Icon(Icons.image, size: 100, color: Colors.grey),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: pickImages,
                      child: Text("📂 اختر صورة من الجهاز"),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isUploading ? null : uploadImages,
                      child: _isUploading ? CircularProgressIndicator() : Text("⬆ رفع الصورة"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
