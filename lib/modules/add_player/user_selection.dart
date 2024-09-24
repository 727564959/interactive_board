import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../data/model/show_state.dart';
import '../../mirra_style.dart';
import '../../widgets/check_in_title.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_icon_button.dart';
import '../check_in/data/show.dart';
import '../check_in/home_page/booking_state.dart';
import '../term_of_use/view.dart';
import 'data/search_user.dart';
import 'logic.dart';
import 'old_user.dart';

class UserSelectionPage extends StatelessWidget {
  UserSelectionPage({Key? key}) : super(key: key);
  List<SearchUser> get checkingUser => Get.arguments["checkingUser"];
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  String get isFlow => Get.arguments["isFlow"];
  ShowState get showState => Get.arguments?["showState"];
  int get tableId => Get.arguments["tableId"];
  final logic = Get.put(UserRegistrationLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GetBuilder<UserRegistrationLogic>(
              id: "UserSelectionPage",
              builder: (logic) {
                return Container(
                  width: 1.0.sw,
                  height: 1.0.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
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
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Select Your Name to Log In",
                            style: CustomTextStyles.display(color: Colors.white, fontSize: 48.sp, level: 1),
                          ),
                          SizedBox(height: 30,),
                          Text(
                            "Hey there, let’s get you in!",
                            style: CustomTextStyles.display(color: Colors.white, fontSize: 48.sp, level: 2),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.05.sh,),
                      _UserGridView(),
                      SizedBox(height: 30,),
                      CommonButton(
                        width: 600.w,
                        height: 100.h,
                        btnText: 'NEXT',
                        btnBgColor: Color(0xff13EFEF),
                        textColor: Colors.black,
                        onPress: () async {
                          print("参数 ${logic.selectedId}");
                          EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                          try {
                            Map singlePlayer = await logic.fetchSingleUsers(logic.selectedId);
                            print("singlePlayer ${singlePlayer}");
                            EasyLoading.dismiss(animation: false);
                            // old user展示页面
                            if(isFlow == "checkIn") {
                              await Get.to(() => OldUserPage(), arguments: {
                                "showInfo": showInfo,
                                "bookingState": bookingState,
                                "isAddPlayerClick": true,
                                "tableId": tableId,
                                "singlePlayer": singlePlayer,
                                "isFlow": isFlow,
                              });
                            }
                            else if(isFlow == "tableCheck") {
                              await Get.to(() => OldUserPage(), arguments: {
                                // "bookingState": bookingState,
                                "isAddPlayerClick": true,
                                "tableId": tableId,
                                "singlePlayer": singlePlayer,
                                "showState": showState,
                                "isFlow": isFlow,
                              });
                            }
                          } on DioException catch (e) {
                            EasyLoading.dismiss();
                            if (e.response == null) EasyLoading.showError("Network Error!");
                            EasyLoading.showError(e.response?.data["error"]["message"]);
                          }
                        },
                        disable: logic.selectedId == null,
                        changedBgColor: Color(0xffA4EDF1),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class _UserGridView extends StatefulWidget {
  @override
  _UserGridViewState createState() => _UserGridViewState();
}

class _UserGridViewState extends State<_UserGridView> {
  final logic = Get.put(UserRegistrationLogic());
  List<SearchUser> get checkingUser => Get.arguments["checkingUser"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.sh,
      width: 0.6.sw,
      child: checkingUser.length < 4
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center, // 水平居中
              mainAxisSize: MainAxisSize.min, // 仅占用内容所需的最小空间
              children: checkingUser.map((user) {
                return GestureDetector(
                  onTap: () {
                    // 处理点击事件
                    print("Tapped on ${user.firstName} ${user.lastName} ${user.id}");
                    setState(() {
                      logic.selectedId = user.id;
                      logic.refreshUserSelectionPage();
                    });
                  },
                  child: Container(
                    width: (0.6.sw - 30) / 4,
                    height: (0.6.sw - 30) / 4,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xffA4EDF1),
                    ),
                    margin: EdgeInsets.all(5), // 卡片之间的间距
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            user.firstName + " " + user.lastName.substring(0, 1),
                            style: TextStyle(
                              fontFamily: 'RobotoFlex',
                              fontSize: 34.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if(user.id == logic.selectedId) Positioned(
                          top: 5,
                          right: 5,
                          child: Image.asset(
                            MirraIcons.getSetAvatarIconPath('choose_icon.png'),
                            fit: BoxFit.fitWidth,
                            width: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          : GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0, // 设置列之间的间距
              mainAxisSpacing: 10.0, // 行之间的间距
              childAspectRatio: 1.0, // 设置卡片宽高比
              children: checkingUser.map((user) {
                return GestureDetector(
                  onTap: () async {
                    // 处理点击事件
                    print("Tapped on ${user.firstName} ${user.lastName} ${user.id}");
                    setState(() {
                      logic.selectedId = user.id;
                      logic.refreshUserSelectionPage();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xffA4EDF1),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            user.firstName + " " + user.lastName.substring(0, 1),
                            style: TextStyle(
                              fontFamily: 'RobotoFlex',
                              fontSize: 34.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if(user.id == logic.selectedId) Positioned(
                          top: 5,
                          right: 5,
                          child: Image.asset(
                            MirraIcons.getSetAvatarIconPath('choose_icon.png'),
                            fit: BoxFit.fitWidth,
                            width: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}