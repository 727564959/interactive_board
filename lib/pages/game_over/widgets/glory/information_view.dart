import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/game_over/logic.dart';

import '../../../../common.dart';

class WallViewPage extends StatelessWidget {
  WallViewPage({Key? key}) : super(key: key);
  final logic = Get.find<GameOverLogic>();

  List<Widget> get children {
    final result = <Widget>[];

    for (int i = 0; i < 4; i++) {}
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 1.0.sw,
          height: 0.5.sh,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children),
        ),
        SizedBox(height: 0.08.sh),
        _gloryCell(),
      ],
    );
  }
}

class _gloryCell extends StatelessWidget {
  const _gloryCell({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = 79.sp;
    return SizedBox(
      width: 1.0.sw,
      height: 1.0.sh,
      child: Stack(
        children: [],
      ),
    );
  }
}
