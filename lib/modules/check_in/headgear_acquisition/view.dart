import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';
import 'package:intl/intl.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../set_avatar/logic.dart';
import '../../set_avatar/view.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../player_page/view.dart';
import 'logic.dart';

// class HeadgearAcquisitionPage extends StatefulWidget {
//   HeadgearAcquisitionPage({
//     Key? key,
//     required this.showInfo,
//     required this.customer,
//     required this.headgearObj,
//     required this.userId,
//   }) : super(key: key);
//
//   final ShowInfo showInfo;
//   final Customer customer;
//   final Map headgearObj;
//   final int userId;
//
//   @override
//   _HeadgearAcquisitionPageState createState() => _HeadgearAcquisitionPageState();
// }
//
// class _HeadgearAcquisitionPageState extends State<HeadgearAcquisitionPage> {
//   late final ShowInfo showInfo;
//   late final Customer customer;
//   late final Map headgearObj;
//   late final int userId;
//
//   @override
//   void initState() {
//     super.initState();
//     showInfo = widget.showInfo;
//     customer = widget.customer;
//     headgearObj = widget.headgearObj;
//     userId = widget.userId;
//     // 打印参数值
//     print("showInfo: $showInfo");
//     print("customer: $customer");
//     print("headgearObj: $headgearObj");
//     print("userId: $userId");
//   }
//
//   @override
//   void didUpdateWidget(covariant HeadgearAcquisitionPage oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.showInfo != oldWidget.showInfo ||
//         widget.customer != oldWidget.customer ||
//         widget.headgearObj != oldWidget.headgearObj ||
//         widget.userId != oldWidget.userId) {
//       setState(() {
//         showInfo = widget.showInfo;
//         customer = widget.customer;
//         headgearObj = widget.headgearObj;
//         userId = widget.userId;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final logic = Get.put(HeadgearAcquisitionLogic());
//     return Scaffold(
//         body: Stack(
//           children: [
//             GetBuilder<HeadgearAcquisitionLogic>(
//                 id: "headgearAcquisitionPage",
//                 builder: (logic) {
//                   return _TreasureChestWidget(showInfo: showInfo, customer: customer, headgearObj: headgearObj, userId: userId);
//                 }
//             ),
//           ],
//         ));
//   }
// }

class HeadgearAcquisitionPage extends StatelessWidget {
  HeadgearAcquisitionPage({
    Key? key,
    // required this.showInfo,
    // required this.customer,
    // required this.headgearObj,
    // required this.userId,
  }) : super(key: key);
  // final ShowInfo showInfo;
  // final Customer customer;
  // final Map headgearObj;
  // final int userId;

  final logic = Get.put(HeadgearAcquisitionLogic());

  @override
  Widget build(BuildContext context) {
    // print("showInfo ${showInfo}");
    // print("customer ${customer}");
    // print("headgearObj ${headgearObj}");
    // print("userId ${userId}");
    // // 手动更新参数值
    // logic.updateParameters(showInfo, customer, headgearObj, userId);
    return Scaffold(
        body: Stack(
          children: [
            GetBuilder<HeadgearAcquisitionLogic>(
                id: "headgearAcquisitionPage",
                builder: (logic) {
                  // return _TreasureChestWidget(showInfo: showInfo, customer: customer, headgearObj: headgearObj, userId: userId);
                  return _TreasureChestWidget(
                    showInfo: logic.showInfo,
                    customer: logic.customer,
                    headgearObj: logic.headgearObj,
                    userId: logic.userId,
                  );
                }
            ),
          ],
        ));
  }
}

//宝箱图
class _TreasureChestWidget extends StatelessWidget {
  _TreasureChestWidget({
    Key? key,
    required this.showInfo,
    required this.customer,
    required this.headgearObj,
    required this.userId,
  }) : super(key: key);
  final ShowInfo showInfo;
  final Customer customer;
  final Map headgearObj;
  final int userId;
  final logic = Get.find<HeadgearAcquisitionLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      height: 1.0.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // 顶部文本信息
          // CheckInTitlePage(titleText: "Welcome Chest"),
          Align(
            alignment: const Alignment(-0.6, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  "Welcome Package",
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                ),
                SizedBox(height: 10,),
                Text(
                  "Click to flip the cards, exploring your gift pack",
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                ),
              ],
            ),
          ),
          FlipCard(headgearObj: headgearObj),
          SizedBox(height: 50,),
          if(logic.isClickCard) _NextButton(width: 600.w, showInfo: showInfo, customer: customer, userId: userId,),
        ],
      ),
    );
  }
}

class FlipCard extends StatefulWidget {
  FlipCard({required this.headgearObj});
  final Map headgearObj;

  @override
  _FlipCardState createState() => _FlipCardState();
}
class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  final logic = Get.find<HeadgearAcquisitionLogic>();

  bool _isFrontVisible = true;
  bool _isChangingCardFace = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
          _isChangingCardFace = true;
        });
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        setState(() {
          _isChangingCardFace = false;
          _isFrontVisible = !_isFrontVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flipCard() {
    logic.updateHeadgearPageFun();
    if (_animationController.isAnimating) {
      return;
    }
    if (_isFrontVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final headgearObj = widget.headgearObj;

    return SizedBox(
      width: 1.0.sw,
      height: 0.6.sh,
      child: GestureDetector(
        onTap: _flipCard,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final rotationValue = _rotationAnimation.value;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(rotationValue * pi)
                ..scale(_isFrontVisible ? 1.0 : -1.0, 1.0, 1.0),
                // ..scale(-1.0, 1.0, 1.0), // 添加scale进行水平翻转
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 0.1.sh),
                child: _isFrontVisible || _isChangingCardFace
                    ? Image.asset(
                  Global.getSetAvatarImageUrl('pageage_icon.png'),
                  fit: BoxFit.contain,
                )
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                Global.getSetAvatarImageUrl('card_bg.png')),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 50.0, left: 10,),
                              child: CachedNetworkImage(
                                height: 240,
                                imageUrl: "$baseStrapiUrl${headgearObj['itemInfo']['icon']}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 90),
                            Text(
                              headgearObj['itemInfo']['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyles.notice(
                                color: Color(0xFF000000),
                                fontSize: 24.sp,
                              ),
                            ),
                          ],
                        ),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  _NextButton({
    Key? key,
    required this.width,
    required this.showInfo,
    required this.customer,
    required this.userId,
  }) : super(key: key);
  final double width;
  final ShowInfo showInfo;
  final Customer customer;
  final int userId;
  final testTabId = Global.tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        // Get.offAll(() => PlayerInfoShow(showInfo: showInfo, customer: customer,), arguments: showInfo);
        Map<String, dynamic> jsonObj = {
          "userId": userId,
          "showId": showInfo.showId,
          // "status": showInfo.status.toString()
        };
        print("用于传递的参数: ${jsonObj}");
        print("Get.isRegistered<SetAvatarLogic>() ${Get.isRegistered<SetAvatarLogic>()}");
        if(Get.isRegistered<SetAvatarLogic>()) {
          Get.find<SetAvatarLogic>().updateUserList(showInfo.showId);
          await Future.delayed(100.ms);
          Get.find<SetAvatarLogic>().updatePlayer(userId.toString());
          await Future.delayed(100.ms);
          Get.find<SetAvatarLogic>().explosiveChestFun(userId);
        }
        // await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
        Get.offAll(() => AvatarDesignPage(showInfo: showInfo, customer: customer,), arguments: jsonObj);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width * 0.8, height: 80.h),
        child: Center(
          child: Text(
            "Let's Start!",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}