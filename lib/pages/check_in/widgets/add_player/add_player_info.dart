import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common.dart';
import '../../data/checkIn_api.dart';
import '../../logic.dart';
import '../avatar_design_new.dart';
import '../update_currentTime.dart';
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
                          _SetAvatarTitle(),
                          // 中间的用户信息填报
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

// class AddPlayerInfo extends StatefulWidget {
//   AddPlayerInfo({Key? key}) : super(key: key);
//
//   final logic = Get.find<CheckInLogic>();
//
//   // @override
//   // _TextFieldDemoState createState() => _TextFieldDemoState();
//   // @override
//   // _AddPlayerInfoState createState() => _AddPlayerInfoState();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: GetBuilder<CheckInLogic>(
//         id: "addPlayerInfoPage",
//         builder: (logic) {
//           return Container(
//             width: 1.0.sw,
//             height: 1.0.sh,
//             color: Colors.black,
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: 1.0.sw,
//                   child: GetBuilder<CheckInLogic>(
//                     builder: (logic) {
//                       return Column(
//                         children: [
//                           // 顶部文本信息
//                           _SetAvatarTitle(),
//                           // 中间的用户信息填报
//                           // _ValuePageState(),
//                           // 底部按钮区域
//                           // _BottomBtns(),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// 顶部的文本信息
class _SetAvatarTitle extends StatelessWidget {
  const _SetAvatarTitle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("12345 ${DateTime.now().toString().substring(0, 19)}");
    final String dateTime = DateTime.now().toString().substring(11, 16);
    final content = SizedBox(
      width: 0.94.sw,
      height: 100.h,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: const Alignment(0.5, 1.5),
                child: SizedBox(
                  width: 0.2.sw,
                  child: Text(
                    "Set Avatar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp,
                      decoration: TextDecoration.none,
                      fontFamily: 'BurbankBold',
                      color: Colors.white,
                      letterSpacing: 3.sp,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.5, 1.5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.15.sw,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 0.0.sw),
                            child: SizedBox(
                              width: 0.08.sw,
                              child: KmTimer(),
                              // child: Text(
                              //   "09:56",
                              //   style: TextStyle(
                              //     fontSize: 32.sp,
                              //     decoration: TextDecoration.none,
                              //     fontFamily: 'BurbankBold',
                              //     color: Colors.white,
                              //     letterSpacing: 3.sp,
                              //   ),
                              // ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 0.0),
                            child: SizedBox(
                              width: 0.07.sw,
                              child: Text(
                                "Table " + Global.tableId.toString(),
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BurbankBold',
                                  color: Colors.deepOrange,
                                  letterSpacing: 3.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
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
    return content;
  }
}
// 中间的用户信息录入
class _PlayerForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.0.sw,
      height: 0.65.sh,
      child: GetBuilder<CheckInLogic>(
          builder: (logic) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.grey,
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      // ),
                      margin: EdgeInsets.only(top: 60.0, left: 120.0),
                      constraints: BoxConstraints.tightFor(width: 750.w, height: 240.h),//卡片大小
                      // alignment: Alignment.center, //卡片内文字居中
                      child: Column(
                        children: [
                          Align(
                            heightFactor: 3,
                            alignment: const Alignment(-0.8, 0.0),
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
                            height: 100.h,
                            child: Scaffold(
                              body: Stack(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "",
                                      // fillColor: Colors.red,
                                    ),
                                    onChanged: (v) {
                                      print("onChange: $v");
                                      logic.firstName = v;
                                    },
                                    style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                  ),
                                ]
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60.0, left: 10.0),
                      constraints: BoxConstraints.tightFor(width: 750.w, height: 240.h),//卡片大小
                      alignment: Alignment.center, //卡片内文字居中
                      child: Column(
                        children: [
                          Align(
                            heightFactor: 3,
                            alignment: const Alignment(-0.8, 0.0),
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
                            height: 100.h,
                            child: Scaffold(
                                body: Stack(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: "",
                                        ),
                                        onChanged: (v) {
                                          print("onChange: $v");
                                          logic.lastName = v;
                                        },
                                        style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                      ),
                                    ]
                                )
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
                      // decoration: BoxDecoration(
                      //   color: Colors.grey,
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      // ),
                      margin: EdgeInsets.only(top: 30.0, left: 120.0),
                      constraints: BoxConstraints.tightFor(width: 750.w, height: 240.h),//卡片大小
                      // alignment: Alignment.center, //卡片内文字居中
                      child: Column(
                        children: [
                          Align(
                            heightFactor: 3,
                            alignment: const Alignment(-0.8, 0.0),
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
                            height: 100.h,
                            child: Scaffold(
                                body: Stack(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: "",
                                          suffix: Text('.com'),
                                          suffixStyle: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                        ),
                                        onChanged: (v) {
                                          print("onChange: $v");
                                          logic.email = v + ".com";
                                        },
                                        style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0, left: 10.0),
                      constraints: BoxConstraints.tightFor(width: 750.w, height: 240.h),//卡片大小
                      alignment: Alignment.center, //卡片内文字居中
                      child: Column(
                        children: [
                          Align(
                            heightFactor: 3,
                            alignment: const Alignment(-0.8, 0.0),
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
                            height: 100.h,
                            child: Scaffold(
                                body: Stack(
                                    children: [
                                      // TextField(
                                      //   decoration: InputDecoration(
                                      //     labelText: "",
                                      //
                                      //   ),
                                      //   onChanged: (v) {
                                      //     print("onChange: $v");
                                      //   },
                                      //   style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                      // ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: CountryPickerDropdown(
                                              initialValue: 'in',
                                              itemBuilder: _buildDropdownItem,
                                                onValuePicked: (Country country) {
                                                  print("${country.phoneCode}");
                                                  print("${country.name}");
                                                  logic.countryName = country.phoneCode;
                                                },
                                              ),
                                          ),
                                          Expanded(
                                            child: TextField(
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "",
                                              ),
                                              onChanged: (value) {
                                                // this.phoneNo=value;
                                                print(value);
                                                logic.phone = value;
                                              },
                                              style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
      ),
    );
  }
}
Widget _buildDropdownItem(Country country) => Container(
  child: Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(
        width: 8.0,
      ),
      Text("+${country.phoneCode}(${country.isoCode})"),
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
      constraints: BoxConstraints.tightFor(width: 0.94.sw, height: 200.h),//卡片大小
      alignment: Alignment.center,
      child: Stack(
        children: [
          Column(
            children: [
              _NextButton(width: 800.w),
              _SkipButton(),
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
  String get backgroundUri => Global.getSetAvatarImageUrl("group_setting_input.png");

  final testTabId = Global.tableId;

  get checkInApi => CheckInApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        String testPhone = "+(" + logic.countryName + ")" + logic.phone;
        // String fullName = logic.firstName + "" + logic.lastName;
        await checkInApi.addPlayerFun(
            testTabId, logic.email, testPhone, logic.firstName, logic.lastName);
        logic.userList = await checkInApi.fetchUsers();
        logic.currentNickName = logic.lastName;
        print("${logic.currentNickName}");
        Get.to(() => AddPlayerBirthday(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "editNextBtn",
        builder: (logic) {
          return Container(
            height: width * 0.2,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
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
        logic.userList = await checkInApi.fetchUsers();
        logic.playerNum++;
        logic.currentNickName = "Player" + logic.playerNum.toString();
        print("ppp ${logic.currentNickName}");
        logic.currentUrl = logic.userList[0].avatarUrl;
        logic.isClickSkip = true;
        Get.to(() => AvatarDesignPage(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "skipBtn",
        builder: (logic) {
          return Text(
            "SKIP",
            style: TextStyle(
              fontSize: 35.sp,
              decoration: TextDecoration.none,
              fontFamily: 'BurbankBold',
              color: Colors.cyanAccent,
              letterSpacing: 3.sp,
            ),
          );
        },
      ),
    );
  }
}
// class _TextFieldDemoState extends State<AddPlayerInfo> {
//   String phone = '';
//   String password = '';
//   String description = '';
//
//   _register() {
//     print('phone: $phone'); // phone: 12365412569
//     print('password: $password'); // phone: 12365412569
//     print('description: $description'); // description: srttg tutu edghh
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: ListView(
//         children: [
//           // 手机号
//           TextField(
//             autofocus: true,
//             keyboardType: TextInputType.phone,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.mobile_screen_share),
//               labelText: '手机号',
//               hintText: '请输入手机号',
//               hintStyle: TextStyle(
//                 color: Colors.pink,
//                 fontSize: 14,
//               ),
//               // 聚焦时边框的样式
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Colors.green,
//                 ),
//               ),
//               // 默认边框样式
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Colors.yellow,
//                 ),
//               ),
//             ),
//             maxLength: 11,
//             onChanged: (value) {
//               setState(() {
//                 phone = value;
//               });
//             },
//           ),
//           // 密码
//           TextField(
//             // 隐藏文本
//             obscureText: true,
//             keyboardType: TextInputType.text,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.code_outlined),
//               labelText: '密码',
//               hintText: '请输入密码',
//             ),
//             onChanged: (value) {
//               setState(() {
//                 password = value;
//               });
//             },
//           ),
//           // 文本域
//           TextField(
//             keyboardType: TextInputType.text,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.person),
//               labelText: '简介',
//               hintText: '请简要介绍一下自己',
//             ),
//             maxLines: 3,
//             onChanged: (value) {
//               setState(() {
//                 description = value;
//               });
//             },
//           ),
//           // 按钮
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             child: ElevatedButton(
//               child: const Text('提交'),
//               onPressed: () {
//                 _register();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class _AddPlayerInfoState extends State<AddPlayerInfo> {
//   TextEditingController _nickNameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _phoneNumberController = TextEditingController();
//   GlobalKey _formKey = GlobalKey<FormState>();
//
//   final logic = Get.find<CheckInLogic>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey, //设置globalKey，用于后面获取FormState
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             autofocus: true,
//             controller: _nickNameController,
//             style: TextStyle(
//               color: Colors.white,
//               letterSpacing: 1.3,
//               fontSize: 30.w,
//             ),
//             decoration: InputDecoration(
//               labelText: "Nickname",
//               labelStyle: TextStyle(
//                 color: Colors.white,
//                 letterSpacing: 2,
//                 fontSize: 50.w,
//               ),
//               hintText: "请输入Nickname",
//               // icon: Icon(Icons.person),
//             ),
//             // 校验用户名
//             validator: (v) {
//               return v!.trim().isNotEmpty ? null : "Nickname不能为空";
//             },
//           ),
//           TextFormField(
//             controller: _emailController,
//             style: TextStyle(
//               color: Colors.white,
//               letterSpacing: 1.3,
//               fontSize: 30.w,
//             ),
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               labelText: "Email",
//               labelStyle: TextStyle(
//                 color: Colors.white,
//                 letterSpacing: 2,
//                 fontSize: 50.w,
//               ),
//               hintText: "请输入Email",
//               // icon: Icon(Icons.lock),
//             ),
//             //校验密码
//             // validator: (v) {
//             //   return v!.trim().length > 5 ? null : "密码不能少于6位";
//             // },
//           ),
//           TextFormField(
//             controller: _phoneNumberController,
//             style: TextStyle(
//               color: Colors.white,
//               letterSpacing: 1.3,
//               fontSize: 30.w,
//             ),
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: "Phone number",
//               labelStyle: TextStyle(
//                 color: Colors.white,
//                 letterSpacing: 2,
//                 fontSize: 50.w,
//               ),
//               hintText: "请输入Phone number",
//               // icon: Icon(Icons.lock),
//             ),
//             //校验密码
//             // validator: (v) {
//             //   return v!.trim().length > 10 ? null : "密码不能少于11位";
//             // },
//           ),
//           // 登录按钮
//           Padding(
//             padding: const EdgeInsets.only(top: 28.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: ElevatedButton(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text("Done"),
//                     ),
//                     onPressed: () {
//                       // 通过_formKey.currentState 获取FormState后，
//                       // 调用validate()方法校验用户名密码是否合法，校验
//                       logic.clickDone();
//                       // 通过后再提交数据。
//                       if ((_formKey.currentState as FormState).validate()) {
//                         //验证通过提交数据
//                         // logic.clickAddPlayer();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }