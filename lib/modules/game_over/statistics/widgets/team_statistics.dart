import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;
import 'package:flutter/material.dart';

import '../../../../mirra_style.dart';
import '../logic.dart';

class TeamStatisticsView extends StatelessWidget {
  TeamStatisticsView({Key? key}) : super(key: key);
  final logic = Get.find<StatisticsLogic>();
  final upperHeight = 0.5.sh;
  final baseHeight = 0.3.sh;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.05.sh),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        )
      ],
    );
  }
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
  double get width => 210.w;
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
        margin: const EdgeInsets.symmetric(horizontal: 1),
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
                  height: height,
                  // color: color,
                  margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 0.0),
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
                    // _Circle(
                    //   rank: rankScore,
                    //   width: 120.w,
                    // ),
                    Text(
                      rank.toString(),
                      style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 1),
                    ),
                    SizedBox(height: 20.w),
                    Container(
                      height: 55.w,
                      padding: EdgeInsets.only(top: 10.w, bottom: 8.w),
                      width: 130.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(27.5.w),
                      ),
                      child: AutoSizeText(
                        "$name",
                        maxLines: 1,
                        style: CustomTextStyles.title(color: Colors.black, fontSize: 40.sp, level: 3),
                        // style: const TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   decoration: TextDecoration.none,
                        //   fontFamily: 'Burbank',
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
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

class _Circle extends StatelessWidget {
  const _Circle({
    Key? key,
    required this.rank,
    required this.width,
  }) : super(key: key);
  final int rank;
  final double width;

  Color get color {
    if (rank == 1) {
      return const Color(0xFFC73616);
    } else if (rank == 2) {
      return const Color(0xFFFA6424);
    } else if (rank == 3) {
      return const Color(0xFF72AF42);
    } else {
      return const Color(0xFFA36A52);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: Stack(
        alignment: const Alignment(0, -0.3),
        children: [
          Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.5),
            ),
          ),
          Container(
            width: width * 0.9,
            height: width * 0.9,
            alignment: const Alignment(0, 0.2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(width * 0.45),
            ),
            child: Text(
              rank.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontFamily: 'Burbank',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
