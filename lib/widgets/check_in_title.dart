import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common.dart';
import 'dart:async';

import '../mirra_style.dart';

class CheckInTitlePage extends StatelessWidget {
  CheckInTitlePage({
    Key? key,
    required this.titleText,
    this.tableId,
  }) : super(key: key);
  final String titleText;
  final int? tableId;

  String get bayString {
    if(tableId != null) {
      if (tableId == 1) {
        return "A";
      } else if (tableId == 2) {
        return "B";
      } else if (tableId == 3) {
        return "C";
      } else {
        return "D";
      }
    }
    else {
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
            margin: EdgeInsets.only(top: 0.0, left: 40.0),
            child: Text(
              titleText,
              style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0.0, right: 60.0),
            constraints: BoxConstraints.tightFor(width: 0.15.sw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentTimer(),
                Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Bay " + bayString,
                    style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 3),
                  ),
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
      style: CustomTextStyles.textNormal(color: Colors.white, fontSize: 30.sp),
    );
  }
}
