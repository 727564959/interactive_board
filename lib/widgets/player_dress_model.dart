import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlayerDressModel extends StatelessWidget {
  const PlayerDressModel({
    Key? key,
    required this.headgearUrl,
    required this.bodyUrl,
    required this.width,
  }) : super(key: key);
  final String headgearUrl;
  final String bodyUrl;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width * 1.64,
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-0.9, 1.0),
            child: SizedBox(
              width: width * 0.8,
              height: width * 1.347,
              child: CachedNetworkImage(
                imageUrl: bodyUrl,
                fit: BoxFit.fitWidth,
                width: width * 0.8,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -1.0),
            child: SizedBox(
              width: width * 0.4,
              height: width * 0.4,
              child: CachedNetworkImage(
                imageUrl: headgearUrl,
                fit: BoxFit.fitWidth,
                width: width * 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
