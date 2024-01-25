import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'record_item.dart';
import '../logic.dart';

class RecordList extends StatelessWidget {
  RecordList({Key? key, required this.width, required this.height}) : super(key: key);
  final double width;
  final double height;
  final logic = Get.find<GamingRankLogic>();
  List<Widget> children() {
    final result = <Widget>[];
    for (int i = 0; i < logic.sortedRecords.length; i++) {
      final item = logic.sortedRecords[i];
      final widget = GestureDetector(
        onTapUp: (detail) {
          logic.clickItem(item.player.id);
        },
        child: RecordItem(
          width: width,
          nickname: item.player.nickname,
          rank: i + 1,
          score: item.score,
          avatarUrl: item.player.avatarUrl,
          playerId: item.player.id,
        ),
      );
      result.add(widget);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // color: Colors.cyanAccent,
      child: Column(
        children: children(),
      ),
    );
  }
}
