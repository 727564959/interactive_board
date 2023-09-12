import 'package:flutter/material.dart';
import '../common.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HexagonAvatar extends StatelessWidget {
  const HexagonAvatar({
    Key? key,
    required this.size,
    required this.avatarUrl,
    this.tag,
  }) : super(key: key);
  final double size;
  final String? tag;
  final String avatarUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Image.asset(
              Global.getAssetImageUrl('avatar/white_background.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: const Alignment(-0.2, -0.1),
            child: SizedBox(
              width: size * 0.91,
              height: size * 0.91,
              child: ClipPath(
                clipper: _HexagonalClipper(),
                child: CachedNetworkImage(
                  imageUrl: avatarUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          if (tag != null)
            Align(
              alignment: const Alignment(0, 0.85),
              child: Container(
                width: size * 0.85,
                height: size * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Global.getAssetImageUrl("avatar/nickname_tag.png")),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Center(
                  child: Text(
                    tag!,
                    style: Global.getNormalTextStyle(size * 0.12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HexagonalClipper extends CustomClipper<Path> {
  _HexagonalClipper();

  @override
  Path getClip(Size size) {
    final side = size.height;
    final path = Path()
      ..lineTo(side * 0.25 * 0.27, side * 0.25)
      ..lineTo(side * 0.5, 0)
      ..lineTo(side * 0.25 * 3.73, side * 0.25)
      ..lineTo(side * 0.25 * 3.73, side * 0.75)
      ..lineTo(side * 0.5, side)
      ..lineTo(side * 0.25 * 0.27, side * 0.75)
      ..lineTo(side * 0.25 * 0.27, side * 0.25)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
