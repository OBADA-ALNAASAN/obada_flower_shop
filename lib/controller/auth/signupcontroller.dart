import 'package:flower_shop/core/class/statusrequest.dart';
import 'package:flower_shop/core/constant/app_routes.dart';
import 'package:flower_shop/core/data/remote/auth/signupdata.dart';
import 'package:flower_shop/core/function/handlingdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class SignupController extends GetxController {
  goToLogin();
  signup();
}

class SignupControllerImp extends SignupController {
  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController repassword;
  late TextEditingController phonenumber;
  SignUpData signUpData = SignUpData(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  
  StatusRequest? statusRequest;
  @override
  signup() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await signUpData.postData(email.text, password.text,
          repassword.text, phonenumber.text, username.text);
     
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['success']) {
          Get.offNamed(AppRoutes.verificationScreen, arguments: {
            "email":email.text
          });
        } else {
          Get.defaultDialog(
              title: "Warning", middleText: "The identifier field is required");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();
    phonenumber = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    repassword.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    phonenumber.dispose();
    super.dispose();
  }

  @override
  goToLogin() {
    Get.offNamed(AppRoutes.loginScreen);
  }
}
