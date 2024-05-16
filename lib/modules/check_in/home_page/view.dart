import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../../../common.dart';
import '../../../mirra_style.dart';

class LandingPage extends StatelessWidget {
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
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // 左侧轮播图部分
              child: CustomSwiper(banner: banner),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // 右侧内容展示部分
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 在垂直方向上居中显示
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                              MirraIcons.getSetAvatarIconPath("mirra_logo.png"),
                              width: 830.w,
                              fit: BoxFit.fitWidth,
                            ),
                  ),
                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                              "CAFE · BAR | PLAY · IMMERSE",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                            ),
                  ),
                  SizedBox(height: 150,),
                  _landingCheckInButton(width: 700.w,),
                  SizedBox(height: 30,),
                  _landingBookNowButton(width: 700.w,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
        return Image.asset(
          MirraIcons.getSetAvatarIconPath('pageage_icon.png'),
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
// 按钮区域
class _landingCheckInButton extends StatelessWidget {
  _landingCheckInButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        if (Get.arguments != null && Get.arguments["tableId"] != null) {
          Get.offAllNamed(AppRoutes.verificationCode, arguments: {"tableId": tableId,});
        }
        else {
          Get.offAllNamed(AppRoutes.verificationCode);
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
            "CHECH IN",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Colors.black, fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}
class _landingBookNowButton extends StatelessWidget {
  _landingBookNowButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffEFB5FD),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h),
        child: Center(
          child: Text(
            "BOOK IN",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Colors.black, fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}