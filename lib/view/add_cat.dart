import 'dart:io';
import 'package:aa/core/network/remote/dio_helper.dart';
import 'package:aa/core/widgets/show_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../core/Constant.dart';
import '../core/widgets/custom_text_field.dart';

class AddCatUser extends StatefulWidget {
  @override
  _AddCatUserState createState() => _AddCatUserState();
}

class _AddCatUserState extends State<AddCatUser> {

  bool _isUploading = false;
  List<XFile> selectedImages = [];

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController titleController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static TextEditingController provinceController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController descController = TextEditingController();
  String? selectedValue;
  List<String> items = ["farm", "adress", "hall", "anothe", "tourism"];
  List<String> imageUrls = [];

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
      FormData formData = FormData.fromMap({
        "title": titleController.text.trim(),
        "desc": descController.text.trim(),
        "price": priceController.text.trim(),
        "province": provinceController.text.trim(),
        "phone": phoneController.text.trim(),
        "status": "pending",
      });
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
        url: '/$selectedValue',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      ).then((value) {
        titleController.text='';
        descController.text='';
        priceController.text='';
        descController.text='';
        phoneController.text='';
        selectedImages = [];
        selectedValue = "";
        print("✅ تم رفع البيانات بنجاح: ${value.data}");
        showToast(text: "✅ تم رفع البيانات بنجاح", color: Colors.green);
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
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
                  ) :
                  GestureDetector(
                      onTap: pickImages,
                      child: Icon(Icons.image, size: 80, color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0XFFF9FAFA),
                            border: Border.all(color:Colors.grey.shade300 , width: 1),
                          ),
                          child: DropdownButton<String>(
                            value: selectedValue,
                            hint: Text("اختر خيارًا",style: TextStyle(color: Color(0XFF949D9E)),),
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            underline: Container(),
                            alignment: Alignment.centerRight,
                            items: items.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                alignment: Alignment.centerRight,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: 'ادخل العنوان',
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا ادخل العنوان';
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: 'رقم الهاتف',
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا ادخل رقم الهاتف';
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: 'ادخل المحافظة',
                          controller: provinceController,
                          keyboardType: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا ادخل المحافظة';
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: 'ادخل السعر',
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا ادخل السعر';
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: 'ادخل الوصف',
                          controller: descController,
                          keyboardType: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا ادخل الوصف';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                  onTap: (){
                    if (formKey.currentState!.validate()) {
                      if (selectedValue != null && selectedValue!.isNotEmpty && selectedImages.isNotEmpty) {
                        uploadImages();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("❌ الرجاء اختيار فئة وإضافة صور قبل الرفع")),
                        );
                      }
                    }
                  },
                  child:_isUploading ? CircularProgressIndicator(): Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(12),
                        color: primaryColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ارسال',
                          style: TextStyle(color: Colors.white,fontSize: 16 ),),
                      ],
                    ),
                  ),
                ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
