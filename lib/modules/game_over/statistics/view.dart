import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/check_in_title.dart';
import 'logic.dart';
import 'widgets/player_statistics.dart';
import 'widgets/team_statistics.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({Key? key}) : super(key: key);
  final logic = Get.find<StatisticsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              color: Colors.black,
            ),
            // 顶部文本信息
            CheckInTitlePage(titleText: logic.gameName),
            SizedBox(
              width: 1.0.sw,
              height: 1.0.sh,
              child: GetBuilder<StatisticsLogic>(
                id: "statisticsPage",
                builder: (logic) {
                  if (logic.pageState == PageState.playerStatistics) {
                    print("默认展示页面");
                    return PlayerStatisticsView(key: UniqueKey());
                  } else {
                    print("团队统计页面");
                    return TeamStatisticsView(key: UniqueKey());
                  }
                },
              ),
            ),
          ],
        ));
  }
}