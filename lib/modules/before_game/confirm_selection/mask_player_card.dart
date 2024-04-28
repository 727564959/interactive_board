import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../common.dart';
import '../../../widgets/player_card.dart';

class MaskPlayerCard extends StatelessWidget {
  const MaskPlayerCard({
    Key? key,
    required this.avatarUrl,
    required this.nickname,
    required this.width,
    required this.position,
    required this.bMask,
  }) : super(key: key);
  final String avatarUrl;
  final String nickname;
  final double width;
  final int position;
  final bool bMask;
  @override
  Widget build(BuildContext context) {
    return AvatarCard(
      labelColor: bMask ? const Color(0xffDBE2E3) : const Color(0xfff0f0f0),
      title: nickname,
      subTitle: Global.getDeviceName(position),
      width: width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: CachedNetworkImage(
              fadeInDuration: 0.ms,
              imageUrl: avatarUrl,
              height: width,
              fit: BoxFit.fitHeight,
            ),
          ),
          if (bMask)
            Container(
              width: width,
              height: width,
              color: const Color(0x907B7B7B),
            ),
        ],
      ),
    );
  }
}
