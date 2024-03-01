import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/check_in/logic.dart';
import '../../../common.dart';
import '../widget/button.dart';
import 'confirmation_diglog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({Key? key}) : super(key: key);
  final transactionIdController = TextEditingController();
  final emailController = TextEditingController();
  final logic = Get.find<CheckInLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Global.getAssetImageUrl("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Enter Your Booking Information",
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 70),
              _CheckInInput(title: "Transaction ID", controller: transactionIdController),
              _CheckInInput(title: "Email", controller: emailController),
              const SizedBox(height: 100),
              CheckInButton(
                title: "Next",
                onPress: () async {
                  final transactionId = int.parse(transactionIdController.text);
                  final email = emailController.text;
                  EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                  try {
                    final verifyInfo = await logic.verifyValidity(transactionId, email);
                    EasyLoading.dismiss(animation: false);
                    Get.dialog(Dialog(child: ConfirmationDialog(verifyInfo: verifyInfo)));
                  } on DioException catch (e) {
                    EasyLoading.dismiss();
                    if (e.response == null) EasyLoading.showError("Network Error!");
                    EasyLoading.showError(e.response?.data["error"]["message"]);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckInInput extends StatelessWidget {
  const _CheckInInput({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          child: Text(title),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: 0.4.sw,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
