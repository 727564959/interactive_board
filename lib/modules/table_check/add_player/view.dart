import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common.dart';
import '../../../data/model/show_state.dart';
import '../../../mirra_style.dart';
import '../../../widgets/common_Text_button.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_icon_button.dart';
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
                        Container(
                          width: 1.0.sw,
                          margin: const EdgeInsets.only(top: 20.0, left: 40.0),
                          child: Row(
                            children: [
                              CommonIconButton(
                                onPress: () {
                                  Get.back();
                                },
                              ),
                              SizedBox(width: 0.1.sw - 48 - 40,),
                              Container(
                                // margin: const EdgeInsets.only(top: 40.0, left: 40.0),
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
                      isFormFieldEnabled: false,
                      validator: (v) {
                        // String regexEmail =
                        //     "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
                        return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(v.toString()) ? null : "The Email format is incorrect";
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

  late FToast fToast = FToast();
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
          RichText(
            text: TextSpan(
              text: "Oops! That firstname doesn't seem quite right.\n",
              style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 26.sp, level: 4),
              children: <TextSpan>[
                TextSpan(
                  text: "Let's try another one.",
                  style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 26.sp, level: 4),
                ),
              ],
            ),
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
                    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                    try {
                      // EasyLoading.dismiss(animation: false);
                      // if (logic.formKey.currentState!.validate()) {
                      //   if (logic.formKey.currentState!.validate()) {
                      //     Get.to(() => BirthdayPage(), arguments: {'showState': showState, "isFlow": "tableCheck"},);
                      //   }
                      // }
                      Map sensitiveWordDetector1 = await logic.sensitiveWordDetector(logic.firstNameController.text);
                      // Map sensitiveWordDetector2 = await logic.sensitiveWordDetector(logic.lastNameController.text);
                      // Map sensitiveWordDetector3 = await logic.sensitiveWordDetector(logic.phoneController.text);
                      // // firstname lastname phone都必须通过敏感字校验
                      // if(sensitiveWordDetector1['pass'] && sensitiveWordDetector2['pass'] && sensitiveWordDetector3['pass']) {
                      if(sensitiveWordDetector1['pass']) {
                        EasyLoading.dismiss(animation: false);
                        if (logic.formKey.currentState!.validate()) {
                          if (logic.formKey.currentState!.validate()) {
                            Get.to(() => BirthdayPage(), arguments: {'showState': showState, "isFlow": "tableCheck"},);
                          }
                        }
                      }
                      else {
                        showCustomToast();
                        EasyLoading.dismiss(animation: false);
                      }
                    } on DioException catch (e) {
                      EasyLoading.dismiss();
                      if (e.response == null) EasyLoading.showError("Network Error!");
                      EasyLoading.showError(e.response?.data["error"]["message"]);
                    }
                  },
                  disable: !logic.firstNameController.text.isNotEmpty ||
                      !logic.lastNameController.text.isNotEmpty ||
                      !logic.emailController.text.isNotEmpty ||
                      !logic.phoneController.text.isNotEmpty,
                  changedBgColor: Color(0xffA4EDF1),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 30.0),
              //   // child: _BackButton(),
              //   child: CommonTextButton(
              //     btnText: "BACK",
              //     textColor: Color(0xff13EFEF),
              //     onPress: () {
              //       Get.back();
              //     },
              //     changedTextColor: Color(0xffA4EDF1),
              //   ),
              // ),
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
