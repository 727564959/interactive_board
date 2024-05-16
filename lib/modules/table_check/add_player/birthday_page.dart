import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

// 添加生日
class _AddBirthdayButton extends StatelessWidget {
  _AddBirthdayButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<AddPlayerDataLogic>();
  ShowState get showState => Get.arguments["showState"];

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
