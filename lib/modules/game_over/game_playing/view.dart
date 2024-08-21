import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../../../../widgets/check_in_title.dart';
import '../../../3rd_libs/gif_view-0.4.3/gif_view.dart';
import '../../../common.dart';
import '../widgets/gif_view_widgets.dart';
import '../widgets/player_info_card.dart';
import 'logic.dart';

class GamePlayingPage extends StatelessWidget {
  GamePlayingPage({Key? key}) : super(key: key);
  final logic = Get.put(GamePlayingLogic());
  final GifController gifController = GifController(autoPlay: false, loop: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GamePlayingLogic>(
      id: "gamePlayingPage",
      builder: (logic) {
        return Scaffold(
            body: Stack(
              children: [
                Container(
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
                      CheckInTitlePage(titleText: logic.gameName),
                      const SizedBox(height: 100,),
                      SizedBox(
                        width: 1.0.sw,
                        height: 1.0.sh - 200,
                        // color: Colors.red,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center, // 设置水平居中
                          children: [
                            if(!logic.isWellDone) Container(
                              width: 1.0.sw - 612.w,
                              height: 1.0.sh - 320.0,
                              margin: EdgeInsets.only(left: (1.0.sw - 612.w) / 2),
                              child: FloatingPlayerAnimation(),
                            ),
                            if(logic.isWellDone) FloatingTextAnimation(),
                            if(logic.isWellDone) SizedBox(height: 30.0,),
                            if(logic.isWellDone) Container(
                              width: 0.5.sw,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // right: 0.5.sw / 2 + 261.w,
                                    // top: 0.42.sh,
                                    top: 20.0,
                                    right: 261.w,
                                    child: Image.asset(
                                      MirraIcons.getGifPath('High_Five.gif'),
                                      fit: BoxFit.fitHeight,
                                      height: (0.5.sw - 522.w),
                                    ),
                                    // child: GifViewWidgets(gifName: 'High_Five.gif', height: 0.5.sw - 522.w, frameRate: 25),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右对齐
                                    children: [
                                      if(logic.positionList.length > 0 ? true : false) PlayerInfoCard(
                                        avatarUrl: logic.positionList[0].player.avatarUrl,
                                        width: 306.w,
                                        nickname: logic.positionList[0].player.nickname,
                                        position: logic.positionList[0].position,
                                      ),
                                      if(logic.positionList.length > 1 ? true : false) PlayerInfoCard(
                                        avatarUrl: logic.positionList[1].player.avatarUrl,
                                        width: 306.w,
                                        nickname: logic.positionList[1].player.nickname,
                                        position: logic.positionList[1].position,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右对齐
                              //   children: [
                              //     PlayerInfoCard(
                              //       avatarUrl: logic.positionList[0].player.avatarUrl,
                              //       width: 306.w,
                              //       nickname: logic.positionList[0].player.nickname,
                              //       position: logic.positionList[0].position,
                              //     ),
                              //     // Image.asset(
                              //     //   MirraIcons.getGifPath('High_Five.gif'),
                              //     //   fit: BoxFit.fitHeight,
                              //     //   height: (0.5.sw - 612.w),
                              //     // ),
                              //     PlayerInfoCard(
                              //       avatarUrl: logic.positionList[1].player.avatarUrl,
                              //       width: 306.w,
                              //       nickname: logic.positionList[1].player.nickname,
                              //       position: logic.positionList[1].position,
                              //     ),
                              //   ],
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if(!logic.isWellDone) Positioned(
                  left: 0,
                  right: 0,
                  top: 30.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'On Live',
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                    ),
                  ),
                ),
                // 第二个烟花
                if(!logic.isWellDone) Positioned(
                  left: (1.0.sw - 612.w) / 2 - 0.15.sh,
                  top: 120,
                  // child: FutureBuilder<void>(
                  //   future: Future.delayed(Duration(milliseconds: 800)),
                  //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Container(); // 如果延迟尚未完成，返回一个空的 Container 或者其他占位符小部件
                  //     } else {
                  //       return Image.asset(
                  //         MirraIcons.getGifPath('Firework_Purple_3_2.gif'),
                  //         fit: BoxFit.fitHeight,
                  //         height: 0.15.sh,
                  //       );
                  //     }
                  //   },
                  // ),
                  child: GifViewWidgets(gifName: 'Firework_Purple_3_2.gif', height: 0.15.sh, frameRate: 42, delay: 240.ms, periodicTime: 910.ms),
                  // child: Image.asset(
                  //   MirraIcons.getGifPath('Firework_Purple_3_2.gif'),
                  //   fit: BoxFit.fitHeight,
                  //   height: 0.15.sh,
                  // ),
                ),
                // 第四个烟花
                if(!logic.isWellDone) Positioned(
                  right: (1.0.sw - 612.w) / 2 - 0.32.sh,
                  top: 120,
                  // child: Image.asset(
                  //   MirraIcons.getGifPath('Firework_Purple_3_2.gif'),
                  //   fit: BoxFit.fitHeight,
                  //   height: 0.27.sh,
                  // ),
                  child: GifViewWidgets(gifName: 'Firework_Purple_3_2.gif', height: 0.27.sh, frameRate: 53, delay: 0.ms, periodicTime: 1150.ms),
                ),
                // 第一个烟花
                if(!logic.isWellDone) Positioned(
                  left: ((1.0.sw - 612.w) / 2) / 2 - 0.1.sh,
                  bottom: 120,
                  // child: FutureBuilder<void>(
                  //   future: Future.delayed(Duration(milliseconds: 1500)),
                  //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Container(); // 如果延迟尚未完成，返回一个空的 Container 或者其他占位符小部件
                  //     } else {
                  //       return Image.asset(
                  //         MirraIcons.getGifPath('Firework_Purple_3_2.gif'),
                  //         fit: BoxFit.fitHeight,
                  //         height: 0.21.sh,
                  //       );
                  //     }
                  //   },
                  // ),
                  child: GifViewWidgets(gifName: 'Firework_Purple_3_2.gif', height: 0.21.sh, frameRate: 48, delay: 110.ms, periodicTime: 1040.ms),
                  // child: Image.asset(
                  //   MirraIcons.getGifPath('Firework_Purple_3_2.gif'),
                  //   fit: BoxFit.fitHeight,
                  //   height: 0.21.sh,
                  // ),
                ),
                // 第三个烟花
                if(!logic.isWellDone) Positioned(
                  right: (1.0.sw - 612.w) / 2 - 0.3.sh,
                  bottom: 80,
                  // child: FutureBuilder<void>(
                  //   future: Future.delayed(Duration(milliseconds: 1800)),
                  //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Container(); // 如果延迟尚未完成，返回一个空的 Container 或者其他占位符小部件
                  //     } else {
                  //       return Image.asset(
                  //         MirraIcons.getGifPath('Firework_Purple_3_2.gif'),
                  //         fit: BoxFit.fitHeight,
                  //         height: 0.21.sh,
                  //       );
                  //     }
                  //   },
                  // ),
                  child: GifViewWidgets(gifName: 'Firework_Purple_3_2.gif', height: 0.21.sh, frameRate: 38, delay: 330.ms, periodicTime: 820.ms),
                  // child: Image.asset(
                  //   MirraIcons.getGifPath('Firework_Purple_3_2.gif'),
                  //   fit: BoxFit.fitHeight,
                  //   height: 0.21.sh,
                  // ),
                ),
                // well done的烟花动图
                if(logic.isWellDone) Positioned(
                  left: 0.5.sw / 2 - 0.32.sh,
                  top: 80,
                  child: Image.asset(
                    MirraIcons.getGifPath('Firework_Pink_1.gif'),
                    fit: BoxFit.fitHeight,
                    height: 0.32.sh,
                  ),
                ),
                if(logic.isWellDone) Positioned(
                  left: 0.5.sw / 2 + 0.16.sh,
                  top: 60,
                  child: Image.asset(
                    MirraIcons.getGifPath('Firework_Purple_3.gif'),
                    fit: BoxFit.fitHeight,
                    height: 0.16.sh,
                  ),
                ),
                if(logic.isWellDone) Positioned(
                  right: 0.5.sw / 2 - 0.25.sh,
                  top: 210,
                  child: Image.asset(
                    MirraIcons.getGifPath('Firework_Yellow_2.gif'),
                    fit: BoxFit.fitHeight,
                    height: 0.25.sh,
                  ),
                ),
              ],
            ));
      }
    );
  }
}

class FloatingTextAnimation extends StatefulWidget {
  @override
  _FloatingTextAnimationState createState() => _FloatingTextAnimationState();
}
class _FloatingTextAnimationState extends State<FloatingTextAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("_animation.value ${_animation.value}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
              // color: Colors.red,
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0.0, -_animation.value),
                child: Text(
                  'Well Done !',
                  style: CustomTextStyles.display(color: Colors.white, fontSize: 80.sp, level: 3),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class FloatingPlayerAnimation extends StatefulWidget {
  @override
  _FloatingPlayerAnimationState createState() => _FloatingPlayerAnimationState();
}
class _FloatingPlayerAnimationState extends State<FloatingPlayerAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final logic = Get.put(GamePlayingLogic());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("_animation.value ${_animation.value}");
    return ListView.builder(
      scrollDirection: Axis.horizontal, // 设置为水平方向
      shrinkWrap: true, // 添加shrinkWrap属性
      physics: ClampingScrollPhysics(), // 添加physics属性
      itemCount: logic.positionList.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: index != 0 ? 50.w : 0.0),
              child: Transform.translate(
                // offset: Offset(0.0, -_animation.value * (index + 1) * 0.4),
                // offset: Offset(0.0, -_animation.value * (logic.positionList.length - index) * 0.5),
                offset: Offset(0.0, index == 0 ? (-_animation.value * (logic.positionList.length) * 0.7) : (-_animation.value * (logic.positionList.length) * 0.5)),
                child: PlayerInfoCard(
                  avatarUrl: logic.positionList[index].player.avatarUrl,
                  width: 306.w,
                  nickname: logic.positionList[index].player.nickname,
                  position: logic.positionList[index].position,
                ),
              ),
            );
          },
        );
      },
    );

  }
}