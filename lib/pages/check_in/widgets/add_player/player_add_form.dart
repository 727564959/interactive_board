import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../data/checkIn_api.dart';
import '../../logic.dart';

class PlayerAddForm extends StatefulWidget {
  @override
  _PlayerAddFormState createState() => _PlayerAddFormState();
}

class _PlayerAddFormState extends State<PlayerAddForm> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.only(top: 100.0, left: 120.0),
                constraints: BoxConstraints.tightFor(width: 750.w, height: 240.h),//卡片大小
                child: Column(
                  children: [
                    Align(
                      heightFactor: 2,
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
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: "",
                      ),
                      // // 校验用户名
                      // validator: (v) {
                      //   return v!.trim().isNotEmpty ? null : "用户名不能为空";
                      // },
                      style: TextStyle(fontSize: 40.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.only(top: 100.0, left: 10.0),
                constraints: BoxConstraints.tightFor(width: 750.w, height: 240.h),//卡片大小
                child: Column(
                  children: [
                    Align(
                      heightFactor: 2,
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
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: "",
                      ),
                      // 校验用户名
                      // validator: (v) {
                      //   return v!.trim().isNotEmpty ? null : "用户名不能为空";
                      // },
                      style: TextStyle(fontSize: 40.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.only(top: 30.0, left: 120.0),
                constraints: BoxConstraints.tightFor(width: 750.w, height: 240.h),//卡片大小
                child: Column(
                  children: [
                    Align(
                      heightFactor: 2,
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
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "",
                      ),
                      // 校验用户名
                      validator: (v) {
                        String regexEmail =
                            "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
                        return new RegExp(regexEmail).hasMatch(v.toString()) ? null : "邮箱格式不争取";
                        // return v!.trim().isNotEmpty ? null : "用户名不能为空";
                      },
                      style: TextStyle(fontSize: 40.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.only(top: 30.0, left: 10.0),
                constraints: BoxConstraints.tightFor(width: 750.w, height: 240.h),//卡片大小
                child: Column(
                  children: [
                    Align(
                      heightFactor: 2,
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
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: "",
                      ),
                      // 校验用户名
                      // validator: (v) {
                      //   return v!.trim().isNotEmpty ? null : "用户名不能为空";
                      // },
                      style: TextStyle(fontSize: 40.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // _NextButton(width: 800.w),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("NEXT"),
                    ),
                    onPressed: () {
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      if ((_formKey.currentState as FormState).validate()) {
                        //验证通过提交数据
                        print("aaaaa $FormState");
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
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

        // Get.to(() => AddPlayerBirthday(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "editNextBtn",
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(top: 0.05.sh),
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