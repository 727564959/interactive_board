import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common.dart';
import '../../../../widgets/check_in_title.dart';
import '../../../data/model/show_state.dart';
import '../../../mirra_style.dart';
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
    return GestureDetector(
      child: GetBuilder<AddPlayerDataLogic>(
        id: "AddPlayerDataPage",
        builder: (logic) {
          return Container(
            width: 1.0.sw,
            height: 1.0.sh,
            color: Color(0xFF233342),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: 1.0.sw,
                    child: GetBuilder<AddPlayerDataLogic>(
                      builder: (logic) {
                        return Column(
                          children: [
                            // 顶部文本信息
                            SizedBox(
                              width: 1.0.sw,
                              height: 0.15.sh,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 40.0, left: 40.0),
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
                            _PlayerForm(),
                            // 底部按钮区域
                            _BottomBtns(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 中间的用户信息录入
class _PlayerForm extends StatelessWidget {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.0.sw,
      height: 0.6.sh,
      child: GetBuilder<AddPlayerDataLogic>(builder: (logic) {
        return Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
                    constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h), //卡片大小
                    alignment: Alignment.center, //卡片内文字居中
                    child: Column(
                      children: [
                        Align(
                          // heightFactor: 3,
                          // alignment: const Alignment(-1.0, 0.0),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 30.0, top: 40.0),
                            child: Text(
                              "First Name",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 5),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFDBE2E3),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                              // 默认可编辑时的边框
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff5A5858), //边线颜色为白色
                                  width: 2, //边线宽度为2
                                ),
                              ),
                              // 输入时的边框
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue, //边框颜色为白色
                                  width: 2, //宽度为5
                                ),
                              ),
                              errorStyle: TextStyle(fontSize: 18),
                              errorMaxLines: 1,
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  )),
                            ),
                            // 校验用户名
                            validator: (v) {
                              return v!.trim().isNotEmpty ? null : "The name cannot be empty";
                            },
                            // 名字校验
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Za-z0-9]+'),
                              )
                            ],
                            onChanged: (v) {
                              print("onChange: $v");
                              logic.firstName = v;
                            },
                            style: CustomTextStyles.title(color: Colors.black, fontSize: 34.sp, level: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.0, left: 10.0),
                    constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h), //卡片大小
                    alignment: Alignment.center, //卡片内文字居中
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 30.0, top: 40.0),
                            child: Text(
                              "Last Name",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFDBE2E3),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                              // 默认可编辑时的边框
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff5A5858), //边线颜色为白色
                                  width: 2, //边线宽度为2
                                ),
                              ),
                              // 输入时的边框
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue, //边框颜色为白色
                                  width: 2, //宽度为5
                                ),
                              ),
                              errorStyle: TextStyle(fontSize: 18),
                              errorMaxLines: 1,
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  )),
                            ),
                            // 校验用户名
                            validator: (v) {
                              return v!.trim().isNotEmpty ? null : "The name cannot be empty";
                            },
                            // 名字校验
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Za-z0-9]+'),
                              )
                            ],
                            onChanged: (v) {
                              print("onChange: $v");
                              logic.lastName = v;
                            },
                            style: CustomTextStyles.title(color: Colors.black, fontSize: 34.sp, level: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.0, left: 0.1.sw),
                    constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h), //卡片大小
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 30.0, top: 20.0),
                            child: Text(
                              "Email",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFDBE2E3),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                              // 默认可编辑时的边框
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff5A5858), //边线颜色为白色
                                  width: 2, //边线宽度为2
                                ),
                              ),
                              // 输入时的边框
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue, //边框颜色为白色
                                  width: 2, //宽度为5
                                ),
                              ),
                              errorStyle: TextStyle(fontSize: 18),
                              errorMaxLines: 1,
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  )),
                            ),
                            // 校验邮箱
                            validator: (v) {
                              String regexEmail =
                                  "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
                              return new RegExp(regexEmail).hasMatch(v.toString())
                                  ? null
                                  : "The Email format is incorrect";
                            },
                            onChanged: (v) {
                              print("onChange: $v");
                              logic.email = v;
                            },
                            style: CustomTextStyles.title(color: Colors.black, fontSize: 34.sp, level: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.0, left: 10.0),
                    constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h), //卡片大小
                    alignment: Alignment.center, //卡片内文字居中
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 30.0, top: 20.0),
                            child: Text(
                              "Phone number",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFDBE2E3),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                              // 默认可编辑时的边框
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff5A5858), //边线颜色为白色
                                  width: 2, //边线宽度为2
                                ),
                              ),
                              // 输入时的边框
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue, //边框颜色为白色
                                  width: 2, //宽度为5
                                ),
                              ),
                              errorStyle: TextStyle(fontSize: 18),
                              errorMaxLines: 1,
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  )),
                            ),
                            // 校验电话
                            validator: (v) {
                              return v!.trim().isNotEmpty ? null : "The phone cannot be empty";
                            },
                            // 电话校验
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+'),
                              )
                            ],
                            onChanged: (v) {
                              print("onChange: $v");
                              logic.phone = v;
                            },
                            style: CustomTextStyles.title(color: Colors.black, fontSize: 34.sp, level: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

// 底部的功能按钮区域
class _BottomBtns extends StatelessWidget  {
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
                        SizedBox(width: 10,),
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
  final logic = Get.find<AddPlayerDataLogic>();
  ShowState get showState => Get.arguments["showState"];
  final testTabId = Global.tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        if(logic.email.isNotEmpty && logic.phone.isNotEmpty && logic.firstName.isNotEmpty && logic.lastName.isNotEmpty) {
          Get.to(() => BirthdayPage(), arguments: {'showState': showState,},);
        }
        else {
          EasyLoading.showError("Please fill in the information !");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 80.h),
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

class _BackButton extends StatelessWidget {
  _BackButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<AddPlayerDataLogic>();

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
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 30.0),
        constraints: BoxConstraints.tightFor(width: width, height: 80.h), //卡片大小
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
            Get.offAll(
                  () => HeadgearPage(),
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
