import 'package:flutter/material.dart';
import 'package:interactive_board/common.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GameTitleWidget extends StatelessWidget {
  const GameTitleWidget({
    Key? key,
    required this.gameName,
    required this.width,
    required this.bAnimate,
  }) : super(key: key);
  final String gameName;
  final double width;
  final bool bAnimate;

  @override
  Widget build(BuildContext context) {
    final height = width * 0.22;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          _DecorateShape(width: width, bAnimate: bAnimate),
          _Content(bAnimate: bAnimate),
          _Title(gameName: gameName, width: width, bAnimate: bAnimate),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key, required this.bAnimate}) : super(key: key);

  final bool bAnimate;
  @override
  Widget build(BuildContext context) {
    final content = Image.asset(Global.getAssetImageUrl("game_title/background.png"));
    return !bAnimate
        ? content
        : content.animate().moveX(begin: 800, end: 0, curve: Curves.elasticOut, duration: 1000.ms);
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.gameName, required this.width, required this.bAnimate}) : super(key: key);
  final String gameName;
  final double width;
  final bool bAnimate;
  @override
  Widget build(BuildContext context) {
    final title = Center(
      child: Text(
        gameName,
        style: TextStyle(
            fontFamily: 'Burbank',
            color: Global.team == 0 ? const Color(0xFFc93000) : const Color(0xFF6B16BF),
            decoration: TextDecoration.none,
            fontSize: width * 0.09,
            fontWeight: FontWeight.bold),
      ),
    );
    return !bAnimate
        ? title
        : title.animate(autoPlay: bAnimate).scale(delay: 100.ms, curve: Curves.easeIn, duration: 300.ms);
  }
}

class _DecorateShape extends StatelessWidget {
  const _DecorateShape({Key? key, required this.width, required this.bAnimate}) : super(key: key);
  final double width;
  final bool bAnimate;
  @override
  Widget build(BuildContext context) {
    final decorate = Stack(
      children: [
        Align(
          alignment: const Alignment(-0.4, -0.83),
          child: Image.asset(
            Global.getAssetImageUrl('game_title/up.png'),
            width: width * 0.16,
          ),
        ),
        Align(
          alignment: const Alignment(0.2, 1.1),
          child: Image.asset(
            Global.getAssetImageUrl('game_title/down.png'),
            width: width * 0.45,
          ),
        ),
      ],
    );
    return !bAnimate ? decorate : decorate.animate().moveX(begin: -70, end: 0, curve: Curves.easeOut, duration: 300.ms);
  }
}
