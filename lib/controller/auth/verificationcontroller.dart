import 'package:flower_shop/core/class/statusrequest.dart';
import 'package:flower_shop/core/constant/app_routes.dart';
import 'package:flower_shop/core/data/remote/auth/resendVerificationCode.dart';
import 'package:flower_shop/core/data/remote/auth/verificationdata.dart';
import 'package:flower_shop/core/function/handlingdata.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class VerificatonController extends GetxController {
  goToBottom(String veriycode);
  resendVerificationCode();
}

class VerificatonControllerImp extends VerificatonController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  Verificationdata verificationdata = Verificationdata(Get.find());
  Resendverificationcodedata resenddata = Resendverificationcodedata(Get.find());
  String? email;
  var otp = ''.obs;
  StatusRequest? statusRequest;
  final List<TextEditingController> textcontrollers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  void handleOtpChange(String value, int index) {
    if (value.length == 1 && index < 3) {
      otp.value += value;
    } else if (value.isEmpty && index > 0) {}
  }

  String getOtp() {
    // Retrieve the text values from the controllers
    return textcontrollers.map((controller) => controller.text).join("");
  }

  @override
  goToBottom(String veriycode) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verificationdata.postData(email!, veriycode);
    print(response);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        Get.offNamed(AppRoutes.bottomNavbar);
      } else {
        Get.defaultDialog(
            title: "Warning", middleText: "verify code not correct");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  resendVerificationCode() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resenddata.postData(email!);
    print(response);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        Get.defaultDialog(
            title: "Warning", middleText: response['message'].toString());
      } else {
        Get.defaultDialog(
            title: "Warning", middleText: response['message'].toString());
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose controllers and focus nodes when the controller is closed
    for (var controller in textcontrollers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }
}
