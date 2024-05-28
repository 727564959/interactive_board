import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:interactive_board/modules/check_in/add_player/player_info_text_field.dart';

import '../../../mirra_style.dart';
import '../data/avatar_info.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../headgear_acquisition/view.dart';
import '../player_page/logic.dart';
import '../player_page/player_squad.dart';
import 'birthday_page.dart';
import 'logic.dart';

class AddPlayerPage extends StatelessWidget {
  AddPlayerPage({Key? key}) : super(key: key);
  final logic = Get.put(AddPlayerLogic());
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).viewInsets.bottom);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder<AddPlayerLogic>(
          id: "addPlayerPage",
          builder: (logic) {
            return Transform.translate(
              offset: Offset(0.0, -MediaQuery.of(context).viewInsets.bottom * 0.3),
              child: Container(
                width: 1.0.sw,
                height: 1.0.sh,
                color: const Color(0xFF233342),
                child: GetBuilder<AddPlayerLogic>(
                  builder: (logic) {
                    return Column(
                      children: [
                        // 顶部文本信息
                        SizedBox(
                          width: 1.0.sw,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 40.0, left: 40.0),
                                child: SizedBox(
                                  child: Text(
                                    "Add Player",
                                    style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _PlayerInfoForm(),
                        _BottomBtns(),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlayerInfoForm extends StatelessWidget {
  _PlayerInfoForm({Key? key}) : super(key: key);
  final logic = Get.find<AddPlayerLogic>();
  final FocusScopeNode node = FocusScopeNode();
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: node,
      child: SizedBox(
        height: 0.65.sh,
        child: Center(
          child: Form(
            key: logic.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PlayerInfoTextField(
                      title: "First Name",
                      controller: logic.firstNameController,
                      keyboardType: TextInputType.name,
                      onEditingComplete: () {
                        if (logic.firstNameController.value.text.isEmpty) {
                          node.unfocus();
                        } else {
                          node.nextFocus();
                        }
                      },
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "The name cannot be empty";
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-z]+'),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PlayerInfoTextField(
                      title: "Last Name",
                      controller: logic.lastNameController,
                      keyboardType: TextInputType.name,
                      onEditingComplete: () {
                        if (logic.lastNameController.value.text.isEmpty) {
                          node.unfocus();
                        } else {
                          node.nextFocus();
                        }
                      },
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "The name cannot be empty";
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-z]+'),
                        )
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: 100.w),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PlayerInfoTextField(
                      title: "Email",
                      keyboardType: TextInputType.emailAddress,
                      onEditingComplete: () {
                        if (logic.emailController.value.text.isEmpty) {
                          node.unfocus();
                        } else {
                          node.nextFocus();
                        }
                      },
                      controller: logic.emailController,
                      validator: (v) {
                        String regexEmail =
                            "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
                        return RegExp(regexEmail).hasMatch(v.toString()) ? null : "The Email format is incorrect";
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PlayerInfoTextField(
                      title: "Phone Number",
                      keyboardType: TextInputType.number,
                      onEditingComplete: () {
                        node.unfocus();
                      },
                      controller: logic.phoneController,
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "The phone cannot be empty";
                      },
                      // 电话校验
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 底部的功能按钮区域
class _BottomBtns extends StatelessWidget {
  const _BottomBtns({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: EdgeInsets.only(top: 0.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 1.0.sw, height: 200.h), //卡片大小
      alignment: Alignment.center,
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.0, left: 0.0),
                    child: Row(
                      children: [
                        _BackButton(width: 600.w),
                        SizedBox(
                          width: 10,
                        ),
                        _NextButton(width: 600.w),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0, right: 30.0),
                child: _MaybeLatterButton(),
              ),
            ],
          )
        ],
      ),
    );
    return content;
  }
}

// 下一步的按钮
class _NextButton extends StatelessWidget {
  _NextButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;

  final logic = Get.find<AddPlayerLogic>();
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        logic.formKey.currentState!.validate();
        if (logic.firstNameController.text.isNotEmpty &&
            logic.lastNameController.text.isNotEmpty &&
            logic.emailController.text.isNotEmpty &&
            logic.phoneController.text.isNotEmpty) {
          // print("logic.firstNameController.text ${logic.firstNameController.text}");
          Get.to(() => BirthdayPage(),
            arguments: {
              'showInfo': showInfo,
              'customer': customer,
              "isAddPlayerClick": isAddPlayerClick,
              "tableId": tableId,
            },
          );
        }
      },
      child: GetBuilder<AddPlayerLogic>(
        id: "editNextBtn",
        builder: (logic) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff13EFEF),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            margin: EdgeInsets.only(top: 0.0, left: 0.0),
            constraints: BoxConstraints.tightFor(width: width, height: 100.h),
            child: Center(
              child: Text(
                "NEXT",
                textAlign: TextAlign.center,
                style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  _BackButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<AddPlayerLogic>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          //设置边框
          border: new Border.all(color: Color(0xff13EFEF), width: 1),
          color: Color(0xFF233342),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 30.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h), //卡片大小
        child: Center(
          child: Text(
            "BACK",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}

class _MaybeLatterButton extends StatelessWidget {
  _MaybeLatterButton({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<AddPlayerLogic>();
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        Map skipUserInfo = await logic.addSkipPlayer();
        // 加入到show
        await logic.addPlayerToShow(showInfo.showId, tableId, skipUserInfo['userId']);
        List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(skipUserInfo['userId']);
        if (headgearObj.isEmpty) {
          if (Get.isRegistered<PlayerShowLogic>()) {
            Get.find<PlayerShowLogic>().getPlayerCardInfo(showInfo.showId);
          }
          Get.offAll(() => PlayerSquadPage(), arguments: {
            'showInfo': showInfo,
            'customer': customer,
            "isAddPlayerClick": isAddPlayerClick,
            "tableId": tableId,
          });
        } else {
          print("headgearObj: ${headgearObj}");
          print("headgearObj: ${skipUserInfo['userId']}");
          Future.delayed(0.5.seconds).then((value) async {
            print("延迟跳转");
            print("headgearObj: ${headgearObj}");
            print("headgearObj: ${skipUserInfo['userId']}");
            Get.offAll(() => HeadgearAcquisitionPage(),
              arguments: {
                'showInfo': showInfo,
                'customer': customer,
                'headgearObj': headgearObj,
                'userId': skipUserInfo['userId'],
                "isAddPlayerClick": isAddPlayerClick,
                "tableId": tableId,
              },
            );
          });
        }
      },
      child: GetBuilder<AddPlayerLogic>(
        id: "maybeLatterBtn",
        builder: (logic) {
          return Text(
            "MAYBE LATTER",
            style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
          );
        },
      ),
    );
  }
}
