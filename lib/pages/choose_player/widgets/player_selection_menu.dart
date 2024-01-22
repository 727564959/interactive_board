import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'target_item.dart';
import '../logic.dart';

class PlayerSelectionMenu extends StatelessWidget {
  PlayerSelectionMenu({Key? key, required this.width}) : super(key: key);
  final double width;
  final logic = Get.find<ChoosePlayerLogic>();
  double get itemWidth => width * 0.16;
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    for (final position in logic.selectedPlayers.keys) {
      children.add(
        GetBuilder<ChoosePlayerLogic>(
          builder: (logic) {
            return TargetItem(
              width: itemWidth,
              deviceId: ascii.decode([0x40 + position]),
              position: position,
            );
          },
        ),
      );
    }
    if (children.length <= 4) {
      return SizedBox(
        width: width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      );
    } else {
      return SizedBox(
        width: width,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children.getRange(0, 4).toList(),
            ),
            SizedBox(height: 20.w),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children.getRange(4, children.length).toList(),
            ),
          ],
        ),
      );
    }
  }
}
