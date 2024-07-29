import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreathingScaleImage extends StatefulWidget {
  final String imagePath;
  final int? duration;
  final double? beginSize;
  final double? endSize;

  BreathingScaleImage({required this.imagePath, this.duration, this.beginSize, this.endSize});

  @override
  _BreathingScaleImageState createState() => _BreathingScaleImageState();
}

class _BreathingScaleImageState extends State<BreathingScaleImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  int get duration => widget.duration ?? 1000;
  double get beginSize => widget.beginSize ?? 0.7;
  double get endSize => widget.endSize ?? 1.3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: beginSize, end: endSize).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}