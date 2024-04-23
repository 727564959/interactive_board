import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';

import 'package:intl/intl.dart';
import 'package:interactive_board/modules/check_in/data/booking.dart';
import 'package:interactive_board/modules/check_in/widget/button.dart';

import '../../../common.dart';
import '../../../mirra_style.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({
    Key? key,
    required this.tableId,
    required this.customer,
    required this.startTime,
  }) : super(key: key);
  final int tableId;
  final Customer customer;
  final DateTime startTime;
  Color get color {
    if (tableId == 1) {
      return const Color(0xFFEF7E00);
    } else if (tableId == 2) {
      return const Color(0xFFE11988);
    } else if (tableId == 3) {
      return const Color(0xFF50C68E);
    } else {
      return const Color(0xFF4091F0);
    }
  }
  String get bayString {
    if (tableId == 1) {
      return "A";
    } else if (tableId == 2) {
      return "B";
    } else if (tableId == 3) {
      return "C";
    } else {
      return "D";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(Global.getAssetImageUrl("background.png")),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: Color(0xFF233342),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: const Alignment(-0.6, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      "Successfully Checked in",
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Welcome, ${customer.name}!",
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 3),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Your Games will start at ',
                        style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${DateFormat('kk:mm').format(startTime.add(8.hours))}",
                            style: CustomTextStyles.title(color: color, fontSize: 36.sp, level: 4),
                          ),
                          TextSpan(
                            text: ", please be seated by ${DateFormat('kk:mm').format(startTime.add(8.hours - 15.minutes))}, Enjoy!",
                            style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 50),
              // const Text(
              //   "Successfully Checked in",
              //   style: TextStyle(fontSize: 50),
              // ),
              // const SizedBox(height: 70),
              // Text(
              //   "Welcome, ${customer.name}! \nYour game start time is "
              //   "${DateFormat('kk:mm').format(startTime.add(8.hours))}, please be seated by "
              //   "${DateFormat('kk:mm').format(startTime.add(8.hours - 15.minutes))}. Enjoy!",
              //   style: const TextStyle(fontSize: 50),
              // ),
              const SizedBox(height: 100),
              Container(
                width: 0.4.sw,
                height: 0.33.sh,
                decoration: BoxDecoration(
                  color: Color(0xFF13EFEF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Your Louge",
                        style: CustomTextStyles.title(color: Colors.black, fontSize: 40.sp, level: 3),
                      ),
                      Text(
                        " Bay $bayString",
                        style: CustomTextStyles.display(color: Colors.black, fontSize: 106.sp, level: 1),
                      ),
                      Text(
                        "5 Guests",
                        style: CustomTextStyles.title(color: Colors.black, fontSize: 48.sp, level: 2),
                      ),
                    ],
                  ),
                ),
              ),
              // const Text(
              //   "Your Gaming Table:",
              //   style: TextStyle(fontSize: 50),
              // ),
              // const SizedBox(height: 20),
              // Text(
              //   " Table $tableId",
              //   style: const TextStyle(fontSize: 150, fontWeight: FontWeight.bold),
              // ),
              // // const Text(
              // //   " 5 Guests",
              // //   style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
              // // ),
              const SizedBox(height: 80),
              CheckInButton(
                title: "Back",
                onPress: () {
                  Get.searchDelegate(null).toNamedAndOffUntil(
                    AppRoutes.verificationCode,
                    (p0) {
                      return p0.name == AppRoutes.verificationCode;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
