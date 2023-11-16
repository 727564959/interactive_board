import 'package:flutter/material.dart';
import '../common.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ParallelogramAvatar extends StatelessWidget {
  const ParallelogramAvatar({
    Key? key,
    required this.width,
    required this.avatarUrl,
    required this.isRequest,
  }) : super(key: key);
  final double width;
  final String avatarUrl;
  final bool isRequest;
  @override
  Widget build(BuildContext context) {
    // 正六边形的长为宽的2*√3/3倍
    final height = width * 0.8;
    // print("宽: $width");
    // print("高度: $height");
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Image.asset(
              Global.getCheckInImageUrl('black_background.png'),
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: const Alignment(-0.2, -0.1),
            child: ClipPath(
              clipper: _ParallelogramClipper(),
              child: SizedBox(
                height: height,
                width: width,
                child: isRequest
                    ? CachedNetworkImage(
                        imageUrl: avatarUrl,
                        fit: BoxFit.fitHeight,
                      )
                    : Image.asset(
                        Global.getCheckInImageUrl(avatarUrl),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParallelogramClipper extends CustomClipper<Path> {
  _ParallelogramClipper();

  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;
    final path = Path()
      ..lineTo(0, h * 0.2)
      ..lineTo(0.15 * w, h * 0.8)
      ..lineTo(w, h * 0.8)
      ..lineTo(0.85 * w, h * 0.2)
      ..lineTo(0, h * 0.2)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
