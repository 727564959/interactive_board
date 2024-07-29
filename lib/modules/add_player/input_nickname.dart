import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/model/show_state.dart';
import '../../mirra_style.dart';
import '../../widgets/common_icon_button.dart';
import '../check_in/add_player/view.dart';
import '../check_in/data/show.dart';
import '../check_in/home_page/booking_state.dart';
import '../table_check/add_player/view.dart';
import 'logic.dart';
import 'old_user.dart';

class InputNicknamePage extends StatelessWidget {
  InputNicknamePage({Key? key}) : super(key: key);
  final logic = Get.put(UserRegistrationLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<UserRegistrationLogic>(
            id: "InputNicknamePage",
            builder: (logic) {
              return Container(
                width: 1.0.sw,
                height: 1.0.sh,
                color: Color(0xFF233342),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 40.0),
                      constraints: BoxConstraints.tightFor(width: (1.0.sw - 40)), //卡片大小
                      child: Row(
                        children: [
                          SizedBox(width: 0.1.sw - 48 - 40,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Let's Get You a Name!",
                                  style: CustomTextStyles.title(
                                      color: Colors.white, fontSize: 48.sp, level: 2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Pick a name that stands out from the crowd.",
                                  style: CustomTextStyles.textSmall(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 26.sp,),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    _CheckInInput(title: "", controller: logic.nicknameController),
                  ],
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
  final logic = Get.put(UserRegistrationLogic());

  @override
  void initState() {
    super.initState();
    logic.focusNode1.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    logic.focusNode1.removeListener(_onFocusChange);
    logic.focusNode1.dispose();
    super.dispose();
  }

  void _onFocusChange() async {
    if (logic.focusNode1.hasFocus) {
      // TextField 获得焦点时的处理逻辑
      print('TextField 获得焦点');
    } else {
      // TextField 失去焦点时的处理逻辑
      print('TextField 失去焦点');
      setState(() {

      });
      EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
      try {
        EasyLoading.dismiss(animation: false);

      } on DioException catch (e) {
        EasyLoading.dismiss();
        if (e.response == null) EasyLoading.showError("Network Error!");
        EasyLoading.showError(e.response?.data["error"]["message"]);
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
        textAlign: TextAlign.center, // 设置文本居中
        inputFormatters: [
          // LengthLimitingTextInputFormatter(6), // 设置最大长度为6
        ],
        focusNode: logic.focusNode1,
        decoration: InputDecoration(
          fillColor: Color(0xFFDBE2E3),
          filled: true,
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