import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../mirra_style.dart';
import '../../../widgets/common_Text_button.dart';
import '../../../widgets/common_icon_button.dart';
import '../../../widgets/date_picker.dart';
import '../../term_of_use/view.dart';
import '../data/avatar_info.dart';
import '../data/show.dart';
import '../headgear_acquisition/view.dart';
import '../home_page/booking_state.dart';
import '../player_page/player_squad.dart';
import 'logic.dart';

import 'package:audioplayers/audioplayers.dart';

class BirthdayPage extends StatelessWidget {
  BirthdayPage({
    Key? key,
  }) : super(key: key);
  final logic = Get.put(AddPlayerLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
          Container(
            width: 1.0.sw,
            color: Color(0xFF233342),
            child: Column(
              children: [
                SizedBox(
                  height: 0.3.sh,
                ),
                DatePicker(
                    initialDate: logic.birthdayStr,
                    onChange: (selectedDate) {
                      print('Selected Date: $selectedDate');
                      logic.birthdayStr = selectedDate;
                    },
                ),
                SizedBox(
                  height: 0.2.sh,
                ),
                _AddBirthdayButton(
                  width: 600.w,
                ),
                // _BackButton(),
                // CommonTextButton(
                //   btnText: "BACK",
                //   textColor: Color(0xff13EFEF),
                //   onPress: () {
                //     Get.back();
                //   },
                //   changedTextColor: Color(0xffA4EDF1),
                // ),
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            top: -30.0,
            child: Container(
              width: 1.0.sw,
              margin: EdgeInsets.only(top: 20.0, left: 40.0),
              child: Row(
                children: [
                  CommonIconButton(
                    onPress: () {
                      Get.back();
                    },
                  ),
                  SizedBox(width: 0.1.sw - 48 - 40,),
                  Container(
                    // margin: EdgeInsets.only(top: 60.0, left: 40.0),
                    margin: EdgeInsets.only(top: 20.0),
                    // constraints: BoxConstraints.tightFor(width: 1.0.sw - 40), //卡片大小
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0.0),
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
                            style: CustomTextStyles.textSmall(
                              color: Color(0xFFFFFFFF),
                              fontSize: 26.sp,),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0.0),
                          child: Text(
                            'We will not disclose this information. Please rest assured.',
                            style: CustomTextStyles.textSmall(
                              color: Color(0xFFFFFFFF),
                              fontSize: 26.sp,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    ));
  }
}

class _AddBirthdayButton extends StatefulWidget {
  _AddBirthdayButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;

  @override
  _AddBirthdayButtonState createState() => _AddBirthdayButtonState();
}

// 添加生日
class _AddBirthdayButtonState extends State<_AddBirthdayButton> {
  late FToast fToast;

  final logic = Get.find<AddPlayerLogic>();
  ShowInfo get showInfo => Get.arguments["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get tableId => Get.arguments["tableId"];
  String get isFlow => Get.arguments["isFlow"];
  bool isChangeBgColor = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showCustomToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF7B7B7B),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.black, size: 24,),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Players should be over 12 years",
            style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 26.sp, level: 4),
          ),
        ],
      ),
    );

    fToast.showToast(
      // child: toast,
      child: Transform.translate(
        offset: Offset(0, 36.0), // 调整垂直方向上的偏移量
        child: toast,
      ),
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  // 创建音频播放器实例
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTapUp: (details) async {
        await audioPlayer.release;
        setState(() {
          isChangeBgColor = false;
        });
        // 用户查重
        Map checkingUser = await logic.checkingPlayer(logic.emailController.text);
        print("查重返回 ${checkingUser.isEmpty}");
        print("参数 ${Get.arguments}");
        String birthDay = DateFormat('yyyy-MM-dd')
            .format(logic.birthdayStr);
        DateTime today = DateTime.now();  // 当前日期时间
        Duration ageDifference = today.difference(logic.birthdayStr);  // 计算时间间隔
        int ageInYears = (ageDifference.inDays / 365).floor();
        if (ageInYears >= 12) {
          if (checkingUser.isEmpty) {
            print("是新增!!!!!");
            String testPhone = "+(1)" + logic.phoneController.text;
            try {
              // Map addUserInfo = await logic.addPlayerFun(
              //     tableId,
              //     logic.emailController.text,
              //     testPhone,
              //     logic.firstNameController.text,
              //     logic.lastNameController.text,
              //     birthDay);
              // EasyLoading.dismiss(animation: false);
              // // 加入到show
              // await logic.addPlayerToShow(showInfo.showId, tableId, addUserInfo['userId']);
              //
              // await Get.to(() => TermsOfUse(), arguments: {
              //   "isAddPlayerClick": true,
              //   "showInfo": showInfo,
              //   "bookingState": bookingState,
              //   "isFlow": "checkIn",
              //   "tableId": tableId,
              //   'userId': addUserInfo['userId'],
              // });
              Map<String, dynamic> addInfoObj = {
                'email': logic.emailController.text,
                'phone': testPhone,
                'firstName': logic.firstNameController.text,
                'lastName': logic.lastNameController.text,
                'birthday': birthDay,
              };
              await Get.to(() => TermsOfUse(), arguments: {
                "isAddPlayerClick": true,
                "showInfo": showInfo,
                "bookingState": bookingState,
                "isFlow": "checkIn",
                "tableId": tableId,
                "addInfoObj": addInfoObj,
              });

              // print("参数 ${addUserInfo['userId']}");
              // List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(addUserInfo['userId']);
              // if(headgearObj.isEmpty) {
              //   Get.offAll(() => PlayerSquadPage(),
              //       arguments: {
              //         'showInfo': showInfo,
              //         "bookingState": bookingState,
              //         "isAddPlayerClick": isAddPlayerClick,
              //         "tableId": tableId,
              //       });
              // }
              // else {
              //   Get.offAll(() => HeadgearAcquisitionPage(),
              //     arguments: {
              //       'showInfo': showInfo,
              //       "bookingState": bookingState,
              //       'headgearObj': headgearObj,
              //       'userId': addUserInfo['userId'],
              //       "isAddPlayerClick": isAddPlayerClick,
              //       "tableId": tableId,
              //     },
              //   );
              // }
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
              await logic.addPlayerToShow(showInfo.showId, tableId, checkingUser['userId']);

              List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(checkingUser['userId']);
              if(headgearObj.isEmpty) {
                Get.offAll(() => PlayerSquadPage(),
                    arguments: {
                      'showInfo': showInfo,
                      'customer': customer,
                      "isAddPlayerClick": isAddPlayerClick,
                      "tableId": tableId,
                    });
              }
              else {
                Get.offAll(() => HeadgearAcquisitionPage(),
                      arguments: {
                        'showInfo': showInfo,
                        'customer': customer,
                        'headgearObj': headgearObj,
                        'userId': checkingUser['userId'],
                        "isAddPlayerClick": isAddPlayerClick,
                        "tableId": tableId,
                      },
                );
              }
            } on DioException catch (e) {
              EasyLoading.dismiss();
              if (e.response == null) EasyLoading.showError("Network Error!");
              EasyLoading.showError(e.response?.data["error"]["message"]);
            }
          }
        }
        else {
          showCustomToast();
        }
      },
      onTapDown: (details) async {
        setState(() {
          isChangeBgColor = true;
        });
        await audioPlayer.play(AssetSource(MirraIcons.getSoundEffectsCheckPath("normal_click.wav")));
      },
      onTapCancel: () async {
        // 手指离开区域的处理逻辑
        print('onTapCancel');
        await audioPlayer.release;
        setState(() {
          isChangeBgColor = !isChangeBgColor;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isChangeBgColor ? Color(0xffA4EDF1) : Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 50.0, left: 0.0, bottom: 30.0),
        constraints: BoxConstraints.tightFor(width: widget.width, height: 100.h),
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
