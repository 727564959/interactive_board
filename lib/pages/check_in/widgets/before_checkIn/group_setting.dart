import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../common.dart';
import '../avatar_design_new.dart';

import 'package:card_swiper/card_swiper.dart';

class GroupSettingPage extends StatelessWidget {
  GroupSettingPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();
  List banner = [
    {
      "banner_url":
      "https://ts1.cn.mm.bing.net/th/id/R-C.8e091d0e6a2b9bcb27738cd96e22f699?rik=M4LFAVmmb38W6A&riu=http%3a%2f%2fi3.img.969g.com%2fdown%2fimgx2013%2f01%2f21%2f206_170432_901de.jpg&ehk=564uTBfxvugUBybGO2%2bTpMUNgJEa6rUfSrc1sonLso8%3d&risl=&pid=ImgRaw&r=0"
    },
    {
      "banner_url":
      "https://ts1.cn.mm.bing.net/th/id/R-C.abd4829c9387ec1bfd1a276a5c1da122?rik=dl55Voqxy4wINQ&riu=http%3a%2f%2fi1.073img.com%2f140306%2f4343693_144142_1.jpg&ehk=qvhMjT0iGQT5DhH8MTkAzJqUpjHJRScTQTT5hj%2forLM%3d&risl=&pid=ImgRaw&r=0"
    },
    {
      "banner_url":
      "https://ts1.cn.mm.bing.net/th/id/R-C.ddfbf9ed55354323035f947515fe0233?rik=0KFdFk3RHUzBdg&riu=http%3a%2f%2fi1.img.969g.com%2fdown%2fimgx2013%2f01%2f05%2f206_164916_4fab0.jpg&ehk=Vqb%2f5c3%2fW5n39t7bAae6YpUlfG4ibEbf9lpETY5Xz4c%3d&risl=&pid=ImgRaw&r=0"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(
                    width: 1.0.sw,
                    height: 0.15.sh,
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20.0, left: 120.0),
                              child: SizedBox(
                                width: 0.24.sw,
                                child: Text(
                                  "Group settings",
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
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(top: 20.0, left: 120.0),
                              constraints: BoxConstraints.tightFor(width: 0.4.sw, height: 0.5.sh),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Align(
                                    heightFactor: 5,
                                    alignment: const Alignment(0.0, 0.0),
                                    child: Text(
                                      "Create a Catchy Team Name!",
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 45.sp,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'BurbankBold',
                                        color: Colors.white,
                                        letterSpacing: 3.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: TextField(
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
                                      ),
                                      style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(top: 20.0, left: 10.0),
                              constraints: BoxConstraints.tightFor(width: 0.4.sw, height: 0.5.sh),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Align(
                                    heightFactor: 5,
                                    alignment: const Alignment(0.0, 0.0),
                                    child: Text(
                                      "Pick up a flag",
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 45.sp,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'BurbankBold',
                                        color: Colors.white,
                                        letterSpacing: 3.sp,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(0.0, 0.0),
                                    child: SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: CustomSwiper(
                                        banner: banner,
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _NextDefaultButton(width: 800.w),
                ],
              ),
            ),
            GetBuilder<CheckInLogic>(builder: (logic) {
              return Container();
            }),
          ],
        ));
  }
}
//轮播图的区域
class CustomSwiper extends StatefulWidget {
  const CustomSwiper({super.key, required this.banner});
  final List banner;

  @override
  _CustomSwiperState createState() => _CustomSwiperState();
}

class _CustomSwiperState extends State<CustomSwiper> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        // return Image.network(
        //   widget.banner[index]['banner_url'],
        //   fit: BoxFit.fill,
        // );
        return Image.asset(
          Global.getSetAvatarImageUrl('group_icon.png'),
          fit: BoxFit.fitHeight,
          width: 210.w,
        );
      },
      onTap: (index) {
        print(index);
      },
      itemCount: widget.banner.length,
      // autoplay: true,
      pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              color: Color(0xFFFFFFFF), activeColor: Color(0xFFFF4646))),
      control: SwiperControl(),
    );
  }
}
// 同意条款的按钮
class _NextDefaultButton extends StatelessWidget {
  _NextDefaultButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  // String get backgroundUri => Global.getSetAvatarImageUrl("group_setting_default.png");
  String get backgroundUri => !logic.groupSettingBtnIsInput
      ? Global.getSetAvatarImageUrl("group_setting_default.png")
      : Global.getSetAvatarImageUrl("group_setting_input.png");

  final testTabId = Global.tableId;
  // final testTabId = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("groupsetting");
        logic.isFirstCheckIn = false;
        Get.to(() => AvatarDesignPage(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "groupsettingBtn",
        builder: (logic) {
          return Container(
            height: width * 0.4,
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