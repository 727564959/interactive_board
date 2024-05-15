import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../data/model/show_state.dart';
import '../../../mirra_style.dart';
import '../add_player/view.dart';

class TermsOfUseInfo extends StatelessWidget {
  const TermsOfUseInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          margin: EdgeInsets.only(top: 40.0, left: 120.0),
                          child: SizedBox(
                            width: 0.24.sw,
                            child: Text(
                              "Term of Use",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
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
                  _AgreeButton(width: 600.w),
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
      {Key? key, required this.width})
      : super(key: key);
  final double width;
  ShowState get showState => Get.arguments["showState"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("接受了协议");
        await Get.to(() => AddPlayerDataPage(),
            arguments: {"showState": showState,});
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
