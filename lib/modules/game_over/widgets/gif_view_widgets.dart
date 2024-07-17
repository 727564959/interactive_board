import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_board/3rd_libs/gif_view-0.4.3/gif_view.dart';

import '../../../../mirra_style.dart';

class GifViewWidgets extends StatefulWidget {
  const GifViewWidgets({
    Key? key,
    required this.gifName,
    required this.height,
    required this.frameRate,
    this.delay,
    this.periodicTime}) : super(key: key);
  final String gifName;
  final double height;
  final int frameRate;
  final Duration? delay;
  final Duration? periodicTime;
  @override
  State<GifViewWidgets> createState() => _GifViewWidgetsState();
}

class _GifViewWidgetsState extends State<GifViewWidgets> {
  late final GifController gifController = GifController(autoPlay: false, loop: false);
  late final Timer timer;

  String get gifName => widget.gifName;
  double get height => widget.height;
  int get frameRate => widget.frameRate;
  Duration get delay => widget.delay ?? 0.ms;
  // Duration get periodicTime => 1200.ms;
  Duration get periodicTime => widget.periodicTime ?? 1000.ms;

  @override
  void initState() {
    Future.delayed(delay).then((value) {
      timer = Timer.periodic(periodicTime, (timer) async {
        gifController.play();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GifView.asset(
      MirraIcons.getGifPath(gifName),
      fadeDuration: 0.ms,
      height: height,
      fit: BoxFit.fitHeight,
      frameRate: frameRate,
      controller: gifController,
    );
  }
}