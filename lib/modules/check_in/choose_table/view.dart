import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../complete_page/view.dart';
import '../data/show.dart';
import '../data/booking.dart';
import 'logic.dart';
import '../../../common.dart';
import '../widget/button.dart';

class ChooseTablePage extends StatelessWidget {
  ChooseTablePage({
    Key? key,
    required this.showInfo,
    required this.customer,
  }) : super(key: key);
  final ShowInfo showInfo;
  final Customer customer;
  final logic = Get.put(ChooseTableLogic());
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
        child: Container(
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
                child: GetBuilder<ChooseTableLogic>(
                  builder: (ChooseTableLogic logic) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [1, 2, 3, 4]
                          .map(
                            (e) => _TableItem(
                              tableId: e,
                              bSelected: logic.selectedTableId == e,
                              bAvailable: !showInfo.fullTables.contains(e),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
              GetBuilder<ChooseTableLogic>(
                builder: (logic) => CheckInButton(
                  title: "Next",
                  disable: !logic.bSelected,
                  onPress: () async {
                    EasyLoading.show(status: "waiting...", maskType: EasyLoadingMaskType.black);
                    try {
                      final userId = await logic.loginInOrRegister(
                        name: customer.name,
                        email: customer.email,
                        phone: customer.phone,
                      );
                      await logic.customerCheckIn(showId: showInfo.showId, userId: userId);
                      EasyLoading.dismiss(animation: false);
                      await Get.to(
                        () => CompletePage(
                          tableId: logic.selectedTableId!,
                          startTime: showInfo.startTime,
                          customer: customer,
                        ),
                        preventDuplicates: false,
                      );
                    } on DioException catch (e) {
                      EasyLoading.dismiss();
                      if (e.response == null) EasyLoading.showError("Network Error!");
                      EasyLoading.showError(e.response?.data["error"]["message"]);
                    }
                  },
                ),
              ),
            ],
          ),
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
    return Column(
      children: [
        GestureDetector(
          onTapUp: (details) {
            final logic = Get.find<ChooseTableLogic>();
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
