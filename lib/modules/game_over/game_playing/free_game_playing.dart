import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/game_over/game_playing/player_bay_card.dart';

import '../../../../mirra_style.dart';
import '../../../../widgets/check_in_title.dart';
import '../../../3rd_libs/gif_view-0.4.3/gif_view.dart';
import '../../../common.dart';
import '../widgets/gif_view_widgets.dart';
import 'logic.dart';

class FreeGamePlayingPage extends StatelessWidget {
  FreeGamePlayingPage({Key? key}) : super(key: key);
  final logic = Get.put(GamePlayingLogic());
  final GifController gifController = GifController(autoPlay: false, loop: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GamePlayingLogic>(
        id: "freeGamePlayingPage",
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
                        const SizedBox(height: 50,),
                        SizedBox(
                          width: 1.0.sw,
                          height: 1.0.sh - 200,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center, // 设置水平居中
                            children: [
                              if(!logic.isWellDone) Container(
                                width: 0.6.sw,
                                height: 0.7.sh,
                                // margin: EdgeInsets.only(left: (1.0.sw - 612.w) / 2),
                                child: FloatingPlayerAnimation(),
                              ),
                              if(logic.isWellDone) FloatingTextAnimation(),
                              if(logic.isWellDone) SizedBox(height: 120.0,),
                              if(logic.isWellDone) Container(
                                width: 1.0.sw,
                                height: 1.0.sh - 420.0,
                                // margin: EdgeInsets.only(left: 40.0),
                                child: logic.allPositionList.length > 6
                                    ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FloatingPlayerListAnimation(),
                                    ],
                                  ),
                                )
                                    : Center(
                                  child: FloatingPlayerListAnimation(),
                                ),
                              ),
                              // if(logic.isWellDone) Container(
                              //   width: 0.5.sw,
                              //   child: Stack(
                              //     children: [
                              //       Positioned(
                              //         top: 20.0,
                              //         right: 261.w,
                              //         child: GifViewWidgets(gifName: 'High_Five.gif', height: 0.5.sw - 522.w, frameRate: 25),
                              //       ),
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右对齐
                              //         children: [
                              //           if(logic.positionList.length > 0 ? true : false) PlayerInfoCard(
                              //             avatarUrl: logic.positionList[0].player.avatarUrl,
                              //             width: 306.w,
                              //             nickname: logic.positionList[0].player.nickname,
                              //             position: logic.positionList[0].position,
                              //           ),
                              //           if(logic.positionList.length > 1 ? true : false) PlayerInfoCard(
                              //             avatarUrl: logic.positionList[1].player.avatarUrl,
                              //             width: 306.w,
                              //             nickname: logic.positionList[1].player.nickname,
                              //             position: logic.positionList[1].position,
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // on live文字
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
                    left: 0.08.sw,
                    top: 120,
                    child: GifViewWidgets(gifName: 'Firework_Purple_3_2.gif', height: 0.15.sh, frameRate: 42, delay: 240.ms, periodicTime: 910.ms),
                  ),
                  // 第四个烟花
                  if(!logic.isWellDone) Positioned(
                    right: 0.03.sw,
                    top: 120,
                    child: GifViewWidgets(gifName: 'Firework_Purple_3_2.gif', height: 0.21.sh, frameRate: 53, delay: 0.ms, periodicTime: 1150.ms),
                  ),
                  // 第一个烟花
                  if(!logic.isWellDone) Positioned(
                    left: 0.05.sw,
                    bottom: 120,
                    child: GifViewWidgets(gifName: 'Firework_Purple_3_2.gif', height: 0.19.sh, frameRate: 48, delay: 110.ms, periodicTime: 1040.ms),
                  ),
                  // 第三个烟花
                  if(!logic.isWellDone) Positioned(
                    right: 0.07.sw,
                    bottom: 80,
                    child: GifViewWidgets(gifName: 'Firework_Purple_3_2.gif', height: 0.14.sh, frameRate: 38, delay: 330.ms, periodicTime: 820.ms),
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
                  // 击拳的烟花
                  if(logic.isWellDone) Positioned(
                    right: 1.0.sw / 2 - 0.1.sw,
                    top: 170,
                    child: Image.asset(
                      MirraIcons.getGifPath('High_Five.gif'),
                      fit: BoxFit.fitHeight,
                      height: 0.21.sw,
                    ),
                    // child: GifViewWidgets(gifName: 'High_Five.gif', height: 0.21.sw, frameRate: 23, periodicTime: 100.ms),
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

// 两行
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
    print("logic.allPositionList.length ${logic.allPositionList.length}");
    return GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 5.0, // 设置列之间的间距
        mainAxisSpacing: 5.0, // 行之间的间距
        childAspectRatio: 0.714, // 设置卡片宽高比
        children: logic.allPositionList.map((card) {
          return AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              return Container(
                alignment: Alignment.center,
                // margin: EdgeInsets.only(left: index != 0 ? 50.w : 0.0),
                child: PlayerBayCard(
                  avatarUrl: card.player.avatarUrl,
                  width: 275.w,
                  nickname: card.player.nickname,
                  position: card.position,
                  bayNum: card.player.tableId,
                ),
              );
            },
          );
        }).toList()
      // ListView.builder(
      // scrollDirection: Axis.horizontal, // 设置为水平方向
      // shrinkWrap: true, // 添加shrinkWrap属性
      // physics: ClampingScrollPhysics(), // 添加physics属性
      // itemCount: logic.allPositionList.length,
      // itemBuilder: (BuildContext context, int index) {
      //
      // },
    );

  }
}

// 一行
class FloatingPlayerListAnimation extends StatefulWidget {
  @override
  _FloatingPlayerListAnimationState createState() => _FloatingPlayerListAnimationState();
}
class _FloatingPlayerListAnimationState extends State<FloatingPlayerListAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final logic = Get.put(GamePlayingLogic());
  Color get selectedColor {
    if (Global.tableId == 1) {
      return const Color(0xffFFBD80);
    } else if (Global.tableId == 2) {
      return const Color(0xffEFB5FD);
    } else if (Global.tableId == 3) {
      return const Color(0xff9ED7F7);
    } else {
      return const Color(0xff8EE8BD);
    }
  }

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
      itemCount: logic.allPositionList.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: index != 0 ? 10.0 : 0.0),
              child: PlayerBayCard(
                avatarUrl: logic.allPositionList[index].player.avatarUrl,
                width: 275.w,
                nickname: logic.allPositionList[index].player.nickname,
                position: logic.allPositionList[index].position,
                bayNum: logic.allPositionList[index].player.tableId,
                // labelColor: selectedColor,
              ),
              // child: Transform.translate(
              //   offset: Offset(0.0, (-_animation.value * (logic.allPositionList.length) * 0.3)),
              //   child: PlayerBayCard(
              //     avatarUrl: logic.allPositionList[index].player.avatarUrl,
              //     width: 270.w,
              //     nickname: logic.allPositionList[index].player.nickname,
              //     bayNum: logic.allPositionList[index].player.tableId,
              //     // labelColor: selectedColor,
              //   ),
              // ),
            );
          },
        );
      },
    );
  }
}