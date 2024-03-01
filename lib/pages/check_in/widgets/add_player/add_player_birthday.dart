import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../common.dart';
import '../../data/checkIn_api.dart';
import '../avatar_design_new.dart';

class AddPlayerBirthday extends StatelessWidget {
  AddPlayerBirthday({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  String birthdayStr = 'Please select a date';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              color: Colors.black,
              child: Column(
                children: [
                  // 顶部文本信息
                  _SetAvatarTitle(),
                  SizedBox(
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //   color: Colors.grey,
                              //   borderRadius: BorderRadius.all(Radius.circular(10)),
                              // ),
                              margin: EdgeInsets.only(top: 60.0, left: 120.0),
                              constraints: BoxConstraints.tightFor(width: 0.8.sw, height: 0.2.sh),//卡片大小
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, right: 0.5.sw),
                                    child: Text('When’s your birthday?',
                                      style: TextStyle(fontSize: 60.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30.0),
                                    child: Text('Collecting your birthday information to friendly gaming experience.  we will not disclose this information. Please rest assured.',
                                      style: TextStyle(fontSize: 35.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(top: 60.0, left: 0.35.sw),
                              constraints: BoxConstraints.tightFor(width: 0.3.sw, height: 0.2.sh),//卡片大小
                              child: ElevatedButton(
                                  onPressed: () async {
                                    var select_day_time = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(), //起始时间
                                      firstDate: DateTime(1900, 1, 1), //最小可以选日期
                                      lastDate: DateTime(2030, 5, 1), //最大可选日期
                                    );
                                    print('select_day_time$select_day_time');
                                    logic.birthdayStr =
                                      "${select_day_time?.year}-${select_day_time?.month}-${select_day_time?.day}";
                                    // birthdayStr = "${select_day_time?.year}-${select_day_time?.month}-${select_day_time?.day}";
                                  },
                                  child: Text(logic.birthdayStr)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _AddBirthdayButton(width: 800.w),
                ],
              ),
            ),
            GetBuilder<CheckInLogic>(builder: (logic) {
              return Container();
            }),
          ],
        ));
  }
}
class _SetAvatarTitle extends StatelessWidget {
  const _SetAvatarTitle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("12345 ${DateTime.now().toString().substring(0, 19)}");
    final String dateTime = DateTime.now().toString().substring(11, 16);
    final content = SizedBox(
      width: 0.94.sw,
      height: 100.h,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: const Alignment(0.5, 1.5),
                child: SizedBox(
                  width: 0.2.sw,
                  child: Text(
                    "Add Player",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp,
                      decoration: TextDecoration.none,
                      fontFamily: 'BurbankBold',
                      color: Colors.white,
                      letterSpacing: 3.sp,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.5, 1.5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.1.sw,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 0.05.sw,
                            child: Text(
                              dateTime,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'BurbankBold',
                                color: Colors.white,
                                letterSpacing: 3.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.05.sw,
                            child: Text(
                              " Table 1",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'BurbankBold',
                                color: Colors.deepOrange,
                                letterSpacing: 3.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return content;
  }
}
// 同意条款的按钮
class _AddBirthdayButton extends StatelessWidget {
  _AddBirthdayButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("group_setting_input.png");

  final testTabId = Global.tableId;

  // get checkInApi => CheckInApi();
  // final testTabId = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("接受了协议");
        print("54321 ${logic.userList}");
        int index = logic.userList.length - 1;
        print("54321 $index");
        print("54321 ${logic.userList[index].bodyName}");
        logic.selectedId = logic.userList[index].id;
        print("54321 ${logic.selectedId}");
        logic.currentUrl = logic.userList[index].avatarUrl;
        // logic.userList = await checkInApi.fetchUsers();
        // logic.currentIsMale = logic.userList[index].bodyName == 'Male' ? true : false;
        // logic.headId = logic.userList[index].headgearId;
        // logic.currentUrl = logic.userList[index].avatarUrl;
        Get.to(() => AvatarDesignPage(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "agreeBtn",
        builder: (logic) {
          return Container(
            height: width * 0.5,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}