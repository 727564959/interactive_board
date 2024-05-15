import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../mirra_style.dart';

class CustomCountdown extends StatefulWidget {
  final Duration duration;
  final Function? onCountdownComplete;
  final bool start;
  final Color color;

  const CustomCountdown({
    Key? key,
    required this.duration,
    this.onCountdownComplete,
    this.start = false,
    required this.color,
  }) : super(key: key);

  @override
  _CustomCountdownState createState() => _CustomCountdownState();
}

class _CustomCountdownState extends State<CustomCountdown> {
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration.inSeconds;
    if (widget.start) {
      startCountdown();
    }
  }

  void startCountdown() {
    if (_timer != null && _timer!.isActive) {
      return; // Countdown is already running
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds -= 1;
        if (_remainingSeconds <= 0) {
          stopCountdown();
          widget.onCountdownComplete?.call();
        }
      });
    });
  }

  void stopCountdown() {
    _timer?.cancel();
  }

  void resetCountdown() {
    stopCountdown();
    setState(() {
      _remainingSeconds = widget.duration.inSeconds;
    });
  }

  @override
  void didUpdateWidget(CustomCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.start != oldWidget.start) {
      if (widget.start) {
        startCountdown();
      } else {
        // stopCountdown();
        resetCountdown();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '($_remainingSeconds s)',
      style: CustomTextStyles.button(color: widget.color, fontSize: 28.sp),
    );
    // return Column(
    //   children: [
    //     Text(
    //       '( $_remainingSeconds s )',
    //       style: CustomTextStyles.button(color: widget.color, fontSize: 28.sp),
    //     ),
    //   ],
    // );
  }
}