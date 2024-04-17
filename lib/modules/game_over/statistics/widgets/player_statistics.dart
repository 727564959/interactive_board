import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;
import 'package:flutter/material.dart';

import '../../../../mirra_style.dart';
import '../logic.dart';

class PlayerStatisticsView extends StatelessWidget {
  PlayerStatisticsView({Key? key}) : super(key: key);
  final logic = Get.find<StatisticsLogic>();
  final upperHeight = 0.5.sh;
  final baseHeight = 0.3.sh;
  List<Widget> get children {
    print("result ${logic.resultPlayerRecord}");
    logic.resultPlayerRecord.sort((a, b) => a.position - b.position);
    print("result sort ${logic.resultPlayerRecord}");
    return logic.resultPlayerRecord
        .map((e) => _ScoreBar(
        score: e.score,
        tableId: e.tableId,
        rank: e.rank,
        position: e.position,
        avatarUrl: e.avatarUrl,
        height: upperHeight * e.score / 1000 + baseHeight,
        nickname: e.nickname))
        .toList();
  }

  List<Widget> get children1 {
    print("result ${logic.teamList}");
    logic.teamList.sort((a, b) => a.teamId - b.teamId);
    print("result sort ${logic.teamList}");
    return logic.teamList
        .map((e) => _TeamCard(
        name: e.name,
        teamId: e.teamId,
        iconPath: e.iconPath,
        blackBorderIconPath: e.blackBorderIconPath,
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
            color: Colors.red,
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
            // child: Row(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   mainAxisSize: MainAxisSize.min,
            //   children: children,
            // ),
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
  }) : super(key: key);
  final String name;
  final int teamId;
  final String iconPath;
  final String blackBorderIconPath;
  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> with TickerProviderStateMixin {
  double get width => 385.w;
  double get height => 75.h;
  String get name => widget.name;
  int get teamId => widget.teamId;
  String get iconPath => widget.iconPath;
  String get blackBorderIconPath => widget.blackBorderIconPath;
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
        height: height,
        // decoration: BoxDecoration(
        //   color: color,
        //   // borderRadius: BorderRadius.vertical(
        //   //   top: Radius.circular(15.0),
        //   //   bottom: Radius.circular(0.0),
        //   // ),
        // ),
        child: ClipPath(
          clipper: RoundedHexagonClipper(),
          child: Container(
            color: color,
          ),
        ),
      ),
    );
  }
}

class RoundedHexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double cornerRadius = 10.0;
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width - cornerRadius, size.height * 0.5);
    path.lineTo(size.width * 0.75, size.height);
    path.lineTo(size.width * 0.25, size.height);
    path.lineTo(cornerRadius, size.height * 0.5);
    path.lineTo(size.width * 0.25, 0);
    path.addRRect(RRect.fromLTRBR(
      size.width * 0.25,
      0,
      size.width * 0.75,
      size.height,
      Radius.circular(cornerRadius),
    ));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _ScoreBar extends StatefulWidget {
  const _ScoreBar({
    Key? key,
    required this.score,
    required this.tableId,
    required this.rank,
    required this.position,
    required this.avatarUrl,
    required this.height,
    required this.nickname,
  }) : super(key: key);
  final double height;
  final int score;
  final int tableId;
  final int rank;
  final int position;
  final String avatarUrl;
  final String nickname;
  @override
  State<_ScoreBar> createState() => _ScoreBarState();
}

class _ScoreBarState extends State<_ScoreBar> with TickerProviderStateMixin {
  double get width => 210.w;
  double get height => widget.height;
  int get score => widget.score;
  int get tableId => widget.tableId;
  int get rank => widget.rank;
  int get position => widget.position;
  String get avatarUrl => widget.avatarUrl;
  String get nickname => widget.nickname;
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
    animation = Tween<double>(begin: upperHeight * score / 1000, end: 0)
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
    if (position == 1) {
      return const Color(0xFFEE8144);
    } else if (position == 2) {
      return const Color(0xFFE16722);
    } else if (position == 3) {
      return const Color(0xFFCF83BE);
    } else if (position == 4) {
      return const Color(0xFFB266A1);
    } else if (position == 5) {
      return const Color(0xFF63BC91);
    } else if (position == 6) {
      return const Color(0xFF3EA373);
    } else if (position == 7) {
      return const Color(0xFF6188D3);
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
        margin: EdgeInsets.only(right: position%2 == 0 ? 20.0 : 5.0),
        // decoration: BoxDecoration(
        //   color: Colors.red,
        //   borderRadius: BorderRadius.vertical(
        //     top: Radius.circular(15.0),
        //     bottom: Radius.circular(0.0),
        //   ),
        // ),
        width: width * 0.9,
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
                  // color: color,
                  height: height - 70.w,
                  // margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 0.0),
                  // margin: EdgeInsets.only(right: position%2 == 0 ? 20.0 : 2.0),
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
                      (scoreAnimation.value * score ~/ 1).toString(),
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                    ),
                    SizedBox(height: 80.w),
                    _HeadCircle(
                      nickname: nickname,
                      avatarUrl: avatarUrl,
                      position: position,
                      width: width,),
                    // SizedBox(height: 20.w),
                    // Container(
                    //   height: 55.w,
                    //   padding: EdgeInsets.only(top: 10.w, bottom: 8.w),
                    //   width: 130.w,
                    //   alignment: Alignment.center,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: Colors.white,
                    //       width: 2,
                    //     ),
                    //     borderRadius: BorderRadius.circular(27.5.w),
                    //   ),
                    //   child: AutoSizeText(
                    //     "$nickname",
                    //     maxLines: 1,
                    //     style: const TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       decoration: TextDecoration.none,
                    //       fontFamily: 'Burbank',
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
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

class _HeadCircle extends StatelessWidget {
  const _HeadCircle({
    Key? key,
    required this.nickname,
    required this.avatarUrl,
    required this.position,
    required this.width,
  }) : super(key: key);
  final String nickname;
  final String avatarUrl;
  final int position;
  final double width;

  Color get color {
    if (position == 1 || position == 2) {
      return const Color(0xFFFFBD80);
    } else if (position == 3 || position == 4) {
      return const Color(0xFFEFB5FD);
    } else if (position == 5 || position == 6) {
      return const Color(0xFF8EE8BD);
    } else {
      return const Color(0xFF9ED7F7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: Stack(
        alignment: const Alignment(0, 0),
        children: [
          Container(
            width: width * 0.9,
            height: width * 0.9,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(width * 0.8),
            ),
          ),
          Container(
            width: width * 0.82,
            height: width * 0.82,
            alignment: const Alignment(0, 0.85),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(avatarUrl), // 替换为你的图片路径
                fit: BoxFit.contain, // 根据需要调整图片的适应方式
              ),
              borderRadius: BorderRadius.circular(width * 0.75),
            ),
            // child: Text(
            //   nickname,
            //   style: CustomTextStyles.notice(color: Colors.black, fontSize: 24.sp),
            // ),
            child: Container(
              // alignment: const Alignment(0, 0.85),
              decoration: BoxDecoration(
                color: color, // 背景块的颜色
                // borderRadius: BorderRadius.circular(8.0), // 背景块的圆角
              ),
              padding: EdgeInsets.all(4.0), // 背景块的内边距
              child: Text(
                nickname,
                maxLines: 1, // 最大显示行数
                overflow: TextOverflow.ellipsis, // 超出部分的省略样式
                style: CustomTextStyles.notice(color: Colors.black, fontSize: 24.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}