import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../choose_table/view.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../terms_page/view.dart';
import '../widget/button.dart';
import 'logic.dart';

class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog({Key? key, required this.bookingInfo, required this.code}) : super(key: key);
  final BookingInfo bookingInfo;
  final String code;
  final logic = Get.find<VerificationCodeLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.7.sw,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoItem(title: "Name", value: bookingInfo.customer.name),
          _InfoItem(title: "Email", value: bookingInfo.customer.email),
          _InfoItem(title: "Phone Number", value: bookingInfo.customer.phone),
          _InfoItem(
            title: "Game Show",
            value: DateFormat("dd/MM/yyyy - kka").format(
              bookingInfo.bookingTime.add(8.hours),
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: CheckInButton(
              title: "No Problem",
              onPress: () async {
                EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                try {
                  final showInfo = await logic.ticketValidation(code, bookingInfo.bookingTime);
                  EasyLoading.dismiss(animation: false);

                  // await Get.to(
                  //   () => ChooseTablePage(
                  //     showInfo: showInfo,
                  //     customer: bookingInfo.customer,
                  //   ),
                  // );
                  await Get.to(() => TermsOfUsePage(), arguments: {"isAddPlayerClick": false, "showInfo": showInfo, "customer": bookingInfo.customer});
                  WidgetsBinding.instance.addPostFrameCallback((d) => Get.back());
                  logic.codeController.clear();
                } on DioException catch (e) {
                  String jsonString = '''
                    {
                      "startTime": "2024-04-16T06:00:00.248Z",
                      "showId": 13,
                      "associatedUsers": [
                        {
                          "tableId": 2
                        },
                        {
                          "tableId": 3
                        }
                      ]
                    }
                  ''';
                  Map<String, dynamic> jsonData = json.decode(jsonString);
                  ShowInfo showInfoTest = ShowInfo.fromJson(jsonData);
                  print("哈哈哈哈哈: ${bookingInfo.customer}");
                  print("哈哈哈哈哈: ${showInfoTest}");
                  EasyLoading.dismiss();
                  await Get.to(() => TermsOfUsePage(), arguments: {"isAddPlayerClick": false, "showInfo": showInfoTest, "customer": bookingInfo.customer});
                  if (e.response == null) EasyLoading.showError("Network Error!");
                  EasyLoading.showError(e.response?.data["error"]["message"]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 350,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                decoration: TextDecoration.none,
                fontFamily: 'Burbank',
                color: Colors.black,
                textBaseline: TextBaseline.ideographic,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 50,
              decoration: TextDecoration.none,
              // fontFamily: 'Burbank',
              color: Colors.black,
              textBaseline: TextBaseline.ideographic,
            ),
          ),
        ],
      ),
    );
  }
}
