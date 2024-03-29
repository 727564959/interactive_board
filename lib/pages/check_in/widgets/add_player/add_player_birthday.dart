import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';
import 'package:intl/intl.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../modules/set_avatar/logic.dart';
import '../../../../widgets/check_in_title.dart';
import '../../data/checkIn_api.dart';
import '../after_checkIn/player_info_show.dart';
import '../treasure_chest/explosive_chest.dart';

class AddPlayerBirthday extends StatelessWidget {
  AddPlayerBirthday({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

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
                  // logic.birthdayStr = 'Please enter your birthday';
                  return Row(
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.grey,
                        //   borderRadius: BorderRadius.all(Radius.circular(10)),
                        // ),
                        margin: EdgeInsets.only(top: 20.0, left: 0.35.sw),
                        constraints: BoxConstraints.tightFor(width: 0.3.sw, height: 0.2.sh),
                        // constraints: BoxConstraints.tightFor(width: 0.3.sw),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff000000)),//背景颜色
                            side: MaterialStateProperty.all(BorderSide(width: 1,color: Color(0xffffffff))),//边框
                          ),
                          onPressed: () async {
                            var select_day_time = await showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.inputOnly,
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData(
                                    // primarySwatch: Colors.amber,
                                    primarySwatch: createMaterialColor(Color(0xff13EFEF)),
                                  ),
                                  child: child!,
                                );
                              },
                              initialDate: logic.birthdayStr == "Please enter your birthday"
                                  ? DateTime.now()
                                  : DateTime.parse(logic.birthdayStr), //起始时间
                              // initialDate: DateTime.now(), //起始时间
                              firstDate: DateTime(1900, 1, 1), //最小可以选日期
                              // lastDate: DateTime(2050, 12, 31), //最大可选日期
                              lastDate: DateTime.now(),
                              errorFormatText: 'Wrong date format',
                              errorInvalidText: 'Invalid date format',
                              fieldHintText: 'MM/dd/yyyy',
                              fieldLabelText: 'Please enter your birthday',
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
                              fontSize: 45.sp,
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
      )
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
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
            // 延迟调用爆宝箱
            Future.delayed(2.seconds).then((value) {
              logic.explosiveChestFun(addUserInfo['userId']);
            }).onError((error, stackTrace) async {
              print("error爆宝箱 $error");
            });
            Get.to(() => TreasureChestPage(), arguments: jsonObj);
            // print("Get.isRegistered<SetAvatarLogic>() ${Get.isRegistered<SetAvatarLogic>()}");
            // if(Get.isRegistered<SetAvatarLogic>()) {
            //   Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
            //   Get.find<SetAvatarLogic>().updatePlayer(addUserInfo['userId'].toString());
            // }
            // await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }
        }
        else {
          print("是更新!!!!!");
          // 加入到show
          await checkInApi.addPlayerToShow(Get.arguments.showId, Global.tableId, checkingUser['userId']);
          Map<String, dynamic> jsonObj = {
            "userId": checkingUser['userId'],
            "showId": Get.arguments.showId,
            "status": Get.arguments.status.toString()
          };
          // 延迟调用爆宝箱
          Future.delayed(2.seconds).then((value) {
            logic.explosiveChestFun(checkingUser['userId']);
          }).onError((error, stackTrace) async {
            print("error爆宝箱 $error");
          });
          Get.to(() => TreasureChestPage(), arguments: jsonObj);
          // print("Get.isRegistered<SetAvatarLogic>() ${Get.isRegistered<SetAvatarLogic>()}");
          // if(Get.isRegistered<SetAvatarLogic>()) {
          //   Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
          //   Get.find<SetAvatarLogic>().updatePlayer(checkingUser['userId'].toString());
          // }
          // await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
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
