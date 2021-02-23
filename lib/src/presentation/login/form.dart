import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/text_field.dart';
import 'package:t_society/res/component/widget.dart';
import 'controller.dart';

class LoginForm extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Form(
            key: controller.loginFormKey,
            child: Column(
              children: <Widget>[
                //email form field
                AppTextFormField(
                    validator: (String value) {
                      return (value.length < 6)
                          ? "can't be less than 4 character"
                          : null;
                    },
                    fieldType: TextFieldType.EMAIL,
                    controller: controller.emailController),
                //password form field
                AppTextFormField(
                    validator: (String value) {
                      return (value.length < 6)
                          ? "can't be less than 6 character"
                          : null;
                    },
                    fieldType: TextFieldType.PASSWORD,
                    controller: controller.passwordController),
                AppWidget.height(value: 24),
                //login button

                AppButton(
                    buttonText: "Login",
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    onPress: () {
                      controller.onLoginClick(context);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

}
