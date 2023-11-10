import 'package:flutter/material.dart';
import '../common.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HexagonAvatar extends StatelessWidget {
  const HexagonAvatar({
    Key? key,
    required this.width,
    required this.avatarUrl,
    this.tag,
    this.team,
  }) : super(key: key);
  final double width;
  final String? tag;
  final String avatarUrl;
  final int? team;
  @override
  Widget build(BuildContext context) {
    // 正六边形的长为宽的2*√3/3倍
    final height = width * 1.155;
    late final String tagUri;
    if (team == null) {
      tagUri = Global.getAssetImageUrl("avatar/nickname_tag.png");
    } else if (team == 0) {
      tagUri = "assets/images/team_wolf/avatar/nickname_tag.png";
    } else {
      tagUri = "assets/images/team_shark/avatar/nickname_tag.png";
    }
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
              Global.getAssetImageUrl('avatar/white_background.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: const Alignment(-0.2, -0.1),
            child: ClipPath(
              clipper: _HexagonalClipper(),
              child: SizedBox(
                height: height * 0.9,
                width: width * 0.9,
                child: CachedNetworkImage(
                  imageUrl: avatarUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          if (tag != null)
            Align(
              alignment: const Alignment(0, 0.85),
              child: Container(
                width: width * 0.95,
                height: width * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(tagUri),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Center(
                  child: Text(
                    tag!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.17,
                      decoration: TextDecoration.none,
                      fontFamily: 'BurbankBold',
                      color: Colors.white,
                    ),
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
    final h = size.height;
    final w = size.width;
    final path = Path()
      ..lineTo(0, h * 0.25)
      ..lineTo(0, h * 0.75)
      ..lineTo(0.5 * w, h)
      ..lineTo(w, h * 0.75)
      ..lineTo(w, h * 0.25)
      ..lineTo(0.5 * w, 0)
      ..lineTo(0, h * 0.25)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
