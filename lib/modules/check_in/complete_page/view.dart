import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';

import 'package:intl/intl.dart';
import 'package:interactive_board/modules/check_in/data/booking.dart';
import '../../../mirra_style.dart';
import '../../../widgets/custom_countdown.dart';

import 'package:audioplayers/audioplayers.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({Key? key}) : super(key: key);
  int get tableId => Get.arguments["tableId"];
  Customer get customer => Get.arguments["customer"];
  DateTime get startTime => Get.arguments["startTime"];
  Color get color {
    if (tableId == 1) {
      return const Color(0xFFEF7E00);
    } else if (tableId == 2) {
      return const Color(0xFFE11988);
    } else if (tableId == 3) {
      return const Color(0xFF50C68E);
    } else {
      return const Color(0xFF4091F0);
    }
  }

  String get bayString {
    if (tableId == 1) {
      return "A";
    } else if (tableId == 2) {
      return "B";
    } else if (tableId == 3) {
      return "C";
    } else {
      return "D";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(Global.getAssetImageUrl("background.png")),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: Color(0xFF233342),
        child: Center(
          child: Column(
            children: [
              // SizedBox(
              //   width: 1.0.sw,
              //   child: Row(
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               "Successfully Checked in",
              //               style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
              //             ),
              //             const SizedBox(height: 30),
              //             Text(
              //               "Welcome, ${customer.name}!",
              //               style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 3),
              //             ),
              //             RichText(
              //               text: TextSpan(
              //                 text: 'Your Games will start at ',
              //                 style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
              //                 children: <TextSpan>[
              //                   TextSpan(
              //                     text: "${DateFormat('kk:mm').format(startTime.add(8.hours))}",
              //                     style: CustomTextStyles.title(color: color, fontSize: 36.sp, level: 4),
              //                   ),
              //                   TextSpan(
              //                     text:
              //                     ", please be seated by ${DateFormat('kk:mm').format(startTime.add(8.hours - 15.minutes))}, Enjoy!",
              //                     style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
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
                        "Successfully Checked in",
                        style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Welcome, ${customer.name}!",
                        style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 3),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Your Games will start at ',
                        style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                        children: <TextSpan>[
                          TextSpan(
                            // text: "${DateFormat('kk:mm').format(startTime.add(8.hours))}",
                            text: "${DateFormat('kk:mm').format(startTime)}",
                            style: CustomTextStyles.title(color: color, fontSize: 36.sp, level: 4),
                          ),
                          TextSpan(
                            text:
                            // ", please be seated by ${DateFormat('kk:mm').format(startTime.add(8.hours - 15.minutes))}, Enjoy!",
                            ", please be seated by ${DateFormat('kk:mm').format(startTime.subtract(Duration(minutes: 15)))}, Enjoy!",
                            style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 50),
              // const Text(
              //   "Successfully Checked in",
              //   style: TextStyle(fontSize: 50),
              // ),
              // const SizedBox(height: 70),
              // Text(
              //   "Welcome, ${customer.name}! \nYour game start time is "
              //   "${DateFormat('kk:mm').format(startTime.add(8.hours))}, please be seated by "
              //   "${DateFormat('kk:mm').format(startTime.add(8.hours - 15.minutes))}. Enjoy!",
              //   style: const TextStyle(fontSize: 50),
              // ),
              const SizedBox(height: 100),
              Container(
                width: 0.4.sw,
                height: 0.33.sh,
                decoration: BoxDecoration(
                  color: Color(0xFF13EFEF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Your Louge",
                        style: CustomTextStyles.title(color: Colors.black, fontSize: 40.sp, level: 3),
                      ),
                      Text(
                        " Bay $bayString",
                        style: CustomTextStyles.display(color: Colors.black, fontSize: 106.sp, level: 1),
                      ),
                      Text(
                        "5 Guests",
                        style: CustomTextStyles.title(color: Colors.black, fontSize: 48.sp, level: 2),
                      ),
                    ],
                  ),
                ),
              ),
              // const Text(
              //   "Your Gaming Table:",
              //   style: TextStyle(fontSize: 50),
              // ),
              // const SizedBox(height: 20),
              // Text(
              //   " Table $tableId",
              //   style: const TextStyle(fontSize: 150, fontWeight: FontWeight.bold),
              // ),
              // // const Text(
              // //   " 5 Guests",
              // //   style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
              // // ),
              const SizedBox(height: 80),
              _BackButton(width: 600.w,),
              // CheckInButton(
              //   title: "Back",
              //   onPress: () {
              //     // Get.searchDelegate(null).toNamedAndOffUntil(
              //     //   AppRoutes.verificationCode,
              //     //   (p0) {
              //     //     return p0.name == AppRoutes.verificationCode;
              //     //   },
              //     // );
              //     Get.searchDelegate(null).toNamedAndOffUntil(
              //       AppRoutes.landingPage,
              //           (p0) {
              //         return p0.name == AppRoutes.landingPage;
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatefulWidget {
  _BackButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;

  @override
  _BackButtonState createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  double get width => widget.width;
  int get tableId => Get.arguments["tableId"];
  bool isChangeBgColor = false;

  // 创建音频播放器实例
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTapUp: (details) async {
        await audioPlayer.release;
        setState(() {
          isChangeBgColor = false;
        });
        // await Get.searchDelegate(null).toNamedAndOffUntil(
        //   AppRoutes.landingPage,
        //       (p0) {
        //     return p0.name == AppRoutes.landingPage;
        //   },
        // );
        await Get.offAllNamed(
          AppRoutes.landingPage,
          arguments: {"tableId": tableId},
        );
      },
      onTapDown: (details) async {
        await audioPlayer.play(AssetSource(MirraIcons.getSoundEffectsCheckPath("normal_click.wav")));
        setState(() {
          isChangeBgColor = true;
        });
      },
      onTapCancel: () async {
        // 手指离开区域的处理逻辑
        print('onTapCancel');
        await audioPlayer.release;
        setState(() {
          isChangeBgColor = !isChangeBgColor;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          //设置边框
          border: isChangeBgColor ? new Border.all(color: Color(0xffA4EDF1), width: 1) : new Border.all(color: Color(0xff13EFEF), width: 1),
          color: Color(0xFF233342),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h), //卡片大小
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 子项水平居中对齐
            children: [
              Text(
                "BACK",
                textAlign: TextAlign.center,
                style: CustomTextStyles.button(color: Color(0xffFFFFFF), fontSize: 28.sp),
              ),
              CustomCountdown(
                duration: Duration(seconds: 10),
                color: Color(0xffFFFFFF),
                start: true,
                onCountdownComplete: () async {
                  // await Get.searchDelegate(null).toNamedAndOffUntil(
                  //   AppRoutes.landingPage,
                  //       (p0) {
                  //     return p0.name == AppRoutes.landingPage;
                  //   }
                  // );
                  await Get.offAllNamed(
                    AppRoutes.landingPage,
                    arguments: {"tableId": tableId},
                  );
                },
              ),
              // Countdown(
              //   seconds: 3,
              //   build: (context, time) => TextButton(
              //       onPressed: () {},
              //       child: Text(
              //         "(" + "${time.toInt()}s" + ")",
              //         style: CustomTextStyles.button(color: Color(0xffFFFFFF), fontSize: 28.sp),
              //       )),
              //   onFinished: () async {
              //     await Get.searchDelegate(null).toNamedAndOffUntil(
              //           AppRoutes.landingPage,
              //               (p0) {
              //             return p0.name == AppRoutes.landingPage;
              //           },
              //         );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}