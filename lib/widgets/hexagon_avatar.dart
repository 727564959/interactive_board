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
        children: [
          Image.asset(
            Global.getAssetImageUrl('avatar/white_background.png'),
            fit: BoxFit.fill,
          ),
          Align(
            alignment: const Alignment(-1.17, -0.83),
            child: SizedBox(
              width: size * 0.72,
              height: size * 0.72,
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
              alignment: const Alignment(-1.0, 0.4),
              child: Container(
                width: size * 0.7,
                height: size * 0.14,
                // alignment: const Alignment(0, 1.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Global.getAssetImageUrl("avatar/nickname_tag.png")),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Text(
                    tag!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: size * 0.12),
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
