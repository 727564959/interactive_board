import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart' hide AnimationExtension;
import '../../../widgets/hexagon_avatar.dart';
import '../../../common.dart';
import '../logic.dart';

class RecordItem extends StatefulWidget {
  RecordItem({
    Key? key,
    required this.width,
    required this.rank,
    required this.score,
    required this.avatarUrl,
    required this.nickname,
    required this.playerId,
  }) : super(key: key);
  final double width;
  final int rank;
  final int score;
  final String avatarUrl;
  final String nickname;
  final String playerId;
  final logic = Get.find<GamingRankLogic>();

  @override
  State<RecordItem> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> with TickerProviderStateMixin {
  double get width => widget.width;
  int get rank => widget.rank;
  int get score => widget.score;
  String get avatarUrl => widget.avatarUrl;
  String get nickname => widget.nickname;
  String get playerId => widget.playerId;
  final logic = Get.find<GamingRankLogic>();
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String get backgroundUrl {
    String path;
    if (playerId != logic.selectedId) {
      if (rank == 1) {
        path = "leaderboard/cell_bg_1st.png";
      } else if (rank == 2) {
        path = "leaderboard/cell_bg_2nd.png";
      } else if (rank == 3) {
        path = "leaderboard/cell_bg_3rd.png";
      } else {
        path = "leaderboard/cell_bg_other.png";
      }
    } else {
      if (rank == 1) {
        path = "leaderboard/cell_bg_1st_selected.png";
      } else if (rank == 2) {
        path = "leaderboard/cell_bg_2nd_selected.png";
      } else if (rank == 3) {
        path = "leaderboard/cell_bg_3rd_selected.png";
      } else {
        path = "leaderboard/cell_bg_other_selected.png";
      }
    }
    return Global.getAssetImageUrl(path);
  }

  @override
  Widget build(BuildContext context) {
    final height = width / 9.7;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (playerId == logic.selectedId) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
    return Container(
      margin: EdgeInsets.symmetric(vertical: height / 10),
      width: width,
      height: height,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              backgroundUrl,
              width: width,
              height: height,
              fit: BoxFit.fill,
            ).animate(controller: controller, autoPlay: false).scale(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.05, 1.1),
                  duration: 300.ms,
                ),
          ),
          Row(
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
                  nickname,
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
        ],
      ),
    );
  }
}
