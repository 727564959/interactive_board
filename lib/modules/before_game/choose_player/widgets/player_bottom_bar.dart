import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/before_game/choose_player/widgets/bottom_bar_item.dart';

import '../logic.dart';

class PlayerBottomBar extends StatefulWidget {
  const PlayerBottomBar({super.key});

  @override
  State<PlayerBottomBar> createState() => _PlayerBottomBarState();
}

class _PlayerBottomBarState extends State<PlayerBottomBar> with TickerProviderStateMixin {
  final logic = Get.find<ChoosePlayerLogic>();
  late final animation = Tween<double>(begin: 0.5.sh, end: 0)
      .animate(CurvedAnimation(parent: logic.animationController, curve: Curves.easeOut));
  late final delayAnimation = Tween<double>(begin: 100, end: 0).animate(logic.delayController);
  int? selectIndex;
  late Timer timer;
  late int seconds;
  DateTime cooldown = DateTime.now();
  Future<void> dismiss() async {
    logic.dismissBottomBar();
    await logic.animationController.reverse();
    selectIndex = null;
  }

  @override
  void initState() {
    seconds = 0;
    timer = Timer.periodic(200.ms, (timer) {
      Duration duration = cooldown.difference(DateTime.now());
      setState(() {
        seconds = duration.inSeconds;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!logic.animationController.isDismissed)
          Expanded(
            child: GestureDetector(
              onTapUp: (_) => dismiss(),
              onPanStart: (_) => dismiss(),
            ),
          ),
        if (logic.animationController.isDismissed) Expanded(child: Container()),
        Transform.translate(
          offset: Offset(0, animation.value),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.4.sh,
                    alignment: Alignment.center,
                    color: const Color(0x665E6F9A),
                  ),
                ),
              ),
              if (seconds > 0)
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: CustomTextStyles.title5(
                        color: Colors.white,
                        fontSize: 50.sp,
                      ),
                      children: <InlineSpan>[
                        const TextSpan(text: 'Waiting for '),
                        TextSpan(
                          text: '${seconds}S',
                          style: CustomTextStyles.title5(
                            color: const Color(0xff13efef),
                            fontSize: 50.sp,
                          ),
                        ),
                        const TextSpan(text: ' to add players!'),
                      ],
                    ),
                  ),
                ),
              if (seconds <= 0)
                Transform.translate(
                  offset: Offset(0, delayAnimation.value),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 0.4.sh,
                    child: ListView.builder(
                      itemCount: logic.bottomBarPlayers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, idx) {
                        final tapController = AnimationController(value: 1.0, vsync: this, duration: 150.ms);

                        final player = logic.bottomBarPlayers[idx];
                        return Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTapUp: (details) async {
                              if (selectIndex != null) return;
                              selectIndex = idx;
                              await tapController.reverse();
                              await tapController.forward();
                              try {
                                await logic.updatePosition(player.id);
                                await dismiss();
                                cooldown = DateTime.now().add(10.seconds);
                              } on DioException {
                                logic.showPlayerSelectException();
                                dismiss();
                              }
                            },
                            child: BottomBarItem(
                              player: player,
                              controller: tapController,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
