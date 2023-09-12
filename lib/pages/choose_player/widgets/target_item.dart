import 'package:flutter/material.dart';
import 'package:interactive_board/common.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TargetItem extends StatelessWidget {
  const TargetItem({Key? key, required this.width, required this.deviceId}) : super(key: key);
  final double width;
  final String deviceId;
  @override
  Widget build(BuildContext context) {
    final height = width * 1.45;
    return _NullTarget(
      width: width,
      height: height,
      deviceId: deviceId,
    );
  }
}

class _NullTarget extends StatefulWidget {
  const _NullTarget({Key? key, required this.deviceId, required this.width, required this.height}) : super(key: key);
  final String deviceId;
  final double width;
  final double height;
  @override
  State<_NullTarget> createState() => _NullTargetState();
}

class _NullTargetState extends State<_NullTarget> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width;
    final height = widget.height;
    final deviceId = widget.deviceId;
    return DragTarget(
      onWillAccept: (data) {
        controller.forward();
        return false;
      },
      onLeave: (data) {
        controller.reverse();
      },
      builder: (context, candidateData, rejectedData) {
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              SizedBox(
                width: width,
                child: Image.asset(
                  Global.getAssetImageUrl('avatar/no_one.png'),
                  fit: BoxFit.fitWidth,
                ),
              ).animate(autoPlay: false, controller: controller).scale(
                    duration: 100.ms,
                    curve: Curves.decelerate,
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(0.7, 0.7),
                  ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: width * 0.43,
                  height: height * 0.17,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Global.getAssetImageUrl("avatar/vr_icon.png")),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        deviceId,
                        style: Global.getNormalTextStyle(width * 0.11),
                      ),
                    ),
                  ).animate(autoPlay: false, controller: controller).scale(
                        duration: 100.ms,
                        curve: Curves.decelerate,
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(0.0, 0.0),
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
