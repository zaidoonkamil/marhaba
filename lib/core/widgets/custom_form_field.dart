import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  CustomFormField(
      {Key? key,
        this.hintText,
        this.onTap,
        this.textInputType,
        this.width,
        this.validate,
        this.suffix,
        this.controller,
        this.onTapp,
        this.onChanged,
        this.height,
        this.textAlign,
        this.maxLines,
        this.icon,
        this.colorBorder,
        this.obscureText = false
      }) : super(key: key);

  void Function(String)? onTapp;
  void Function()? onTap;
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  double? width;
  double? height;
  Color? colorBorder;
  bool? obscureText;
  TextInputType? textInputType;
  TextAlign? textAlign;
  int? maxLines=1;
  Widget? suffix;
  Icon? icon;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height:height?? 78,
          child: TextFormField(
            onChanged: onChanged,
            maxLines: maxLines,
            onFieldSubmitted: onTapp,
            onTap: onTap,
            controller: controller,
            keyboardType:textInputType?? TextInputType.text ,
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            obscureText: obscureText!,
            validator: validate,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: icon,
              // hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              //   color:hintTextColor,
              // ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:colorBorder?? Theme.of(context).primaryColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:  Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(30),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color:colorBorder?? Theme.of(context).primaryColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}