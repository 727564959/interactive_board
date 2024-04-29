import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common.dart';
import '../../../../widgets/check_in_title.dart';
import '../../../mirra_style.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../headgear_acquisition/view.dart';
import '../player_page/logic.dart';
import '../player_page/view.dart';
import 'logic.dart';

class BirthdayPage extends StatelessWidget {
  BirthdayPage({
    Key? key,
    required this.showInfo,
    required this.customer,
  }) : super(key: key);
  final ShowInfo showInfo;
  final Customer customer;
  final logic = Get.put(AddPlayerLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
          Container(
            color: Color(0xFF233342),
            child: Column(
              children: [
                // 顶部文本信息
                CheckInTitlePage(titleText: ""),
                SizedBox(
                  height: 0.15.sh,
                ),
                SizedBox(
                  child: GetBuilder<AddPlayerLogic>(
                    builder: (logic) {
                      return Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 0.35.sw),
                            constraints: BoxConstraints.tightFor(
                                width: 0.3.sw, height: 0.2.sh),
                            child: ElevatedButton(
                              // style: ButtonStyle(
                              //   backgroundColor: MaterialStateProperty.all(
                              //       Color(0xff4D797F)), //背景颜色
                              //   side: MaterialStateProperty.all(BorderSide(
                              //       width: 1, color: Color(0xffffffff))), //边框
                              // ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff4D797F),//背景颜色
                                side: BorderSide(width: 1,color: Color(0xffffffff)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // 设置圆角矩形
                                ),
                              ),
                              onPressed: () async {
                                var select_day_time = await showDatePicker(
                                  context: context,
                                  initialEntryMode: DatePickerEntryMode.inputOnly,
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                        // primarySwatch: Colors.amber,
                                        primarySwatch: createMaterialColor(
                                            Color(0xff13EFEF)),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  initialDate: logic.birthdayStr ==
                                          "Please enter your birthday"
                                      ? DateTime.now()
                                      : DateTime.parse(logic.birthdayStr), //起始时间
                                  firstDate: DateTime(1900, 1, 1), //最小可以选日期
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
                                  if (currentYear -
                                          int.parse(selectYear.toString()) <=
                                      13) {
                                    EasyLoading.showError(
                                        "Players should be over 13 yearss");
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
                SizedBox(
                  height: 50.0,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 0.0),
                //   color: Color(0xFF7B7B7B),
                //   padding: EdgeInsets.all(20.0),
                //   width: 0.34.sw,
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         Global.getSetAvatarImageUrl('warning_icon.png'),
                //         fit: BoxFit.fill,
                //       ),
                //       SizedBox(width: 10.0,),
                //       Text(
                //         'Players should be over 13 years',
                //         style: CustomTextStyles.title(color: Color(0xFFFFFFFF), fontSize: 26.sp, level: 4),
                //       )
                //     ],
                //   ),
                // ),
                _AddBirthdayButton(
                  width: 800.w,
                  showInfo: showInfo,
                  customer: customer,
                ),
                _BackButton(),
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            top: -30.0,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60.0, left: 30.0),
                  constraints: BoxConstraints.tightFor(width: 0.75.sw), //卡片大小
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'When’s your birthday?',
                          style: CustomTextStyles.title(
                              color: Colors.white, fontSize: 48.sp, level: 2),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.0),
                        child: Text(
                          'Collecting your birthday information to friendly gaming experience.',
                          style: CustomTextStyles.title(
                              color: Color(0xFFD0D0D0),
                              fontSize: 26.sp,
                              level: 4),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.0),
                        child: Text(
                          'we will not disclose this information. Please rest assured.',
                          style: CustomTextStyles.title(
                              color: Color(0xFFD0D0D0),
                              fontSize: 26.sp,
                              level: 4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
    ));
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
    required this.showInfo,
    required this.customer,
  }) : super(key: key);
  final double width;
  final ShowInfo showInfo;
  final Customer customer;
  final logic = Get.find<AddPlayerLogic>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        // 用户查重
        Map checkingUser = await logic.checkingPlayer(logic.email);
        print("查重返回 ${checkingUser.isEmpty}");
        print("参数 ${Get.arguments}");
        // print("参数 ${logic.showState}");
        if (checkingUser.isEmpty) {
          print("是新增!!!!!");
          String testPhone = "+(1)" + logic.phone;
          try {
            Map addUserInfo = await logic.addPlayerFun(
                Global.tableId,
                logic.email,
                testPhone,
                logic.firstName,
                logic.lastName,
                logic.birthdayStr);
            EasyLoading.dismiss(animation: false);
            // 加入到show
            await logic.addPlayerToShow(
                showInfo.showId, Global.tableId, addUserInfo['userId']);
            print("参数 ${addUserInfo['userId']}");
            Map headgearObj = await logic.fetchHeadgearInfo(addUserInfo['userId']);
            if(headgearObj.isEmpty) {
              Get.offAll(() => PlayerInfoDeskShow(showInfo: showInfo, customer: customer,), arguments: showInfo);
            }
            else {
              // await Get.offAll(() => HeadgearAcquisitionPage(showInfo: showInfo, customer: customer, headgearObj: headgearObj, userId: addUserInfo['userId']));
              Get.offAll(
                    () => HeadgearAcquisitionPage(),
                arguments: {
                  'showInfo': showInfo,
                  'customer': customer,
                  'headgearObj': headgearObj,
                  'userId': addUserInfo['userId'],
                },
              );
            }
            // Get.offAll(() => PlayerInfoDeskShow(showInfo: showInfo, customer: customer,), arguments: showInfo);

            // Map<String, dynamic> jsonObj = {
            //   "userId": addUserInfo['userId'],
            //   "showId": Get.arguments.showId,
            //   "status": Get.arguments.status.toString()
            // };
            // print("Get.isRegistered<SetAvatarLogic>() ${Get.isRegistered<SetAvatarLogic>()}");
            // if(Get.isRegistered<SetAvatarLogic>()) {
            //   Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
            //   Get.find<SetAvatarLogic>().updatePlayer(addUserInfo['userId'].toString());
            // }
            // await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);

            // if(Get.isRegistered<PlayerShowLogic>()) {
            //   Get.find<PlayerShowLogic>().fetchCasualUser(showInfo.showId);
            // }

            // await Get.offAll(
            //   () => PlayerInfoShow(
            //     showInfo: showInfo,
            //     customer: customer,),
            // );
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }
        } else {
          print("是更新!!!!!");
          print("参数 ${checkingUser['userId']}");
          try {
            EasyLoading.dismiss(animation: false);
            // 加入到show
            // await logic.addPlayerToShow(13, Global.tableId, checkingUser['userId']);

            Map headgearObj = await logic.fetchHeadgearInfo(checkingUser['userId']);
            if(headgearObj.isEmpty) {
              Get.offAll(() => PlayerInfoDeskShow(showInfo: showInfo, customer: customer,), arguments: showInfo);
            }
            else {
              // await Get.offAll(() => HeadgearAcquisitionPage(showInfo: showInfo, customer: customer, headgearObj: headgearObj, userId: checkingUser['userId']));
              Get.offAll(
                    () => HeadgearAcquisitionPage(),
                arguments: {
                  'showInfo': showInfo,
                  'customer': customer,
                  'headgearObj': headgearObj,
                  'userId': checkingUser['userId'],
                },
              );
            }
            // Get.offAll(() => PlayerInfoDeskShow(showInfo: showInfo, customer: customer,), arguments: showInfo);

            // if(Get.isRegistered<PlayerShowLogic>()) {
            //   Get.find<PlayerShowLogic>().fetchCasualUser(showInfo.showId);
            // }
            // await Get.offAll(
            //   () => PlayerInfoShow(
            //     showInfo: showInfo,
            //     customer: customer,
            //   ),
            // );
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }

          // Map<String, dynamic> jsonObj = {
          //   "userId": checkingUser['userId'],
          //   "showId": Get.arguments.showId,
          //   "status": Get.arguments.status.toString()
          // };
          // print("Get.isRegistered<SetAvatarLogic>() ${Get.isRegistered<SetAvatarLogic>()}");
          // if(Get.isRegistered<SetAvatarLogic>()) {
          //   Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
          //   Get.find<SetAvatarLogic>().updatePlayer(checkingUser['userId'].toString());
          // }
          // await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.only(top: 50.0, left: 0.0, bottom: 30.0),
        constraints: BoxConstraints.tightFor(width: width * 0.8, height: 80.h),
        child: Center(
          child: Text(
            "NEXT",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
          ),
        ),
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
        // Get.to(() => PlayerInfoShow(), arguments: Get.arguments);
        Get.back();
      },
      child: Text(
        "Back",
        style:
            CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
      ),
    );
  }
}
