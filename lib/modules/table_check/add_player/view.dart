import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common.dart';
import '../../../data/model/show_state.dart';
import '../../../mirra_style.dart';
import '../../../widgets/common_Text_button.dart';
import '../../../widgets/common_button.dart';
import '../../check_in/add_player/player_info_text_field.dart';
import '../data/avatar_info.dart';
import '../headgear/view.dart';
import '../player_show/view.dart';
import 'birthday_page.dart';
import 'logic.dart';

class AddPlayerDataPage extends StatelessWidget {
  AddPlayerDataPage({Key? key}) : super(key: key);
  final logic = Get.put(AddPlayerDataLogic());

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).viewInsets.bottom);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder<AddPlayerDataLogic>(
          id: "AddPlayerDataPage",
          builder: (logic) {
            return Transform.translate(
              offset: Offset(0.0, -MediaQuery.of(context).viewInsets.bottom * 0.3),
              child: Container(
                width: 1.0.sw,
                height: 1.0.sh,
                color: const Color(0xFF233342),
                child: GetBuilder<AddPlayerDataLogic>(
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
  final logic = Get.find<AddPlayerDataLogic>();
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
                        // if (v!.isEmpty) {
                        //   return 'Please enter an email';
                        // }
                        // if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(v)) {
                        //   return 'Please enter a valid email';
                        // }
                        // return null;
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
class _BottomBtns extends StatelessWidget  {
  _BottomBtns({
    Key? key,
  }) : super(key: key);
  final logic = Get.put(AddPlayerDataLogic());
  ShowState get showState => Get.arguments["showState"];
  final testTabId = Global.tableId;

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
              Container(
                // margin: EdgeInsets.only(top: 30.0, right: 30.0),
                child: CommonButton(
                  width: 600.w,
                  height: 100.h,
                  btnText: 'NEXT',
                  btnBgColor: Color(0xff13EFEF),
                  textColor: Colors.black,
                  onPress: () async {
                    print("logic.formKey.currentState!.validate() ${logic.formKey.currentState!.validate()}");
                    if (logic.formKey.currentState!.validate()) {
                      Get.to(() => BirthdayPage(), arguments: {'showState': showState,},);
                    }
                    // if (logic.firstNameController.text.isNotEmpty &&
                    //     logic.lastNameController.text.isNotEmpty &&
                    //     logic.emailController.text.isNotEmpty &&
                    //     logic.phoneController.text.isNotEmpty) {
                    //   Get.to(() => BirthdayPage(), arguments: {'showState': showState,},);
                    // }
                  },
                  disable: !logic.firstNameController.text.isNotEmpty ||
                      !logic.lastNameController.text.isNotEmpty ||
                      !logic.emailController.text.isNotEmpty ||
                      !logic.phoneController.text.isNotEmpty,
                  changedBgColor: Color(0xffA4EDF1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                // child: _BackButton(),
                child: CommonTextButton(
                  btnText: "BACK",
                  textColor: Color(0xff13EFEF),
                  onPress: () {
                    Get.back();
                  },
                  changedTextColor: Color(0xffA4EDF1),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(top: 0.0, left: 0.0),
              //       child: Row(
              //         children: [
              //           _BackButton(width: 600.w),
              //           SizedBox(width: 10,),
              //           _NextButton(width: 600.w),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // Container(
              //   margin: EdgeInsets.only(top: 30.0, right: 30.0),
              //   child: _MaybeLatterButton(),
              // ),
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
  final logic = Get.find<AddPlayerDataLogic>();
  ShowState get showState => Get.arguments["showState"];
  final testTabId = Global.tableId;

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
          Get.to(() => BirthdayPage(), arguments: {'showState': showState,},);
        }
      },
      child: Container(
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
      ),
    );
  }
}

// class _BackButton extends StatelessWidget {
//   _BackButton({
//     Key? key,
//     required this.width,
//   }) : super(key: key);
//   final double width;
//   final logic = Get.find<AddPlayerDataLogic>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // 点击事件
//       onTap: () async {
//         Get.back();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           //设置边框
//           border: new Border.all(color: Color(0xff13EFEF), width: 1),
//           color: Color(0xFF233342),
//           borderRadius: BorderRadius.all(Radius.circular(50)),
//         ),
//         margin: EdgeInsets.only(top: 0.0, left: 30.0),
//         constraints: BoxConstraints.tightFor(width: width, height: 100.h), //卡片大小
//         child: Center(
//           child: Text(
//             "BACK",
//             textAlign: TextAlign.center,
//             style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _MaybeLatterButton extends StatelessWidget {
  _MaybeLatterButton({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<AddPlayerDataLogic>();
  ShowState get showState => Get.arguments["showState"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        Map skipUserInfo = await logic.addSkipPlayer();
        // 加入到show
        await logic.addPlayerToShow(showState.showId??1, Global.tableId, skipUserInfo['userId']);
        List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(skipUserInfo['userId']);
        if(headgearObj.isEmpty) {
          Get.offAll(() => PlayerShowPage(),
              arguments: {
                'showState': showState,
              });
        }
        else {
          print("headgearObj: ${headgearObj}");
          print("headgearObj: ${skipUserInfo['userId']}");
          Future.delayed(0.5.seconds).then((value) async {
            Get.offAll(() => HeadgearPage(),
                      arguments: {
                        'showState': showState,
                        'headgearObj': headgearObj,
                        'userId': skipUserInfo['userId'],
                      },
            );
          });
        }
      },
      child: Text(
        "MAYBE LATTER",
        style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
      ),
    );
  }
}

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
        style: CustomTextStyles.button(color: Color(0xFF13EFEF), fontSize: 28.sp),
      ),
    );
  }
}
