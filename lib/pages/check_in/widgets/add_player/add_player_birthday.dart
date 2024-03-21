import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../modules/set_avatar/logic.dart';
import '../../../../widgets/check_in_title.dart';
import '../../data/checkIn_api.dart';
import '../after_checkIn/player_info_show.dart';

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
              CheckInTitlePage(titleText: "Add Player"),
              SizedBox(
                child: GetBuilder<CheckInLogic>(
                  builder: (logic) {
                    return Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 60.0, left: 120.0),
                          constraints: BoxConstraints.tightFor(width: 0.8.sw, height: 0.2.sh), //卡片大小
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10.0, right: 0.5.sw),
                                child: Text(
                                  'When’s your birthday?',
                                  style: TextStyle(
                                    fontSize: 60.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.white,
                                    letterSpacing: 3.sp,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30.0),
                                child: Text(
                                  'Collecting your birthday information to friendly gaming experience.  we will not disclose this information. Please rest assured.',
                                  style: TextStyle(
                                    fontSize: 35.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.white,
                                    letterSpacing: 3.sp,
                                  ),
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
                          constraints: BoxConstraints.tightFor(width: 0.3.sw, height: 0.2.sh),
                          child: ElevatedButton(
                            onPressed: () async {
                              var select_day_time = await showDatePicker(
                                context: context,
                                initialDate: logic.birthdayStr == "Please select a date"
                                    ? DateTime.now()
                                    : DateTime.parse(logic.birthdayStr), //起始时间
                                // initialDate: DateTime.now(), //起始时间
                                firstDate: DateTime(1900, 1, 1), //最小可以选日期
                                lastDate: DateTime(2050, 12, 31), //最大可选日期
                                errorFormatText: '错误的日期格式',
                                errorInvalidText: '日期格式非法',
                                fieldHintText: '月/日/年',
                                fieldLabelText: '填写日期',
                              );
                              print('select_day_time$select_day_time');
                              // 当前年份
                              int currentYear = DateTime.now().year;
                              // 选择的年份
                              var selectYear = select_day_time?.year;
                              print('selectYear$selectYear');
                              // 是否选择了日期
                              if (select_day_time != null) {
                                // 如果小于13岁给出提示，反之直接选择
                                if (currentYear - int.parse(selectYear.toString()) <= 13) {
                                  EasyLoading.showError("Players should be over 13 yearss");
                                } else {
                                  // 调用生日选择
                                  logic.confirmBirthdayFun(select_day_time);
                                }
                              } else {
                                EasyLoading.showError("Please select a date!");
                              }
                            },
                            child: Text(
                              logic.birthdayStr,
                              style: TextStyle(
                                fontSize: 60.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'BurbankBold',
                                color: Colors.white,
                                letterSpacing: 3.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              _AddBirthdayButton(width: 800.w),
              _BackButton(),
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

Future<DateTime?> _showDatePickerForInputOnly(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(), // 初始化选中日期
    firstDate: DateTime(1900, 1, 1), // 开始日期
    lastDate: DateTime(2050, 12, 31), // 结束日期
    currentDate: DateTime.now(), // 当前日期
    initialEntryMode: DatePickerEntryMode.inputOnly, // 日历弹框模式
    // selectableDayPredicate: (daytime) {
    //   // 自定义哪些日期可选
    //   if (daytime == DateTime(2000)) {
    //     return false;
    //   }
    //   return true;
    // },
    initialDatePickerMode: DatePickerMode.year, // 日期选择模式 默认为天
    helpText: "请选择年份", // 左上角提示
    cancelText: "Cancel", // 取消按钮 文案
    confirmText: "OK", // 确认按钮 文案
    useRootNavigator: true, // 是否使用根导航器
    errorFormatText: "输入格式有误", // 输入日期 格式错误提示
    errorInvalidText: "输入年份不合法", // 输入日期 不在first 与 last 之间提示
    fieldHintText: "请输入年份", // 输入框为空时提示
    fieldLabelText: "输入正确的年份", // 输入框上方 提示
    textDirection: TextDirection.ltr, // 水平方向 显示方向 默认 ltr
  );
}

// 添加生日
class _AddBirthdayButton extends StatelessWidget {
  _AddBirthdayButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  // String get backgroundUri => Global.getSetAvatarImageUrl("group_setting_input.png");

  final testTabId = Global.tableId;

  get checkInApi => CheckInApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("从生日选择跳转到形象设计");
        print("54321 ${logic.email}");
        // 用户查重
        Map<String, dynamic> checkingUser = await checkInApi.checkingPlayer(logic.email);
        // logic.birthdayStr;
        print("查重返回 ${checkingUser.isEmpty}");
        print("参数 ${Get.arguments}");
        // print("参数 ${logic.showState}");
        if(checkingUser.isEmpty) {
          print("是新增!!!!!");
          String testPhone = "+(1)" + logic.phone;
          try {
            Map<String, dynamic> addUserInfo = await checkInApi.addPlayerFun(testTabId, logic.email, testPhone, logic.firstName, logic.lastName, logic.birthdayStr);
            EasyLoading.dismiss(animation: false);
            // 加入到show
            await checkInApi.addPlayerToShow(Get.arguments.showId, Global.tableId, addUserInfo['userId']);
            Map<String, dynamic> jsonObj = {
              "userId": addUserInfo['userId'],
              "showId": Get.arguments.showId,
              "status": Get.arguments.status.toString()
            };
            Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
            Get.find<SetAvatarLogic>().updatePlayer(addUserInfo['userId'].toString());
            await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }
        }
        else {
          print("是更新!!!!!");
          // 加入到show
          // await checkInApi.addPlayerToShow(Get.arguments.showId, Global.tableId, checkingUser['userId']);
          Map<String, dynamic> jsonObj = {
            "userId": checkingUser['userId'],
            "showId": Get.arguments.showId,
            "status": Get.arguments.status.toString()
          };
          Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
          Get.find<SetAvatarLogic>().updatePlayer(checkingUser['userId'].toString());
          await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
        }
      },
      child: GetBuilder<CheckInLogic>(
        id: "birthdayBtn",
        builder: (logic) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff13EFEF),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            margin: EdgeInsets.only(top: 100.0, left: 0.0, bottom: 30.0),
            constraints: BoxConstraints.tightFor(width: width * 0.8, height: 80.h),
            child: Center(
              child: Text(
                "NEXT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.sp,
                  decoration: TextDecoration.none,
                  fontFamily: 'BurbankBold',
                  color: Color(0xff000000),
                  letterSpacing: 3.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 返回到addPlayer页面
class _BackButton extends StatelessWidget {
  _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        Get.to(() => PlayerInfoShow(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "backBtn",
        builder: (logic) {
          return Text(
            "Back",
            style: TextStyle(
              fontSize: 35.sp,
              decoration: TextDecoration.none,
              fontFamily: 'BurbankBold',
              color: Color(0xff13EFEF),
              letterSpacing: 3.sp,
            ),
          );
        },
      ),
    );
  }
}
