import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:interactive_board/modules/check_in/data/booking.dart';
import 'package:interactive_board/modules/check_in/logic.dart';
import 'package:interactive_board/modules/check_in/widget/button.dart';

import '../../../common.dart';

class CompletePage extends StatelessWidget {
  CompletePage({Key? key, required this.verifyInfo}) : super(key: key);
  final VerifyInfo verifyInfo;
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
            children: [
              const SizedBox(height: 50),
              const Text(
                "Successfully Checked in",
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 70),
              Text(
                "Welcome, ${verifyInfo.customer.name}! \nYour game start time is "
                "${DateFormat('kk:mm').format(verifyInfo.startingTime.add(8.hours))}, please be seated by "
                "${DateFormat('kk:mm').format(verifyInfo.startingTime.add(8.hours - 15.minutes))}. Enjoy!",
                style: const TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 100),
              const Text(
                "Your Gaming Table:",
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 20),
              Text(
                " Table ${logic.selectedTableId!}",
                style: const TextStyle(fontSize: 150, fontWeight: FontWeight.bold),
              ),
              // const Text(
              //   " 5 Guests",
              //   style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 80),
              CheckInButton(title: "Back", onPress: logic.backToVerificationPage),
            ],
          ),
        ),
      ),
    );
  }
}
