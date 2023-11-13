import '../../charts/bar_chart.dart';
import 'package:flutter/material.dart';

import '../../common.dart';
import '../../widgets/game_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Bar chart example
// import 'package:charts_flutter/flutter.dart' as charts;

import 'logic.dart';

class BarChartPage extends StatelessWidget {
  BarChartPage({super.key});
  final logic = Get.find<GameStatisticsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 1.0.sw,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Global.getAssetImageUrl("background.png")),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          GameTitleWidget(gameName: logic.gameName, width: 0.45.sw, bAnimate: false),
          const SizedBox(height: 80),
          _ChartView(),
        ],
      ),
    ));

    // return const BarChart(
    //   max: 6000.0,
    //   data: [
    //     {
    //       "label": "table1",
    //       "value": 280.0,
    //     },
    //     {
    //       "label": "table2",
    //       "value": 300.0,
    //     },
    //     {
    //       "label": "table3",
    //       "value": 220.0,
    //     },
    //     {
    //       "label": "table4",
    //       "value": 380.0,
    //     },
    //     {
    //       "label": "table5",
    //       "value": 520.0,
    //     },
    //     {
    //       "label": "table6",
    //       "value": 220.0,
    //     },
    //     {
    //       "label": "table7",
    //       "value": 380.0,
    //     },
    //     {
    //       "label": "table8",
    //       "value": 520.0,
    //     },
    //   ],
    //   xAxis: [
    //     'table1',
    //     'table2',
    //     'table3',
    //     'table4',
    //     'table5',
    //     'table6',
    //     'table7',
    //     'table8'
    //   ],
    // );
  }
}

class _ChartView extends StatelessWidget {
  const _ChartView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const BarChart(
      max: 600.0,
      data: [
        {
          "label": "table1",
          "value": 280.0,
        },
        {
          "label": "table2",
          "value": 300.0,
        },
        {
          "label": "table3",
          "value": 220.0,
        },
        {
          "label": "table4",
          "value": 380.0,
        },
        {
          "label": "table5",
          "value": 520.0,
        },
        {
          "label": "table6",
          "value": 220.0,
        },
        {
          "label": "table7",
          "value": 380.0,
        },
        {
          "label": "table8",
          "value": 520.0,
        },
      ],
      xAxis: ['table1', 'table2', 'table3', 'table4', 'table5', 'table6', 'table7', 'table8'],
    );
  }
}
