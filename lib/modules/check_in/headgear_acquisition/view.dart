import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../data/user_info.dart';
import '../player_page/new_player_page.dart';
import 'flip_card.dart';
import 'logic.dart';
import 'package:audioplayers/audioplayers.dart';

class HeadgearAcquisitionPage extends StatelessWidget {
  HeadgearAcquisitionPage({
    Key? key,
  }) : super(key: key);
  final logic = Get.put(HeadgearAcquisitionLogic());

  @override
  Widget build(BuildContext context) {
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
                }),
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
  final List headgearObj;
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
      child: _CardFlip(headgearObj: headgearObj),
    );
  }
}

class _CardFlip extends StatefulWidget {
  _CardFlip({Key? key, required this.headgearObj});
  final List headgearObj;
  @override
  _CardFlipState createState() => _CardFlipState();
}

class _CardFlipState extends State<_CardFlip> {
  final logic = Get.find<HeadgearAcquisitionLogic>();
  int? selectIndex;
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get userId => Get.arguments["userId"];
  int get tableId => Get.arguments["tableId"];

  // 创建音频播放器实例
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   width: 0.9.sw,
        //   margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Welcome Package",
        //         style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
        //       ),
        //       SizedBox(height: 10,),
        //       // Text(
        //       //   !logic.isClickCard
        //       //       ? "These exciting headwears options for your upcoming adventures."
        //       //       : "Gear Up for Glory! Choose Your Winning Headgear.",
        //       //   style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
        //       // ),
        //       Text(
        //         "Gear Up for Glory! Choose Your Winning Headgear.",
        //         style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 40.0),
          constraints: BoxConstraints.tightFor(width: (1.0.sw - 40)), //卡片大小
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  // "Welcome Package",
                  "Hi," + logic.playerName,
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Gear Up for Glory! Choose Your Winning Headgear.",
                  style: CustomTextStyles.textSmall(
                    color: Color(0xFFFFFFFF),
                    fontSize: 26.sp,
                  ),
                ),
                // child: Text(
                //   !logic.isClickCard
                //       ? "Gear Up for Glory! Choose Your Winning Headgear."
                //       : ("Hi," + logic.playerName + ", Choose Your Winning Headgear."),
                //   style: CustomTextStyles.textSmall(
                //     color: Color(0xFFFFFFFF),
                //     fontSize: 26.sp,
                //   ),
                // ),
              ),
            ],
          ),
        ),
        Container(
          width: 0.84.sw,
          margin: EdgeInsets.only(top: 0.1.sh, left: 0.08.sw, right: 0.08.sw),
          child: Row(
            children: List.generate(widget.headgearObj.length, (index) {
              return GestureDetector(
                onTapUp: (details) async {
                  await audioPlayer.release;
                  logic.clickSelectId = widget.headgearObj[index].id;
                  UserInfo userData = await logic.getCurrentUser(showInfo.showId, tableId, userId);
                  setState(() {
                    selectIndex = index;
                    logic.playerName = userData.nickname;
                    logic.isClickCard = true;
                  });
                  print("logic.clickSelectId ${logic.clickSelectId}");
                  // Future.delayed(0.5.seconds).then((value) async {
                  //   Get.offAll(() => NewPlayerPage(),
                  //       arguments: {
                  //         "userId": userId,
                  //         "headgearId": logic.clickSelectId,
                  //         "showInfo": showInfo,
                  //         "customer": customer,
                  //         "isAddPlayerClick": isAddPlayerClick,
                  //         "tableId": tableId,
                  //       });
                  // });
                },
                onTapDown: (details) async {
                  await audioPlayer.play(AssetSource(MirraIcons.getSoundEffectsCheckPath("card.wav")));
                },
                onTapCancel: () async {
                  await audioPlayer.release;
                },
                child: Container(
                  margin: EdgeInsets.only(right: index != widget.headgearObj.length - 1 ? 10 : 0),
                  child: HeadgearFlipCard(
                      width: (0.84.sw / 5) - ((10 * 4) / 5),
                      tableId: tableId,
                      url: widget.headgearObj[index].icon,
                      level: widget.headgearObj[index].level + 2,
                      bSelected: selectIndex == index ? true : false,
                      delay: Duration(milliseconds: 500 * index)),
                ),
              );
            }),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        // if (logic.isClickCard) _NextButton(width: 600.w),
        if (logic.isClickCard) CommonButton(
                                  width: 600.w,
                                  height: 100.h,
                                  btnText: 'NEXT',
                                  btnBgColor: Color(0xff13EFEF),
                                  textColor: Colors.black,
                                  onPress: () async {
                                    if (logic.clickSelectId != null && logic.isClickCard) {
                                      try {
                                        EasyLoading.dismiss(animation: false);
                                        UserInfo userData = await logic.getCurrentUser(showInfo.showId, tableId, userId);
                                        Get.offAll(() => NewPlayerPage(), arguments: {
                                          "userId": userId,
                                          "headgearId": logic.clickSelectId,
                                          "showInfo": showInfo,
                                          "customer": customer,
                                          "isAddPlayerClick": isAddPlayerClick,
                                          "tableId": tableId,
                                          "userData": userData,
                                        });
                                      } on DioException catch (e) {
                                        EasyLoading.dismiss();
                                        if (e.response == null) EasyLoading.showError("Network Error!");
                                        EasyLoading.showError(e.response?.data["error"]["message"]);
                                      }
                                    }
                                  },
                                  disable: logic.clickSelectId != null ? false : true,
                                  changedBgColor: Color(0xffA4EDF1),
                                ),
      ],
    );
  }
}

// class CardFlipAnimation extends StatefulWidget {
//   CardFlipAnimation({required this.headgearObj});
//   final List headgearObj;
//   @override
//   _CardFlipAnimationState createState() => _CardFlipAnimationState();
// }
//
// class _CardFlipAnimationState extends State<CardFlipAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _rotationAnimation;
//   bool _isFrontVisible = true;
//   bool _isChangingCardFace = false;
//   int currentIndex = 0;
//   Color get color {
//     if (tableId == 1) {
//       // background: #FFBD80;
//       return const Color(0xFFFFBD80);
//     } else if (tableId == 2) {
//       // background: #EFB5FD;
//       return const Color(0xFFEFB5FD);
//     } else if (tableId == 3) {
//       // background: #8EE8BD;
//       return const Color(0xFF8EE8BD);
//     } else {
//       // background: #9ED7F7;
//       return const Color(0xFF9ED7F7);
//     }
//   }
//   // 浅色
//   Color get lightColor {
//     if (tableId == 1) {
//       return const Color(0xFFE6BC9C);
//     } else if (tableId == 2) {
//       return const Color(0xFFE8B6E0);
//     } else if (tableId == 3) {
//       return const Color(0xFFBCDBBC);
//     } else {
//       return const Color(0xFFC5D4E6);
//     }
//   }
//   // 深色
//   Color get darkColor {
//     if (tableId == 1) {
//       return const Color(0xFFCB8C5E);
//     } else if (tableId == 2) {
//       return const Color(0xFFBB7EB1);
//     } else if (tableId == 3) {
//       return const Color(0xFF81AE81);
//     } else {
//       return const Color(0xFF85AEDE);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // beforeStartCardFlipping();
//     startCardFlipping();
//
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 1000),
//       // duration: Duration(milliseconds: (currentIndex + 1) * 1000),
//       vsync: this,
//     );
//
//     _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.forward) {
//         setState(() {
//           _isChangingCardFace = true;
//         });
//       } else if (status == AnimationStatus.completed ||
//           status == AnimationStatus.dismissed) {
//         setState(() {
//           _isChangingCardFace = false;
//           _isFrontVisible = !_isFrontVisible;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   // void beforeStartCardFlipping() {
//   //   print("widget.headgearObj ${widget.headgearObj}");
//   //   for (int i = 0; i < widget.headgearObj.length; i++) {
//   //     widget.headgearObj[i]["isCardFlipped"] = false;
//   //     // widget.headgearObj[i]["isFrontVisible"] = true;
//   //     // widget.headgearObj[i]["isChangingCardFace"] = false;
//   //   }
//   //   print("widget.headgearObj ${widget.headgearObj}");
//   //   startCardFlipping();
//   // }
//
//   void startCardFlipping() {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         print('Current time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}');
//         print('widget.headgearObj: ${widget.headgearObj}');
//         if(!widget.headgearObj[currentIndex].isCardFlipped) {
//           // if(!_isFrontVisible) {
//           //   _isFrontVisible = true;
//           // }
//           // if(_isChangingCardFace) {
//           //   _isChangingCardFace = false;
//           // }
//           _flipCard(currentIndex);
//           widget.headgearObj[currentIndex].isCardFlipped = !widget.headgearObj[currentIndex].isCardFlipped;
//         }
//
//         // if(widget.headgearObj[currentIndex].isCardFlipped) {
//         //   print("开始翻转: ${currentIndex}");
//         //   _flipCard();
//         // }
//         currentIndex++;
//         if (currentIndex >= 5) {
//           timer.cancel();
//         }
//       });
//     });
//   }
//
//   void _flipCard(int num) {
//     print("开始翻转: ${num}");
//     print("_isFrontVisible: ${_isFrontVisible }");
//     print("_isChangingCardFace: ${_isChangingCardFace}");
//     print("对象数据: ${widget.headgearObj[num].isCardFlipped}");
//     if (_animationController.isAnimating) {
//       print("_animationController.isAnimating");
//       return;
//     }
//     if(!widget.headgearObj[num].isCardFlipped) {
//       print("需要翻转的");
//       // if (_isFrontVisible || widget.headgearObj[num].isCardFlipped) {
//       if (_isFrontVisible) {
//         print("+++ forward +++");
//         _animationController.forward();
//       } else {
//         print("--- reverse ---");
//         _animationController.reverse();
//       }
//     }
//   }
//
//   final logic = Get.find<HeadgearAcquisitionLogic>();
//   int? selectIndex;
//   ShowInfo get showInfo => Get.arguments["showInfo"];
//   Customer get customer => Get.arguments["customer"];
//   bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
//   int get userId => Get.arguments["userId"];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 0.84.sw,
//       margin: EdgeInsets.only(top: 0.1.sh, left: 0.08.sw, right: 0.08.sw),
//       child: Row(
//         children: List.generate(widget.headgearObj.length, (index) {
//           // print("index ${index != widget.headgearObj.length - 1}");
//           // print("index ${widget.headgearObj[index].isCardFlipped}");
//           // print("index ${widget.headgearObj[index]}");
//           // print("是否翻面展示1: ${_isFrontVisible }");
//           // print("是否翻面展示2: ${_isChangingCardFace}");
//           // print("是否翻面展示3: ${!widget.headgearObj[index].isCardFlipped}");
//           return GestureDetector(
//             // onTap: _flipCard,
//             onTap: () async {
//               logic.clickSelectId = widget.headgearObj[index].id;
//               setState(() {
//                 selectIndex = index;
//               });
//               print("logic.clickSelectId ${logic.clickSelectId}");
//               Future.delayed(0.5.seconds).then((value) async {
//                 Get.offAll(() => NewPlayerPage(), arguments: {"userId": userId, "headgearId": logic.clickSelectId, "showInfo": showInfo, "customer": customer, "isAddPlayerClick": isAddPlayerClick,});
//               });
//             },
//             child: AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 final rotationValue = _rotationAnimation.value;
//                 return Transform(
//                   transform: Matrix4.identity()
//                   ..setEntry(3, 2, 0.001)
//                   ..rotateY(rotationValue * pi)
//                   // ..scale(_isFrontVisible && !widget.headgearObj[index].isCardFlipped ? 1.0 : -1.0, 1.0, 1.0),
//                     ..scale(_isFrontVisible ? 1.0 : -1.0, 1.0, 1.0),
//                   alignment: Alignment.center,
//                   child: Container(
//                     width: (0.84.sw / 5) - ((10 * 4) / 5),
//                     height: ((0.84.sw / 5) - ((10 * 4) / 5)) / 0.659,
//                     margin: EdgeInsets.only(right: index != widget.headgearObj.length - 1 ? 10 : 0),
//                     // child: (_isFrontVisible || _isChangingCardFace) && (!widget.headgearObj[index].isCardFlipped)
//                     child: (_isFrontVisible || _isChangingCardFace)
//                         ? Image.asset(
//                           MirraIcons.getSetAvatarIconPath('pageage_icon.png'),
//                           fit: BoxFit.contain,
//                         )
//                         : Container(
//                             decoration: selectIndex == null ?
//                               BoxDecoration(
//                                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                                 gradient: RadialGradient(
//                                   center: Alignment.center,
//                                   radius: 0.5,
//                                   colors: [
//                                     lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
//                                     darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
//                                   ],
//                                 ),
//                               ) : ((selectIndex == index) ?
//                                     BoxDecoration(
//                                       color: Color(0xFF13EFEF),
//                                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                                     ) : BoxDecoration(
//                                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                                           gradient: RadialGradient(
//                                             center: Alignment.center,
//                                             radius: 0.5,
//                                             colors: [
//                                               lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
//                                               darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
//                                             ],
//                                           ),
//                                         )),
//                             // BoxDecoration(
//                             //   // image: DecorationImage(
//                             //   //   image: AssetImage(
//                             //   //       Global.getSetAvatarImageUrl('card_bg.png')),
//                             //   //   fit: BoxFit.contain,
//                             //   // ),
//                             //   // color: color,
//                             //   borderRadius: BorderRadius.all(Radius.circular(10)),
//                             //   gradient: RadialGradient(
//                             //     center: Alignment.center,
//                             //     radius: 0.5,
//                             //     colors: selectIndex == null ? [
//                             //       lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
//                             //       darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
//                             //     ] : (selectIndex == index ? [
//                             //       Color(0xFF13EFEF).withOpacity(1.0), // 设置渐变起始颜色并设置透明度
//                             //       Color(0xFF13EFEF).withOpacity(1.0),
//                             //     ] : [
//                             //       Color(0xFFE6BC9C).withOpacity(1.0), // 设置渐变起始颜色并设置透明度
//                             //       Color(0xFFCB8C5E).withOpacity(1.0), // 设置渐变结束颜色并设置透明度
//                             //     ]),
//                             //   ),
//                             // ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(top: 40.0),
//                                   child: CachedNetworkImage(
//                                     height: 200,
//                                     imageUrl: widget.headgearObj[index].icon,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 // Container(
//                                 //   child: Row(
//                                 //     mainAxisAlignment: MainAxisAlignment.center,
//                                 //     children: List.generate(index + 1, (i) {
//                                 //       return Padding(
//                                 //         padding: EdgeInsets.symmetric(horizontal: 2), // 设置左右间距
//                                 //         child: Image.asset(
//                                 //           MirraIcons.getSetAvatarIconPath('level_star_icon.png'),
//                                 //           fit: BoxFit.contain,
//                                 //           width: 32,
//                                 //         ),
//                                 //       );
//                                 //     }),
//                                 //   ),
//                                 // ),
//                                 SizedBox(height: 15,),
//                                 Container(
//                                   height: 4.0,
//                                   color: Colors.white,
//                                 ),
//                                 // SizedBox(height: 15,),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(10.0),
//                                       bottomRight: Radius.circular(10.0),
//                                     ),
//                                     color: selectIndex == null ? color : (selectIndex == index ? Color(0xFF13EFEF) : color),
//                                   ),
//                                   height: (((0.84.sw / 5) - ((10 * 4) / 5)) / 0.659) - (30 + 180 + 32 + 15 + 2),
//                                   // child: Align(
//                                   //   alignment: Alignment.center,
//                                   //   child: Text(
//                                   //     widget.headgearObj[index]['gameItem']['name'],
//                                   //     maxLines: 1,
//                                   //     overflow: TextOverflow.ellipsis,
//                                   //     style: CustomTextStyles.notice(
//                                   //       color: Color(0xFF000000),
//                                   //       fontSize: 24.sp,
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: List.generate(index + 1, (i) {
//                                       return Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: 2), // 设置左右间距
//                                         child: Image.asset(
//                                           MirraIcons.getSetAvatarIconPath('level_star_icon.png'),
//                                           fit: BoxFit.contain,
//                                           width: 32,
//                                         ),
//                                       );
//                                     }),
//                                   ),
//                                 )
//                               ],
//                             ),
//                         ),
//                   ),
//                 );
//               },
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

class _NextButton extends StatelessWidget {
  _NextButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get userId => Get.arguments["userId"];
  int get tableId => Get.arguments["tableId"];
  final logic = Get.find<HeadgearAcquisitionLogic>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        if (logic.clickSelectId != null && logic.isClickCard) {
          try {
            EasyLoading.dismiss(animation: false);
            UserInfo userData = await logic.getCurrentUser(showInfo.showId, tableId, userId);
            Get.offAll(() => NewPlayerPage(), arguments: {
              "userId": userId,
              "headgearId": logic.clickSelectId,
              "showInfo": showInfo,
              "customer": customer,
              "isAddPlayerClick": isAddPlayerClick,
              "tableId": tableId,
              "userData": userData,
            });
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: (logic.clickSelectId != null && logic.isClickCard) ? Color(0xff13EFEF) : Color(0xff9B9B9B),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h),
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
