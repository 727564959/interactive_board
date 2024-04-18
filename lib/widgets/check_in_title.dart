import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common.dart';
import 'dart:async';

import '../mirra_style.dart';

class CheckInTitlePage extends StatelessWidget {
  CheckInTitlePage({
    Key? key,
    required this.titleText,
  }) : super(key: key);
  final String titleText;
  // Color get color {
  //   if (Global.tableId == 1) {
  //     return const Color(0xFFEF7E00);
  //   } else if (Global.tableId == 2) {
  //     return const Color(0xFFE11988);
  //   } else if (Global.tableId == 3) {
  //     return const Color(0xFF50C68E);
  //   } else {
  //     return const Color(0xFF4091F0);
  //   }
  // }
  String get bayString {
      if (Global.tableId == 1) {
        return "A";
      } else if (Global.tableId == 2) {
        return "B";
      } else if (Global.tableId == 3) {
        return "C";
      } else {
        return "D";
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.red,
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      margin: EdgeInsets.only(top: 20.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 1.0.sw, height: 100.sp), //卡片大小
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 0.0, left: 60.0),
            child: Text(
              titleText,
              style: CustomTextStyles.title(color: Colors.white, fontSize: 60.sp, level: 2),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0.0, right: 60.0),
            constraints: BoxConstraints.tightFor(width: 0.15.sw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentTimer(),
                Text(
                  // "Bay " + Global.tableId.toString(),
                  "Bay " + bayString,
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentTimer extends StatefulWidget {
  const CurrentTimer({Key? key});

  @override
  _CurrentTimerState createState() => _CurrentTimerState();
}

class _CurrentTimerState extends State<CurrentTimer> {
  //时间日期开始
  late Timer _timer;
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    this._timer = new Timer.periodic(Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}",
      style: CustomTextStyles.textSmall(color: Colors.white, fontSize: 30.sp),
    );
  }
}
