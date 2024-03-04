import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KmTimer extends StatefulWidget {

  @override
  State<KmTimer> createState() => _KmTimerState();

  void cancel() {}

}

class _KmTimerState extends State<KmTimer> {
  //时间日期开始
  late Timer _timer;
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    this._timer = new Timer.periodic(Duration (seconds: 1), setTime);
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

  var weekday = [" ","星期一","星期二","星期三","星期四","星期五","星期六","星期日"];
  // 时间日期结束

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 200)
            ),
            Text(
              // "${dateTime.hour}:${dateTime.minute.toString().padLeft(2,'0')}:${dateTime.second.toString().padLeft(2,'0')}",
              "${dateTime.hour}:${dateTime.minute.toString().padLeft(2,'0')}",
                style: TextStyle(
                  fontSize: 32.sp,
                  decoration: TextDecoration.none,
                  fontFamily: 'BurbankBold',
                  color: Colors.white,
                  letterSpacing: 3.sp,
                ),
            ),
            // Padding(
            //     padding: EdgeInsets.only(left: 20)
            // ),
            // Text(
            //   "${weekday[dateTime.weekday]}",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 18
            //   ),
            // ),
            // Padding(
            //     padding: EdgeInsets.only(left: 20)
            // ),
            // Text(
            //   "${dateTime.year}/${dateTime.month}/${dateTime.day}",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 18
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}