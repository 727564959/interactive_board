import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../logic.dart';

class FormTestRoute extends StatefulWidget {
  FormTestRoute({Key? key}) : super(key: key);
  @override
  _FormTestRouteState createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            controller: _nickNameController,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.3,
              fontSize: 30.w,
            ),
            decoration: InputDecoration(
              labelText: "Nickname",
              labelStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 2,
                fontSize: 50.w,
              ),
              hintText: "请输入Nickname",
              // icon: Icon(Icons.person),
            ),
            // 校验用户名
            validator: (v) {
              return v!.trim().isNotEmpty ? null : "Nickname不能为空";
            },
          ),
          TextFormField(
            controller: _emailController,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.3,
              fontSize: 30.w,
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 2,
                fontSize: 50.w,
              ),
              hintText: "请输入Email",
              // icon: Icon(Icons.lock),
            ),
            //校验密码
            // validator: (v) {
            //   return v!.trim().length > 5 ? null : "密码不能少于6位";
            // },
          ),
          TextFormField(
            controller: _phoneNumberController,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.3,
              fontSize: 30.w,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Phone number",
              labelStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 2,
                fontSize: 50.w,
              ),
              hintText: "请输入Phone number",
              // icon: Icon(Icons.lock),
            ),
            //校验密码
            // validator: (v) {
            //   return v!.trim().length > 10 ? null : "密码不能少于11位";
            // },
          ),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Done"),
                    ),
                    onPressed: () {
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      logic.clickDone();
                      // 通过后再提交数据。
                      if ((_formKey.currentState as FormState).validate()) {
                        //验证通过提交数据
                        // logic.clickAddPlayer();
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