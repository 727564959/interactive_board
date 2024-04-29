import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../mirra_style.dart';
import '../add_player/view.dart';
import '../choose_table/view.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../verification_code/logic.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({
    Key? key,
    required this.isAddPlayerClick,
    required this.showInfo,
    required this.customer,
  }) : super(key: key);
  final bool isAddPlayerClick;
  final ShowInfo showInfo;
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    print("147258 ${isAddPlayerClick}");
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: 1.0.sw,
          height: 1.0.sh,
          color: Color(0xFF233342),
          child: Column(
            children: [
              SizedBox(
                width: 1.0.sw,
                height: 0.15.sh,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 120.0),
                      child: SizedBox(
                        width: 0.24.sw,
                        child: Text(
                          "Term of Use",
                          style: TextStyle(
                            fontSize: 60.sp,
                            decoration: TextDecoration.none,
                            fontFamily: 'BurbankBold',
                            color: Colors.white,
                            letterSpacing: 3.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDBE2E3),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      margin: EdgeInsets.only(top: 0.0, left: 120.0),
                      constraints: BoxConstraints.tightFor(width: 0.8.sw, height: 0.6.sh), //卡片大小
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20.0),
                        children: <Widget>[
                          // Container(
                          //   margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                          //   child: Text('Welcome to Mirra game show, an exciting and immersive gaming experience, By accessing or using our game, you agree to abide by the following terms and conditions.',
                          //     style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.deepOrange, letterSpacing: 3.sp,),
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Text(
                              '1. Acceptance of Terms',
                              // style: TextStyle(fontSize: 35.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                              style: CustomTextStyles.title(color: Colors.black, fontSize: 28.sp, level: 6),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: Text(
                              'At the game center, we are committed to providing a unique and immersive game experience for all our guests. We strive to create a safe and enjoyable environment for everyone to enjoy our games and activities. However, it is essential to understand that there are inherent risks associated with virtual reality games, and we require all guests to acknowledge and accept these risks before participating.',
                              style: CustomTextStyles.notice(color: Color(0xFF9B9B9B), fontSize: 24.sp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Text(
                              '2. User Conduct',
                              style: CustomTextStyles.title(color: Colors.black, fontSize: 28.sp, level: 6),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: Text(
                              'You agree to use [Game Name] for lawful purposes and in a manner consistent with all applicable laws and regulations. You will not engage in any conduct that may disrupt the experience of other users or compromise the security and integrity of the game.',
                              style: CustomTextStyles.notice(color: Color(0xFF9B9B9B), fontSize: 24.sp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Text(
                              '3. Intellectual Property',
                              style: CustomTextStyles.title(color: Colors.black, fontSize: 28.sp, level: 6),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: Text(
                              'In addition, virtual reality games involve physical movement and interaction with objects and other players. This can increase the risk of injury or accidents, such as collisions or falls. We ask that all guests follow our safety guidelines and instructions from our staff to minimize these risks.',
                              style: CustomTextStyles.notice(color: Color(0xFF9B9B9B), fontSize: 24.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _AgreeButton(width: 600.w, isAddPlayerClick: isAddPlayerClick, showInfo: showInfo, customer: customer),
              SizedBox(height: 20),
              _BackButton(),
            ],
          ),
        ),
      ],
    ));
  }
}

// 同意条款的按钮
class _AgreeButton extends StatelessWidget {
  _AgreeButton(
      {Key? key, required this.width, required this.isAddPlayerClick, required this.showInfo, required this.customer})
      : super(key: key);
  final double width;
  final bool isAddPlayerClick;
  final ShowInfo showInfo;
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("接受了协议");
        print("object ${isAddPlayerClick}");
        // 是新增点击则去新增页面，反之去选桌
        if (isAddPlayerClick) {
          // Get.offAll(() => AddPlayerPage(showInfo: showInfo, customer: customer));
          Get.to(() => AddPlayerPage(showInfo: showInfo, customer: customer));
        } else {
          EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
          try {
            EasyLoading.dismiss(animation: false);
            await Get.offAll(() => ChooseTablePage(), arguments: {"showInfo": showInfo, "customer": customer});
            WidgetsBinding.instance.addPostFrameCallback((d) => Get.back());
            if (Get.isRegistered<VerificationCodeLogic>()) {
              Get.find<VerificationCodeLogic>()?.codeController?.clear();
            }
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }
        }
        // 初次等级到选桌，反之到添加玩家
        // logic.isFirstCheckIn ? Get.to(() => GroupSettingPage(), arguments: Get.arguments) : Get.to(() => AddPlayerInfo(), arguments: Get.arguments);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h),
        child: Center(
          child: Text(
            "AGREE",
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
