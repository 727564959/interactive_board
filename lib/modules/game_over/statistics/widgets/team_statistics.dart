import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;
import 'package:flutter/material.dart';

import '../../../../mirra_style.dart';
import '../logic.dart';

class TeamStatisticsView extends StatelessWidget {
  TeamStatisticsView({Key? key}) : super(key: key);
  final logic = Get.find<StatisticsLogic>();
  final upperHeight = 0.5.sh;
  final baseHeight = 0.5.sh;
  List<Widget> get children {
    print("result ${logic.resultTeamRecord}");
    logic.resultTeamRecord.sort((a, b) => a.teamId - b.teamId);
    print("result sort ${logic.resultTeamRecord}");
    return logic.resultTeamRecord
        .map((e) => _ScoreBar(
        teamId: e.teamId,
        score: e.score,
        rankScore: e.rankScore,
        name: e.name,
        iconPath: e.iconPath,
        height: upperHeight * e.rankScore / 100 + baseHeight + (240 - (60 * e.rank)),
        blackBorderIconPath: e.blackBorderIconPath,
        rank: e.rank))
        .toList();
  }

  List<Widget> get children1 {
    print("result ${logic.resultTeamRecord}");
    logic.resultTeamRecord.sort((a, b) => a.teamId - b.teamId);
    print("result sort ${logic.resultTeamRecord}");
    return logic.resultTeamRecord
        .map((e) => _TeamCard(
      name: e.name,
      teamId: e.teamId,
      iconPath: e.iconPath,
      blackBorderIconPath: e.blackBorderIconPath,
      rank: e.rank
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.15.sh),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            // color: Colors.red,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
                Positioned(
                  bottom: 0.1.sh,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: children1,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _TeamCard extends StatefulWidget {
  const _TeamCard({
    Key? key,
    required this.name,
    required this.teamId,
    required this.iconPath,
    required this.blackBorderIconPath,
    required this.rank,
  }) : super(key: key);
  final String name;
  final int teamId;
  final String iconPath;
  final String blackBorderIconPath;
  final int rank;
  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> with TickerProviderStateMixin {
  double get width => 385.w;
  // double get height => 240.h;
  String get name => widget.name;
  int get teamId => widget.teamId;
  String get iconPath => widget.iconPath;
  String get blackBorderIconPath => widget.blackBorderIconPath;
  int get rank => widget.rank;
  final upperHeight = 0.5.sh;
  final baseHeight = 0.3.sh;
  late AnimationController controller;
  late final Animation<double> animation;
  late final Animation<double> scoreAnimation;

  void initState() {
    controller = AnimationController(vsync: this, duration: 1.seconds);
    animation = Tween<double>(begin: upperHeight * width / 1000, end: 0)
        .animate(controller);
    scoreAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  Color get color {
    if (teamId == 1) {
      return const Color(0xFFFFBD80);
    } else if (teamId == 2) {
      return const Color(0xFFEFB5FD);
    } else if (teamId == 3) {
      return const Color(0xFF8EE8BD);
    } else {
      return const Color(0xFF9ED7F7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, animation.value),
      child: Container(
        width: width,
        // height: height,
        margin: EdgeInsets.only(left: teamId > 1 ? 20.0 : 0.0),
        child: Column(
          children: [
            Text(
              rank.toString(),
              style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 1),
            ),
            SizedBox(height: 20.w),
            ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: ClipPath(
                  clipper: RoundedHexagonClipper(),
                  child: Container(
                    color: color,
                    child: Row(
                      children: [
                        SizedBox(width: 50.0),
                        CachedNetworkImage(
                          width: 50.w,
                          imageUrl: iconPath,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 2.0), // 图片和文字之间的间距
                        Text(
                          name,
                          style: CustomTextStyles.title(color: Colors.black, fontSize: 40.sp, level: 3),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class RoundedHexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double cornerRadius = 15.0;
    // path.moveTo(size.width * 0.25, 0);
    // path.lineTo(size.width * 0.75, 0);
    // path.lineTo(size.width - cornerRadius, size.height * 0.5);
    // path.lineTo(size.width * 0.75, size.height);
    // path.lineTo(size.width * 0.25, size.height);
    // path.lineTo(cornerRadius, size.height * 0.5);
    // path.lineTo(size.width * 0.25, 0);

    path.moveTo(size.width * 0.15, 0);
    path.lineTo(size.width * 0.85, 0);
    path.lineTo(size.width - cornerRadius, size.height * 0.4);
    path.lineTo(size.width - cornerRadius, size.height * 0.6);
    path.lineTo(size.width * 0.85, size.height);
    path.lineTo(size.width * 0.15, size.height);
    path.lineTo(cornerRadius, size.height * 0.6);
    path.lineTo(cornerRadius, size.height * 0.4);
    path.lineTo(size.width * 0.15, 0);

    // path.addRRect(RRect.fromLTRBR(
    //   size.width * 0.25,
    //   0,
    //   size.width * 0.75,
    //   size.height,
    //   Radius.circular(cornerRadius),
    // ));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _ScoreBar extends StatefulWidget {
  const _ScoreBar({
    Key? key,
    required this.teamId,
    required this.score,
    required this.rankScore,
    required this.name,
    required this.iconPath,
    required this.blackBorderIconPath,
    required this.rank,
    required this.height,
  }) : super(key: key);
  final double height;
  final int teamId;
  final int score;
  final int rankScore;
  final String name;
  final String iconPath;
  final String blackBorderIconPath;
  final int rank;
  @override
  State<_ScoreBar> createState() => _ScoreBarState();
}

class _ScoreBarState extends State<_ScoreBar> with TickerProviderStateMixin {
  double get width => 385.w;
  double get height => widget.height;
  int get score => widget.score;
  int get rankScore => widget.rankScore;
  int get teamId => widget.teamId;
  String get name => widget.name;
  String get iconPath => widget.iconPath;
  String get blackBorderIconPath => widget.blackBorderIconPath;
  int get rank => widget.rank;
  final upperHeight = 0.5.sh;
  final baseHeight = 0.3.sh;
  late AnimationController controller;
  late final Animation<double> animation;
  late final Animation<double> scoreAnimation;
  @override
  void initState() {
    // print("哈哈哈1 $score");
    // print("嘿嘿嘿1 $tableId");
    controller = AnimationController(vsync: this, duration: 1.seconds);
    animation = Tween<double>(begin: upperHeight * rankScore / 100, end: 0)
        .animate(controller);
    scoreAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  // background: #EE8144; background: #E16722; background: #CF83BE; background: #B266A1; background: #63BC91; background: #3EA373; background: #6188D3; background: #406ABB;
  Color get color {
    if (teamId == 1) {
      return const Color(0xFFE16722);
    } else if (teamId == 2) {
      return const Color(0xFFB266A1);
    } else if (teamId == 3) {
      return const Color(0xFF3EA373);
    } else {
      return const Color(0xFF406ABB);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, animation.value),
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 1),
        margin: EdgeInsets.only(right: 20.0),
        width: width,
        height: height,
        child: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: width,
                  // height: height - 170.w,
                  height: height - 100.w,
                  // color: color,
                  // margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15.0),
                      bottom: Radius.circular(0.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "+" + (scoreAnimation.value * rankScore ~/ 1).toString(),
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
                      // style: TextStyle(
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 100.sp,
                      //   decoration: TextDecoration.none,
                      //   fontFamily: 'Burbank',
                      //   color: Colors.white,
                      // ),
                    ),
                    // Text(
                    //   rank.toString(),
                    //   style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 1),
                    // ),
                    // SizedBox(height: 20.w),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
