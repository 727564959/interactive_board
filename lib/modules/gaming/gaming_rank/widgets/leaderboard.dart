import 'package:flutter/material.dart';
import 'record_list.dart';
import '../../../../../common.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    final height = width * 1.1;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              width: width,
              Global.getAssetImageUrl("leaderboard/background.png"),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              width: width * 0.47,
              Global.getAssetImageUrl("leaderboard/title_bg.png"),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, -0.92),
            child: Text(
              'Leaderboard',
              style: TextStyle(
                fontFamily: 'Burbank',
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.3, 0.3),
            child: RecordList(width: width * 0.83, height: height * 0.75),
          ),
        ],
      ),
    );
  }
}
