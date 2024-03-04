import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/check_in/choose_table/view.dart';
import 'package:interactive_board/modules/check_in/data/booking.dart';
import 'package:interactive_board/modules/check_in/logic.dart';
import 'package:interactive_board/modules/check_in/widget/button.dart';

class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog({Key? key, required this.verifyInfo}) : super(key: key);
  final VerifyInfo verifyInfo;
  final logic = Get.find<CheckInLogic>();
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
          _InfoItem(title: "Name", value: verifyInfo.customer.name),
          _InfoItem(title: "Email", value: verifyInfo.customer.email),
          _InfoItem(title: "Phone Number", value: verifyInfo.customer.telephone),
          _InfoItem(
            title: "Game Show",
            value: DateFormat("dd/MM/yyyy - kka").format(
              verifyInfo.startingTime.add(8.hours),
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: CheckInButton(
              title: "No Problem",
              onPress: () async {
                final fullTables = await logic.fetchFullTables(verifyInfo.showId);
                Get.to(() => ChooseTablePage(
                      fullTables: fullTables,
                      verityInfo: verifyInfo,
                    ));
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
