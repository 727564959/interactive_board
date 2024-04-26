import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../mirra_style.dart';
import '../logic.dart';

String getDeviceName(int position) {
  final char = ascii.decode([0x40 + (position + 1) ~/ 2]);
  return "Device $char${(position + 1) % 2 + 1}";
}

class RecordList extends StatelessWidget {
  RecordList({Key? key}) : super(key: key);
  final logic = Get.find<GamingRankLogic>();

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (int i = 0; i < logic.sortedRecords.length; i++) {
      final item = logic.sortedRecords[i];
      final widget = _RecordItem(
        nickname: item.player.nickname,
        rank: i + 1,
        score: item.score,
        avatarUrl: item.player.avatarUrl,
        playerId: item.player.id,
        position: item.player.position,
      );
      children.add(widget);
    }
    return Column(children: children);
  }
}

class _RecordItem extends StatelessWidget {
  _RecordItem({
    Key? key,
    required this.rank,
    required this.score,
    required this.avatarUrl,
    required this.nickname,
    required this.playerId,
    required this.position,
  }) : super(key: key);

  final int rank;
  final int score;
  final String avatarUrl;
  final String nickname;
  final int playerId;
  final int position;
  final logic = Get.find<GamingRankLogic>();

  Color get backgroundColor {
    if (rank == 1) {
      return const Color(0xffFFBD80);
    } else if (rank == 2) {
      return const Color(0xff9ED7F7);
    } else if (rank == 3) {
      return const Color(0xff8EE8BD);
    } else {
      return const Color(0xffD0D0D0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      height: 75.w,
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      margin: EdgeInsets.symmetric(vertical: 4.w),
      child: Row(
        children: [
          SizedBox(
            width: 350.w,
            child: Text(
              "$rank    $nickname",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.notice(color: const Color(0xff272727), fontSize: 25.sp),
            ),
          ),
          SizedBox(
            width: 250.w,
            child: Text(
              getDeviceName(position),
              style: CustomTextStyles.notice(color: const Color(0xff272727), fontSize: 25.sp),
            ),
          ),
          Expanded(
            child: Text(
              "$score",
              maxLines: 1,
              textAlign: TextAlign.right,
              style: CustomTextStyles.title5(color: const Color(0xff272727), fontSize: 32.sp),
            ),
          ),
        ],
      ),
    );
  }
}
