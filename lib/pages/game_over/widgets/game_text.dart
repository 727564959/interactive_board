import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common.dart';
import '../../../widgets/game_title.dart';

import '../logic.dart';

class GameTextPage extends StatelessWidget {
  GameTextPage({
    Key? key,
    // required this.teamName,
    // required this.width,
    // required this.bAnimate,
  }) : super(key: key);
  // final String teamName;
  // final double width;
  // final bool bAnimate;

  final logic = Get.find<GameOverLogic>();

  @override
  Widget build(BuildContext context) {
    // const teamName = "Wolf";
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        // height: 1080,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Global.getAssetImageUrl("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            GameTitleWidget(
                gameName: logic.gameName, width: 0.45.sw, bAnimate: false),
            const SizedBox(height: 80),
            _Text(winnerText: "The winner is", width: 0.8.sw, bAnimate: false),
            _TeamText(
                // teamName: logic.records['redScore'] > logic.records['blueScore']
                //     ? "Team Wolf"
                //     : "Team Shark",
                teamName: logic.teamScore,
                width: 0.6.sw,
                bAnimate: false),
            _DecorateShape(width: 0.6.sw, bAnimate: false),
          ],
        ),
        // child: Stack(
        //   children: [
        //     // const SizedBox(height: 50),
        //     // GameTitleWidget(
        //     //     gameName: "Block Party", width: 0.45.sw, bAnimate: false),
        //     // const SizedBox(height: 80),
        //     Positioned(
        //       left: 240,
        //       top: 240,
        //       child: Container(
        //         child: Column(
        //           children: [
        //             const Text(
        //               'The winner is',
        //               style: TextStyle(
        //                   fontFamily: 'Burbank',
        //                   color: Colors.white,
        //                   decoration: TextDecoration.none,
        //                   fontSize: 80,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             Text(
        //               'Team ' + teamName,
        //               style: TextStyle(
        //                   fontFamily: 'Burbank',
        //                   color: Colors.white,
        //                   decoration: TextDecoration.none,
        //                   fontSize: 220,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(
      {Key? key,
      required this.winnerText,
      required this.width,
      required this.bAnimate})
      : super(key: key);
  final String winnerText;
  final double width;
  final bool bAnimate;
  @override
  Widget build(BuildContext context) {
    final text = Text(
      winnerText,
      style: const TextStyle(
          fontFamily: 'Burbank',
          color: Colors.white,
          decoration: TextDecoration.none,
          fontSize: 80,
          fontWeight: FontWeight.bold),
    );
    return text;
    // return !bAnimate
    //     ? text
    //     : text.animate(autoPlay: bAnimate).scale(delay: 100.ms, curve: Curves.easeIn, duration: 300.ms);
  }
}

class _TeamText extends StatelessWidget {
  const _TeamText(
      {Key? key,
      required this.teamName,
      required this.width,
      required this.bAnimate})
      : super(key: key);
  final String teamName;
  final double width;
  final bool bAnimate;
  @override
  Widget build(BuildContext context) {
    final teamText = Text(
      teamName,
      style: TextStyle(
          fontFamily: 'Burbank',
          color: Colors.white,
          decoration: TextDecoration.none,
          fontSize: 220,
          fontWeight: FontWeight.bold),
    );
    return teamText;
  }
}

class _DecorateShape extends StatelessWidget {
  const _DecorateShape({Key? key, required this.width, required this.bAnimate})
      : super(key: key);
  final double width;
  final bool bAnimate;
  @override
  Widget build(BuildContext context) {
    final decorate = Stack(
      children: [
        Align(
          alignment: const Alignment(0.2, 1.1),
          child: Image.asset(
            Global.getAssetImageUrl('time_up_icon.png'),
            width: width * 0.45,
          ),
        ),
      ],
    );
    return decorate;
    // return !bAnimate ? decorate : decorate.animate().moveX(begin: -70, end: 0, curve: Curves.easeOut, duration: 300.ms);
  }
}
