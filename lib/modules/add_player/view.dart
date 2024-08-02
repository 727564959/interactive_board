import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/model/show_state.dart';
import '../../mirra_style.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_icon_button.dart';
import '../check_in/add_player/view.dart';
import '../check_in/data/show.dart';
import '../check_in/home_page/booking_state.dart';
import '../table_check/add_player/view.dart';
import 'logic.dart';
import 'old_user.dart';

class UserAuthenticator extends StatelessWidget {
  UserAuthenticator({Key? key}) : super(key: key);
  final logic = Get.put(UserRegistrationLogic());
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  int get tableId => Get.arguments["tableId"];
  String get isFlow => Get.arguments["isFlow"];
  ShowState get showState => Get.arguments?["showState"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              GetBuilder<UserRegistrationLogic>(
                id: "UserAuthenticatorPage",
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 40.0),
                            constraints: BoxConstraints.tightFor(width: (1.0.sw - 40)), //卡片大小
                            child: Row(
                              children: [
                                CommonIconButton(
                                  onPress: () {
                                    logic.focusNode.unfocus();
                                    Future.delayed(0.3.seconds).then((value) async {
                                      Get.back();
                                    });
                                  },
                                ),
                                SizedBox(width: 0.1.sw - 48 - 40,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Hey there, let’s get you in!',
                                        style: CustomTextStyles.title(
                                            color: Colors.white, fontSize: 48.sp, level: 2),
                                      ),
                                    ),
                                    // Container(
                                    //   margin: EdgeInsets.only(top: 10.0),
                                    //   child: Text(
                                    //     'Enter your email to check in 30 minutes before your game.',
                                    //     style: CustomTextStyles.textSmall(
                                    //       color: Color(0xFFFFFFFF),
                                    //       fontSize: 26.sp,),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Enter your email to check in",
                              style: CustomTextStyles.display(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 48.sp, level: 5),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _CheckInInput(title: "", controller: logic.emailController),
                          SizedBox(height: 0.4.sh),
                          CommonButton(
                            width: 600.w,
                            height: 100.h,
                            btnText: 'NEXT',
                            btnBgColor: Color(0xff13EFEF),
                            textColor: Colors.black,
                            onPress: () async {
                              print("咔咔咔咔");
                              final RegExp _emailRegex = RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z]{2,}$',
                              );
                              bool _isValidEmail = _emailRegex.hasMatch(logic.emailController.text);
                              print("_isValidEmail ${_isValidEmail}");
                              if (_isValidEmail) {
                                logic.errorText = '';
                                EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                                try {
                                  // 校验邮箱
                                  Map checkingUser = await logic.checkingPlayer(logic.emailController.text);
                                  print("是否存在用户 ${checkingUser.isEmpty}");
                                  EasyLoading.dismiss(animation: false);
                                  // 为空不存在及新增，反之去old user页面
                                  if(checkingUser.isEmpty) {
                                    if(isFlow == "checkIn") {
                                      await Get.to(() => AddPlayerPage(),
                                          arguments: {
                                            "showInfo": showInfo,
                                            "bookingState": bookingState,
                                            "isAddPlayerClick": true,
                                            "tableId": tableId,
                                            "isFlow": "checkIn",
                                            "emailInput": logic.emailController.text,
                                          });
                                    }
                                    else if(isFlow == "tableCheck") {
                                      await Get.to(() => AddPlayerDataPage(),
                                          arguments: {"showState": showState, "isFlow": "tableCheck", "emailInput": logic.emailController.text,});
                                    }
                                  }
                                  else {
                                    print("参数 ${checkingUser['userId']}");
                                    try {
                                      EasyLoading.dismiss(animation: false);
                                      Map singlePlayer = await logic.fetchSingleUsers(checkingUser['userId']);
                                      print("singlePlayer ${singlePlayer}");
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
                                          "bookingState": bookingState,
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
                                  }
                                } on DioException catch (e) {
                                  EasyLoading.dismiss();
                                  if (e.response == null) EasyLoading.showError("Network Error!");
                                  EasyLoading.showError(e.response?.data["error"]["message"]);
                                }
                              }
                              else if(logic.emailController.text.isEmpty) {
                                logic.errorText = '';
                              }
                              else {
                                logic.errorText = 'Enter a valid email';
                              }
                              logic.refreshUserAuthenticatorPage();
                            },
                            changedBgColor: Color(0xffA4EDF1),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
        ),
    );
  }
}

class _CheckInInput extends StatefulWidget {
  _CheckInInput({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);
  final TextEditingController controller;
  final String? title;
  @override
  _CheckInInputState createState() => _CheckInInputState();
}

class _CheckInInputState extends State<_CheckInInput> {
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  int get tableId => Get.arguments["tableId"];
  String get isFlow => Get.arguments["isFlow"];
  ShowState get showState => Get.arguments?["showState"];

  String? get title => widget.title;
  TextEditingController get controller => widget.controller;
  // bool isHasFocus = true;
  final RegExp _emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z]{2,}$',
  );
  bool _isValidEmail = true;
  final logic = Get.put(UserRegistrationLogic());

  @override
  void initState() {
    super.initState();
    logic.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    logic.focusNode.removeListener(_onFocusChange);
    logic.focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() async {
    if (logic.focusNode.hasFocus) {
      // TextField 获得焦点时的处理逻辑
      print('TextField 获得焦点');
      print("_isValidEmail123123 ${_isValidEmail}");
    } else {
      // TextField 失去焦点时的处理逻辑
      print('TextField 失去焦点');
      setState(() {
        _isValidEmail = _emailRegex.hasMatch(controller.text);
      });
      print("_isValidEmail ${_isValidEmail}");
      if (_isValidEmail) {
        logic.errorText = '';
        EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
        try {
          EasyLoading.dismiss(animation: false);
          // 校验邮箱
          Map checkingUser = await logic.checkingPlayer(logic.emailController.text);
          print("是否存在用户 ${checkingUser.isEmpty}");
          // 为空不存在及新增，反之去old user页面
          if(checkingUser.isEmpty) {
            if(isFlow == "checkIn") {
              await Get.to(() => AddPlayerPage(),
                  arguments: {
                    "showInfo": showInfo,
                    "bookingState": bookingState,
                    "isAddPlayerClick": true,
                    "tableId": tableId,
                    "isFlow": "checkIn",
                    "emailInput": logic.emailController.text,
                  });
            }
            else if(isFlow == "tableCheck") {
              await Get.to(() => AddPlayerDataPage(),
                  arguments: {"showState": showState, "isFlow": "tableCheck", "emailInput": logic.emailController.text,});
            }
          }
          else {
            print("参数 ${checkingUser['userId']}");
            try {
              EasyLoading.dismiss(animation: false);
              Map singlePlayer = await logic.fetchSingleUsers(checkingUser['userId']);
              print("singlePlayer ${singlePlayer}");
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
                  "bookingState": bookingState,
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
          }
        } on DioException catch (e) {
          EasyLoading.dismiss();
          if (e.response == null) EasyLoading.showError("Network Error!");
          EasyLoading.showError(e.response?.data["error"]["message"]);
        }
      }
      else if(controller.text.isEmpty) {
        logic.errorText = '';
      }
      else {
        logic.errorText = 'Enter a valid email';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.4.sw,
      child: TextField(
        autofocus: true,
        controller: controller,
        cursorWidth: 5.0,          // 光标粗细
        cursorRadius: Radius.circular(3.0), // 使用Radius.circular设置圆形半径
        cursorColor: Colors.black,   // 光标颜色
        cursorHeight: 48.0, // 设置光标的高度，与文字的字体大小一致
        textAlign: TextAlign.left, // 设置文本居中
        inputFormatters: [
          // LengthLimitingTextInputFormatter(6), // 设置最大长度为6
        ],
        focusNode: logic.focusNode,
        // onChanged: (value) async {
        //   EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
        //   print("value ${value}");
        //   try {
        //     if(!isHasFocus) {
        //       // 校验邮箱
        //       Map checkingUser = await logic.checkingPlayer(logic.emailController.text);
        //       print("是否存在用户 ${checkingUser.isEmpty}");
        //     }
        //   } on DioException catch (e) {
        //     EasyLoading.dismiss();
        //     if (e.response == null) EasyLoading.showError("Network Error!");
        //     EasyLoading.showError(e.response?.data["error"]["message"]);
        //   }
        // },
        decoration: InputDecoration(
          fillColor: Color(0xFFDBE2E3),
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 30.w),
          errorText: logic.errorText.isNotEmpty ? logic.errorText : null, // 只有在有错误时显示错误文本
          errorStyle: CustomTextStyles.textNormal(color: Color(0xFFFF4848), fontSize: 30.sp), // 设置错误文本样式
          errorMaxLines: 1,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Colors.white,
            ),
          ),
        ),
        style: CustomTextStyles.verificationText(color: Color(0xFF000000), fontSize: 48.sp),
      ),
    );
  }
}