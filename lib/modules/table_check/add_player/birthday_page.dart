import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common.dart';
import '../../../../widgets/check_in_title.dart';
import '../../../data/model/show_state.dart';
import '../../../mirra_style.dart';
import '../../../widgets/date_picker.dart';
import '../data/avatar_info.dart';
import '../headgear/view.dart';
import '../player_show/view.dart';
import 'logic.dart';

class BirthdayPage extends StatelessWidget {
  BirthdayPage({
    Key? key,
  }) : super(key: key);
  final logic = Get.put(AddPlayerDataLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
          Container(
            color: Color(0xFF233342),
            width: 1.0.sw,
            child: Column(
              children: [
                SizedBox(
                  height: 0.25.sh,
                ),
                DatePicker(
                    initialDate: logic.birthdayStr,
                    onChange: (selectedDate) {
                      print('Selected Date: $selectedDate');
                      logic.birthdayStr = selectedDate;
                    },
                ),
                SizedBox(
                  height: 0.25.sh,
                ),
                _AddBirthdayButton(
                  width: 600.w,
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
                  margin: EdgeInsets.only(top: 60.0, left: 40.0),
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

  final logic = Get.find<AddPlayerDataLogic>();
  ShowState get showState => Get.arguments["showState"];

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
            "Players should be over 13 yearss",
            style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 26.sp, level: 4),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );

    // Fluttertoast.showToast(
    //     msg: "Players should be over 13 yearss",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Color(0xFF7B7B7B),
    //     textColor: Colors.white,
    //     fontSize: 26.0
    // );
  }

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
        String birthDay = DateFormat('yyyy-MM-dd')
            .format(logic.birthdayStr);
        DateTime today = DateTime.now();  // 当前日期时间
        Duration ageDifference = today.difference(logic.birthdayStr);  // 计算时间间隔
        int ageInYears = (ageDifference.inDays / 365).floor();  // 将天数转换为年数
        if (ageInYears >= 13) {
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
                  // logic.birthdayStr);
                  birthDay);
              EasyLoading.dismiss(animation: false);
              // 加入到show
              await logic.addPlayerToShow(showState.showId??1, Global.tableId, addUserInfo['userId']);

              print("参数 ${addUserInfo['userId']}");
              List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(addUserInfo['userId']);
              if(headgearObj.isEmpty) {
                Get.offAll(() => PlayerShowPage(),
                    arguments: {
                      'showState': showState,
                    });
              }
              else {
                Get.offAll(
                      () => HeadgearPage(),
                  arguments: {
                    'showState': showState,
                    'headgearObj': headgearObj,
                    'userId': addUserInfo['userId'],
                  },
                );
              }
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
              await logic.addPlayerToShow(showState.showId??1, Global.tableId, checkingUser['userId']);

              List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(checkingUser['userId']);
              if(headgearObj.isEmpty) {
                Get.offAll(() => PlayerShowPage(),
                    arguments: {
                      'showState': showState,
                    });
              }
              else {
                Get.offAll(
                      () => HeadgearPage(),
                  arguments: {
                    'showState': showState,
                    'headgearObj': headgearObj,
                    'userId': checkingUser['userId'],
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
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
        Get.back();
      },
      child: Text(
        "BACK",
        style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
      ),
    );
  }
}
