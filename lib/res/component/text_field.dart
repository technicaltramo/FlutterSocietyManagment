import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String vMessage;
  final String validationText;
  final Function validator;
  final Function onEditingComplete;
  final TextFieldType fieldType;
  final int maxLengh;

  AppTextFormField(
      {this.labelText = "Input",
      this.hintText = "Require*",
      this.fieldType = TextFieldType.TEXT,
      this.controller,
      this.vMessage = "Require*",
      this.validationText,
      this.validator,
      this.onEditingComplete,
      this.maxLengh = 56});

  bool isPassword = false;
  Icon inputIcon = Icon(Icons.input);
  String mHintText;

  String mLabelText;

  TextInputType textInputType = TextInputType.text;

  @override
  Widget build(BuildContext context) {
    mHintText = hintText;
    mLabelText = labelText;

    if (fieldType == TextFieldType.PASSWORD) {
      inputIcon = Icon((Icons.lock));
      mHintText = "******";
      mLabelText = "Password";
      isPassword = true;
      textInputType = TextInputType.visiblePassword;
    } else if (fieldType == TextFieldType.EMAIL) {
      inputIcon = Icon(Icons.email);
      mHintText = "abc@mymail123.xyz";
      mLabelText = "Email";
      textInputType = TextInputType.emailAddress;
    } else if (fieldType == TextFieldType.MOBILE) {
      textInputType = TextInputType.number;
    }
    else if(fieldType == TextFieldType.NUMBER){
      textInputType = TextInputType.number;
    }

    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        obscureText: isPassword,
        maxLength: (fieldType == TextFieldType.MOBILE) ? 10 : maxLengh,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.black26, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.black26, width: 1.5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[300], width: 1.2),
          ),
          labelText: mLabelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              fontStyle: FontStyle.normal),
          prefixIcon: inputIcon,
          hintText: mHintText,
          counter: SizedBox.shrink(),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black26,
          ),
        ),
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
      ),
    );
  }
}

enum TextFieldType { EMAIL, PASSWORD, NUMBER, MOBILE, TEXT,DOB }
