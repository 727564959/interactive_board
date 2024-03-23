import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../modules/set_avatar/logic.dart';
import '../../../../widgets/check_in_title.dart';
import '../../data/checkIn_api.dart';
import '../../logic.dart';
import '../after_checkIn/player_info_show.dart';
import '../treasure_chest/explosive_chest.dart';
import 'add_player_birthday.dart';

class AddPlayerInfo extends StatelessWidget {
  AddPlayerInfo({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GetBuilder<CheckInLogic>(
        id: "addPlayerInfoPage",
        builder: (logic) {
          return Container(
            width: 1.0.sw,
            height: 1.0.sh,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(
                  width: 1.0.sw,
                  child: GetBuilder<CheckInLogic>(
                    builder: (logic) {
                      return Column(
                        children: [
                          // 顶部文本信息
                          CheckInTitlePage(titleText: "Add Player"),
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
  // // 创建 focusNode
  // FocusNode _emailFocusNode = FocusNode();
  // FocusNode _phoneFocusNode = FocusNode();

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.0.sw,
      height: 0.6.sh,
      child: GetBuilder<CheckInLogic>(builder: (logic) {
        return Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40.0, left: 120.0),
                    constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h), //卡片大小
                    // alignment: Alignment.center, //卡片内文字居中
                    child: Column(
                      children: [
                        Align(
                          heightFactor: 3,
                          alignment: const Alignment(-1.0, 0.0),
                          child: Text(
                            "First Name",
                            style: TextStyle(
                              fontSize: 35.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              fillColor: Color(0xff212121),
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
                            style: TextStyle(
                              fontSize: 50.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                          // child: TextField(
                          //   controller: _firstNameController,
                          //   decoration: InputDecoration(
                          //     fillColor: Color(0xff212121),
                          //     filled: true,
                          //     contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                          //     // 默认可编辑时的边框
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Color(0xff5A5858), //边线颜色为白色
                          //         width: 2, //边线宽度为2
                          //       ),
                          //     ),
                          //     // 输入时的边框
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.blue, //边框颜色为白色
                          //         width: 2, //宽度为5
                          //       ),
                          //     ),
                          //     // errorText: logic.nameError,
                          //     // errorStyle: TextStyle(fontSize: 24),
                          //     // errorMaxLines: 1,
                          //     // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1,)),
                          //   ),
                          //   // 名字校验
                          //   inputFormatters: [
                          //     LengthLimitingTextInputFormatter(15),
                          //     FilteringTextInputFormatter.allow(
                          //       RegExp(r'[A-Za-z0-9]+'),
                          //     )
                          //   ],
                          //   onChanged: (v) {
                          //     print("onChange: $v");
                          //     logic.firstName = v;
                          //   },
                          //   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                          // ),
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
                          heightFactor: 3,
                          alignment: const Alignment(-1.0, 0.0),
                          child: Text(
                            "Last Name",
                            style: TextStyle(
                              fontSize: 35.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              fillColor: Color(0xff212121),
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
                            style: TextStyle(
                              fontSize: 50.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                          // child: TextField(
                          //   controller: _lastNameController,
                          //   decoration: InputDecoration(
                          //     fillColor: Color(0xff212121),
                          //     filled: true,
                          //     contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                          //     // 默认可编辑时的边框
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Color(0xff5A5858), //边线颜色为白色
                          //         width: 2, //边线宽度为2
                          //       ),
                          //     ),
                          //     // 输入时的边框
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.blue, //边框颜色为白色
                          //         width: 2, //宽度为5
                          //       ),
                          //     ),
                          //   ),
                          //   // 名字校验
                          //   inputFormatters: [
                          //     LengthLimitingTextInputFormatter(15),
                          //     FilteringTextInputFormatter.allow(
                          //       RegExp(r'[A-Za-z0-9]+'),
                          //     )
                          //   ],
                          //   onChanged: (v) {
                          //     print("onChange: $v");
                          //     logic.lastName = v;
                          //   },
                          //   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.0, left: 120.0),
                    constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h), //卡片大小
                    child: Column(
                      children: [
                        Align(
                          heightFactor: 3,
                          alignment: const Alignment(-1.0, 0.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 35.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              fillColor: Color(0xff212121),
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
                            style: TextStyle(
                              fontSize: 50.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                          // child: TextField(
                          //   keyboardType: TextInputType.emailAddress,
                          //   controller: _emailController,
                          //   // focusNode: _emailFocusNode,
                          //   decoration: InputDecoration(
                          //     fillColor: Color(0xff212121),
                          //     filled: true,
                          //     contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                          //     // suffix: Text('.com'),
                          //     // suffixIcon: Icon(Icons.lock, size: 30, color: Colors.white,),
                          //     // suffixStyle: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                          //     // 默认可编辑时的边框
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Color(0xff5A5858), //边线颜色为白色
                          //         width: 2, //边线宽度为2
                          //       ),
                          //     ),
                          //     // 输入时的边框
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.blue, //边框颜色为白色
                          //         width: 2, //宽度为5
                          //       ),
                          //     ),
                          //     // errorText: _getErrorText(),
                          //     // errorStyle: TextStyle(fontSize: 12),
                          //     // errorMaxLines: 1,
                          //     // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2,)),
                          //   ),
                          //   autocorrect: false,
                          //   // 邮箱校验
                          //   inputFormatters: [
                          //     LengthLimitingTextInputFormatter(30),
                          //     // FilteringTextInputFormatter.allow(
                          //     //   RegExp("^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$"),
                          //     // )
                          //     // FilteringTextInputFormatter.allow(
                          //     //   RegExp('^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$'),
                          //     // )
                          //     // FilteringTextInputFormatter.allow(
                          //     //   RegExp('^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$'),
                          //     // )
                          //   ],
                          //   onChanged: (v) {
                          //     print("onChange: $v");
                          //     // logic.email = v + ".com";
                          //     logic.email = v;
                          //   },
                          //   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                          // ),
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
                          heightFactor: 3,
                          alignment: const Alignment(-1.0, 0.0),
                          child: Text(
                            "Phone number",
                            style: TextStyle(
                              fontSize: 35.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              fillColor: Color(0xff212121),
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
                            style: TextStyle(
                              fontSize: 50.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                          // child: TextField(
                          //   controller: _phoneController,
                          //   // focusNode: _phoneFocusNode,
                          //   keyboardType: TextInputType.phone,
                          //   decoration: InputDecoration(
                          //     fillColor: Color(0xff212121),
                          //     filled: true,
                          //     contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                          //     // 默认可编辑时的边框
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Color(0xff5A5858), //边线颜色为白色
                          //         width: 2, //边线宽度为2
                          //       ),
                          //     ),
                          //     // 输入时的边框
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.blue, //边框颜色为白色
                          //         width: 2, //宽度为5
                          //       ),
                          //     ),
                          //   ),
                          //   // 电话号码校验
                          //   inputFormatters: [
                          //     FilteringTextInputFormatter.allow(
                          //       RegExp(r'[0-9]+'),
                          //     )
                          //   ],
                          //   onChanged: (value) {
                          //     // this.phoneNo=value;
                          //     print(value);
                          //     logic.phone = value;
                          //   },
                          //   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                          // ),
                        ),
                        // SizedBox(
                        //   child: Row(
                        //     children: <Widget>[
                        //       Expanded(
                        //         child: CountryPickerDropdown(
                        //           initialValue: 'us',
                        //           itemBuilder: _buildDropdownItem,
                        //           onValuePicked: (Country country) {
                        //             print("${country.phoneCode}");
                        //             print("${country.name}");
                        //             logic.countryName = country.phoneCode;
                        //           },
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: TextField(
                        //           controller: _phoneController,
                        //           // focusNode: _phoneFocusNode,
                        //           keyboardType: TextInputType.phone,
                        //           decoration: InputDecoration(
                        //             fillColor: Color(0xff212121),
                        //             filled: true,
                        //             contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                        //             // 默认可编辑时的边框
                        //             enabledBorder: OutlineInputBorder(
                        //               borderSide: BorderSide(
                        //                 color: Color(0xff5A5858), //边线颜色为白色
                        //                 width: 2, //边线宽度为2
                        //               ),
                        //             ),
                        //             // 输入时的边框
                        //             focusedBorder: OutlineInputBorder(
                        //               borderSide: BorderSide(
                        //                 color: Colors.blue, //边框颜色为白色
                        //                 width: 2, //宽度为5
                        //               ),
                        //             ),
                        //           ),
                        //           // 电话号码校验
                        //           inputFormatters: [
                        //             FilteringTextInputFormatter.allow(
                        //               RegExp(r'[0-9]+'),
                        //             )
                        //           ],
                        //           onChanged: (value) {
                        //             // this.phoneNo=value;
                        //             print(value);
                        //             logic.phone = value;
                        //           },
                        //           style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              // _NextButton(width: 600.w, testValidate: (_formKey.currentState as FormState).validate()),
            ],
          ),
        );
        // return Column(
        //   children: [
        //     Row(
        //       children: [
        //         Container(
        //           margin: EdgeInsets.only(top: 40.0, left: 120.0),
        //           constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h),//卡片大小
        //           // alignment: Alignment.center, //卡片内文字居中
        //           child: Column(
        //             children: [
        //               Align(
        //                 heightFactor: 3,
        //                 alignment: const Alignment(-1.0, 0.0),
        //                 child: Text(
        //                   "First Name",
        //                   style: TextStyle(
        //                     fontSize: 35.sp,
        //                     decoration: TextDecoration.none,
        //                     fontFamily: 'BurbankBold',
        //                     color: Colors.white,
        //                     letterSpacing: 3.sp,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                 child: TextField(
        //                   controller: _firstNameController,
        //                   decoration: InputDecoration(
        //                     fillColor: Color(0xff212121),
        //                     filled: true,
        //                     contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
        //                     // 默认可编辑时的边框
        //                     enabledBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                         color: Color(0xff5A5858), //边线颜色为白色
        //                         width: 2, //边线宽度为2
        //                       ),
        //                     ),
        //                     // 输入时的边框
        //                     focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                         color: Colors.blue, //边框颜色为白色
        //                         width: 2, //宽度为5
        //                       ),
        //                     ),
        //                     // errorText: logic.nameError,
        //                     // errorStyle: TextStyle(fontSize: 24),
        //                     // errorMaxLines: 1,
        //                     // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1,)),
        //                   ),
        //                   // 名字校验
        //                   inputFormatters: [
        //                     LengthLimitingTextInputFormatter(15),
        //                     FilteringTextInputFormatter.allow(
        //                       RegExp(r'[A-Za-z0-9]+'),
        //                     )
        //                   ],
        //                   onChanged: (v) {
        //                     print("onChange: $v");
        //                     logic.firstName = v;
        //                   },
        //                   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Container(
        //           margin: EdgeInsets.only(top: 40.0, left: 10.0),
        //           constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h),//卡片大小
        //           alignment: Alignment.center, //卡片内文字居中
        //           child: Column(
        //             children: [
        //               Align(
        //                 heightFactor: 3,
        //                 alignment: const Alignment(-1.0, 0.0),
        //                 child: Text(
        //                   "Last Name",
        //                   style: TextStyle(
        //                     fontSize: 35.sp,
        //                     decoration: TextDecoration.none,
        //                     fontFamily: 'BurbankBold',
        //                     color: Colors.white,
        //                     letterSpacing: 3.sp,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                 child: TextField(
        //                   controller: _lastNameController,
        //                   decoration: InputDecoration(
        //                     fillColor: Color(0xff212121),
        //                     filled: true,
        //                     contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
        //                     // 默认可编辑时的边框
        //                     enabledBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                         color: Color(0xff5A5858), //边线颜色为白色
        //                         width: 2, //边线宽度为2
        //                       ),
        //                     ),
        //                     // 输入时的边框
        //                     focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                         color: Colors.blue, //边框颜色为白色
        //                         width: 2, //宽度为5
        //                       ),
        //                     ),
        //                   ),
        //                   // 名字校验
        //                   inputFormatters: [
        //                     LengthLimitingTextInputFormatter(15),
        //                     FilteringTextInputFormatter.allow(
        //                       RegExp(r'[A-Za-z0-9]+'),
        //                     )
        //                   ],
        //                   onChanged: (v) {
        //                     print("onChange: $v");
        //                     logic.lastName = v;
        //                   },
        //                   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Container(
        //           margin: EdgeInsets.only(top: 0.0, left: 120.0),
        //           constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h),//卡片大小
        //           child: Column(
        //             children: [
        //               Align(
        //                 heightFactor: 3,
        //                 alignment: const Alignment(-1.0, 0.0),
        //                 child: Text(
        //                   "Email",
        //                   style: TextStyle(
        //                     fontSize: 35.sp,
        //                     decoration: TextDecoration.none,
        //                     fontFamily: 'BurbankBold',
        //                     color: Colors.white,
        //                     letterSpacing: 3.sp,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                 child: TextField(
        //                   keyboardType: TextInputType.emailAddress,
        //                   controller: _emailController,
        //                   // focusNode: _emailFocusNode,
        //                   decoration: InputDecoration(
        //                     fillColor: Color(0xff212121),
        //                     filled: true,
        //                     contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
        //                     // suffix: Text('.com'),
        //                     // suffixIcon: Icon(Icons.lock, size: 30, color: Colors.white,),
        //                     // suffixStyle: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
        //                     // 默认可编辑时的边框
        //                     enabledBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                         color: Color(0xff5A5858), //边线颜色为白色
        //                         width: 2, //边线宽度为2
        //                       ),
        //                     ),
        //                     // 输入时的边框
        //                     focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                         color: Colors.blue, //边框颜色为白色
        //                         width: 2, //宽度为5
        //                       ),
        //                     ),
        //                     // errorText: _getErrorText(),
        //                     // errorStyle: TextStyle(fontSize: 12),
        //                     // errorMaxLines: 1,
        //                     // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2,)),
        //                   ),
        //                   autocorrect: false,
        //                   // 邮箱校验
        //                   inputFormatters: [
        //                     LengthLimitingTextInputFormatter(30),
        //                     // FilteringTextInputFormatter.allow(
        //                     //   RegExp("^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$"),
        //                     // )
        //                     // FilteringTextInputFormatter.allow(
        //                     //   RegExp('^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$'),
        //                     // )
        //                     // FilteringTextInputFormatter.allow(
        //                     //   RegExp('^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$'),
        //                     // )
        //                   ],
        //                   onChanged: (v) {
        //                     print("onChange: $v");
        //                     // logic.email = v + ".com";
        //                     logic.email = v;
        //                   },
        //                   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Container(
        //           margin: EdgeInsets.only(top: 0.0, left: 10.0),
        //           constraints: BoxConstraints.tightFor(width: 750.w, height: 270.h),//卡片大小
        //           alignment: Alignment.center, //卡片内文字居中
        //           child: Column(
        //             children: [
        //               Align(
        //                 heightFactor: 3,
        //                 alignment: const Alignment(-1.0, 0.0),
        //                 child: Text(
        //                   "Phone number",
        //                   style: TextStyle(
        //                     fontSize: 35.sp,
        //                     decoration: TextDecoration.none,
        //                     fontFamily: 'BurbankBold',
        //                     color: Colors.white,
        //                     letterSpacing: 3.sp,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                 child: TextField(
        //                   controller: _phoneController,
        //                   // focusNode: _phoneFocusNode,
        //                   keyboardType: TextInputType.phone,
        //                   decoration: InputDecoration(
        //                     fillColor: Color(0xff212121),
        //                     filled: true,
        //                     contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
        //                     // 默认可编辑时的边框
        //                     enabledBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                         color: Color(0xff5A5858), //边线颜色为白色
        //                         width: 2, //边线宽度为2
        //                       ),
        //                     ),
        //                     // 输入时的边框
        //                     focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                         color: Colors.blue, //边框颜色为白色
        //                         width: 2, //宽度为5
        //                       ),
        //                     ),
        //                   ),
        //                   // 电话号码校验
        //                   inputFormatters: [
        //                     FilteringTextInputFormatter.allow(
        //                       RegExp(r'[0-9]+'),
        //                     )
        //                   ],
        //                   onChanged: (value) {
        //                     // this.phoneNo=value;
        //                     print(value);
        //                     logic.phone = value;
        //                   },
        //                   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
        //                 ),
        //               ),
        //               // SizedBox(
        //               //   child: Row(
        //               //     children: <Widget>[
        //               //       Expanded(
        //               //         child: CountryPickerDropdown(
        //               //           initialValue: 'us',
        //               //           itemBuilder: _buildDropdownItem,
        //               //           onValuePicked: (Country country) {
        //               //             print("${country.phoneCode}");
        //               //             print("${country.name}");
        //               //             logic.countryName = country.phoneCode;
        //               //           },
        //               //         ),
        //               //       ),
        //               //       Expanded(
        //               //         child: TextField(
        //               //           controller: _phoneController,
        //               //           // focusNode: _phoneFocusNode,
        //               //           keyboardType: TextInputType.phone,
        //               //           decoration: InputDecoration(
        //               //             fillColor: Color(0xff212121),
        //               //             filled: true,
        //               //             contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
        //               //             // 默认可编辑时的边框
        //               //             enabledBorder: OutlineInputBorder(
        //               //               borderSide: BorderSide(
        //               //                 color: Color(0xff5A5858), //边线颜色为白色
        //               //                 width: 2, //边线宽度为2
        //               //               ),
        //               //             ),
        //               //             // 输入时的边框
        //               //             focusedBorder: OutlineInputBorder(
        //               //               borderSide: BorderSide(
        //               //                 color: Colors.blue, //边框颜色为白色
        //               //                 width: 2, //宽度为5
        //               //               ),
        //               //             ),
        //               //           ),
        //               //           // 电话号码校验
        //               //           inputFormatters: [
        //               //             FilteringTextInputFormatter.allow(
        //               //               RegExp(r'[0-9]+'),
        //               //             )
        //               //           ],
        //               //           onChanged: (value) {
        //               //             // this.phoneNo=value;
        //               //             print(value);
        //               //             logic.phone = value;
        //               //           },
        //               //           style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
        //               //         ),
        //               //       ),
        //               //     ],
        //               //   ),
        //               // ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // );
      }),
    );
  }
}

Widget _buildDropdownItem(Country country) => Container(
      // decoration: BoxDecoration(
      //   //设置边框
      //   border: new Border.all(color: Color(0xFFFF0000), width: 2),
      // ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 16.0,
          ),
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "+${country.phoneCode}(${country.isoCode})",
            style: TextStyle(
              fontSize: 32.sp,
              decoration: TextDecoration.none,
              fontFamily: 'BurbankBold',
              color: Colors.white,
              letterSpacing: 3.sp,
            ),
          ),
        ],
      ),
    );

// 底部的功能按钮区域
class _BottomBtns extends StatelessWidget {
  const _BottomBtns({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: EdgeInsets.only(top: 0.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 0.94.sw, height: 200.h), //卡片大小
      alignment: Alignment.center,
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.0, left: 100.0),
                    child: Row(
                      children: [
                        _NextButton(width: 600.w),
                        _SkipButton(),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0, right: 30.0),
                child: _BackButton(),
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
  final logic = Get.find<CheckInLogic>();
  // String get backgroundUri => Global.getSetAvatarImageUrl("group_setting_input.png");

  final testTabId = Global.tableId;

  get checkInApi => CheckInApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        if(logic.email.isNotEmpty && logic.phone.isNotEmpty && logic.firstName.isNotEmpty && logic.lastName.isNotEmpty) {
          Get.to(() => AddPlayerBirthday(), arguments: Get.arguments);
        }
        else {
          EasyLoading.showError("Please fill in the information !");
        }
      },
      child: GetBuilder<CheckInLogic>(
        id: "editNextBtn",
        builder: (logic) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff13EFEF),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            margin: EdgeInsets.only(top: 0.0, left: 0.0),
            constraints: BoxConstraints.tightFor(width: width * 0.8, height: 80.h),
            child: Center(
              child: Text(
                "NEXT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.sp,
                  decoration: TextDecoration.none,
                  fontFamily: 'BurbankBold',
                  color: Color(0xff000000),
                  letterSpacing: 3.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 跳过
class _SkipButton extends StatelessWidget {
  _SkipButton({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  final testTabId = Global.tableId;
  get checkInApi => CheckInApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        Map<String, dynamic> skipUserInfo = await checkInApi.addSkipPlayer();
        // print("跳过后的返回 $skipUserInfo");
        print("跳过后的返回 ${Get.arguments}");
        // 加入到show
        await checkInApi.addPlayerToShow(Get.arguments.showId, Global.tableId, skipUserInfo['userId']);
        // print("跳过后的返回 ${skipUserInfo['userId']}");
        // print("跳过后的返回 ${Get.arguments.showId}");
        // print("跳过后的返回 ${logic.showState}");
        Map<String, dynamic> jsonObj = {
          "userId": skipUserInfo['userId'],
          "showId": Get.arguments.showId,
          "status": Get.arguments.status.toString()
        };
        // 延迟调用爆宝箱
        Future.delayed(2.seconds).then((value) {
          logic.explosiveChestFun(logic.consumerId);
        }).onError((error, stackTrace) async {
          print("error爆宝箱 $error");
        });
        Get.to(() => TreasureChestPage(), arguments: jsonObj);

        // print("Get.isRegistered<SetAvatarLogic>() ${Get.isRegistered<SetAvatarLogic>()}");
        // if(Get.isRegistered<SetAvatarLogic>()) {
        //   Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
        //   Get.find<SetAvatarLogic>().updatePlayer(skipUserInfo['userId'].toString());
        // }
        // await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
      },
      child: GetBuilder<CheckInLogic>(
        id: "skipBtn",
        builder: (logic) {
          return Container(
            decoration: BoxDecoration(
              //设置边框
              border: new Border.all(color: Color(0xff5A5858), width: 1),
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            margin: EdgeInsets.only(top: 0.0, left: 30.0),
            constraints: BoxConstraints.tightFor(width: 0.08.sw, height: 80.h), //卡片大小
            child: Center(
              child: Text(
                "Skip",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.sp,
                  decoration: TextDecoration.none,
                  fontFamily: 'BurbankBold',
                  color: Color(0xffFFFFFF),
                  letterSpacing: 3.sp,
                ),
              ),
            ),
          );
        },
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
        Get.to(() => PlayerInfoShow(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "backBtn",
        builder: (logic) {
          return Text(
            "Back",
            style: TextStyle(
              fontSize: 35.sp,
              decoration: TextDecoration.none,
              fontFamily: 'BurbankBold',
              color: Color(0xff13EFEF),
              letterSpacing: 3.sp,
            ),
          );
        },
      ),
    );
  }
}
