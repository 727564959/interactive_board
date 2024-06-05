import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../../../../widgets/check_in_title.dart';
import '../../../common.dart';
import '../../../widgets/player_card.dart';
import '../../../widgets/player_dress_model.dart';
import 'logic.dart';

class GameShowEndPage extends StatelessWidget {
  GameShowEndPage({Key? key}) : super(key: key);
  final logic = Get.put(GameShowEndLogic());

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 50,),
                  SizedBox(
                    width: 1.0.sw,
                    height: 1.0.sh - 150,
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center, // 设置水平居中
                        children: [
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     'Congratulations!',
                          //     style: CustomTextStyles.display(color: Colors.white, fontSize: 80.sp, level: 4),
                          //   ),
                          // ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     'You have finished Mirra Journey.',
                          //     style: CustomTextStyles.display(color: Colors.white, fontSize: 80.sp, level: 4),
                          //   ),
                          // ),
                          FloatingTextAnimation(),
                          Container(
                            width: 1.0.sw - 40.0,
                            height: 1.0.sh - 320.0,
                            margin: EdgeInsets.only(left: 40.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FloatingPlayerAnimation(),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       // Transform.translate(
                          //       //   offset: const Offset(0, -30),
                          //       //   child: PlayerTargetCard(position: position1),
                          //       // ),
                          //       // PlayerTargetCard(position: position2, delay: 400.ms),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 60.0,
              child: SizedBox(
                height: 0.55.sh,
                child: Image.asset(
                  MirraIcons.getGifPath('show_end_fireworks.gif'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ));
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
                  'Congratulations!',
                  style: CustomTextStyles.display(color: Colors.white, fontSize: 80.sp, level: 4),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
              // color: Colors.green,
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0.0, -_animation.value),
                child: Text(
                  'You have finished Mirra Journey.',
                  style: CustomTextStyles.display(color: Colors.white, fontSize: 80.sp, level: 4),
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
  final logic = Get.put(GameShowEndLogic());
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
      itemCount: logic.userList.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: index != 0 ? 10.0 : 0.0),
              child: Transform.translate(
                // offset: Offset(0.0, -_animation.value * (index + 1) * 0.4),
                // offset: Offset(0.0, -_animation.value * (logic.userList.length - index) * 0.5),
                offset: Offset(0.0, (-_animation.value * (logic.userList.length) * 0.3)),
                child: PlayerCard(
                  avatarUrl: logic.userList[index].avatarUrl,
                  width: 270.w,
                  nickname: logic.userList[index].nickname,
                  // labelColor: selectedColor,
                ),
              ),
            );
          },
        );
      },
    );

  }
}