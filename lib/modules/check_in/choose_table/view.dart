import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:interactive_board/modules/check_in/complete_page/view.dart';
import 'package:interactive_board/modules/check_in/data/booking.dart';
import 'package:interactive_board/modules/check_in/logic.dart';

import '../../../common.dart';
import '../widget/button.dart';

class ChooseTablePage extends StatelessWidget {
  ChooseTablePage({
    Key? key,
    required this.fullTables,
    required this.verityInfo,
  }) : super(key: key);
  final List<int> fullTables;
  final VerifyInfo verityInfo;
  final CheckInLogic logic = Get.find<CheckInLogic>();
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
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 200.w),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "Choose Table",
                    style: TextStyle(fontSize: 50),
                  ),
                  const SizedBox(height: 70),
                  const Text(
                    "Please Choose Your Gaming Table",
                    style: TextStyle(fontSize: 50),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    height: 600.w,
                    padding: EdgeInsets.only(top: 150.w, left: 100.w, right: 100.w),
                    child: GetBuilder<CheckInLogic>(
                      builder: (CheckInLogic logic) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [1, 2, 3, 4]
                              .map(
                                (e) => _TableItem(
                                  tableId: e,
                                  bSelected: logic.selectedTableId == e,
                                  bAvailable: !fullTables.contains(e),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                  GetBuilder<CheckInLogic>(
                    builder: (logic) => CheckInButton(
                      title: "Next",
                      disable: !logic.bSelected,
                      onPress: () async {
                        EasyLoading.show(status: "waiting...", maskType: EasyLoadingMaskType.black);
                        await logic.customerCheckIn(
                          showId: verityInfo.showId,
                          transactionId: verityInfo.transactionId,
                          bookingId: verityInfo.bookingId,
                          name: verityInfo.customer.name,
                          email: verityInfo.customer.email,
                          phone: verityInfo.customer.telephone,
                        );
                        EasyLoading.dismiss(animation: false);
                        Get.to(() => CompletePage(verifyInfo: verityInfo));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: logic.backToVerificationPage,
                icon: const Icon(
                  Icons.arrow_back,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TableItem extends StatelessWidget {
  const _TableItem({
    Key? key,
    required this.tableId,
    required this.bSelected,
    required this.bAvailable,
  }) : super(key: key);
  final int tableId;
  final bool bAvailable;
  final bool bSelected;

  Color get backgroundColor {
    if (!bAvailable) return Colors.grey;
    return bSelected ? Colors.lightGreen : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<CheckInLogic>();
    return Column(
      children: [
        GestureDetector(
          onTapUp: (details) {
            if (!bAvailable) return;
            logic.selectTable(tableId);
          },
          child: Container(
            width: 300.w,
            height: 240.w,
            color: backgroundColor,
            alignment: Alignment.center,
            child: Text(
              bAvailable ? "Available" : "Full",
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text("Table $tableId"),
      ],
    );
  }
}
