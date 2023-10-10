import 'package:flutter/material.dart';

import '../../../widgets/hexagon_avatar.dart';
import '../../../common.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({Key? key, required this.width, required this.rank, required this.score, required this.avatarUrl})
      : super(key: key);
  final double width;
  final int rank;
  final int score;
  final String avatarUrl;

  String backgroundUrl() {
    if (rank == 1) {
      return Global.getAssetImageUrl("leaderboard/cell_bg_1st.png");
    } else if (rank == 2) {
      return Global.getAssetImageUrl("leaderboard/cell_bg_2nd.png");
    } else if (rank == 3) {
      return Global.getAssetImageUrl("leaderboard/cell_bg_3rd.png");
    } else {
      return Global.getAssetImageUrl("leaderboard/cell_bg_other.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = width / 9.7;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height / 10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundUrl()),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.14,
            child: Center(
              child: Text(
                rank.toString(),
                style: TextStyle(
                  fontFamily: 'Burbank',
                  color: Global.team == 0 ? const Color(0xFFc93000) : const Color(0xFF6B16BF),
                  decoration: TextDecoration.none,
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.12,
            child: Center(
              child: HexagonAvatar(
                width: width * 0.08,
                avatarUrl: avatarUrl,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.5,
            child: Text(
              'Sophia Davis',
              style: TextStyle(
                fontFamily: 'Burbank',
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: width * 0.055,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                score.toString(),
                style: TextStyle(
                  fontFamily: 'Burbank',
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
