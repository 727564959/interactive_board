import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../common.dart';
import '../../../widgets/hexagon_avatar.dart';

enum PlayerCardSize { large, middle, small }

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    Key? key,
    required this.parentWidth,
    required this.avatarUrl,
    required this.nickname,
    required this.position,
    required this.size,
  }) : super(key: key);
  final PlayerCardSize size;
  final double parentWidth;
  final String avatarUrl;
  final String nickname;
  final int position;

  double get width {
    if (size == PlayerCardSize.small) {
      return parentWidth * 0.4;
    } else if (size == PlayerCardSize.middle) {
      return parentWidth * 0.45;
    } else {
      return parentWidth * 0.6;
    }
  }

  double get height {
    if (size == PlayerCardSize.small) {
      return width * 1.15;
    } else if (size == PlayerCardSize.middle) {
      return width;
    } else {
      return width;
    }
  }

  Alignment get contentAlignment {
    if (size == PlayerCardSize.small) {
      return Alignment.topCenter;
    } else if (size == PlayerCardSize.middle) {
      return const Alignment(0, 0);
    } else {
      return const Alignment(0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              Global.getAssetImageUrl("avatar/card_bg.png"),
              width: width,
            ),
          ),
        ),
        SizedBox(
          width: width,
          height: height,
          child: Align(
            alignment: contentAlignment,
            child: _Content(
              width: parentWidth * 0.25,
              avatarUrl: avatarUrl,
              nickname: nickname,
              position: position,
            ),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.width,
    required this.avatarUrl,
    required this.nickname,
    required this.position,
  }) : super(key: key);

  final double width;
  final String avatarUrl;
  final String nickname;
  final int position;

  @override
  Widget build(BuildContext context) {
    final deviceId = ascii.decode([0x41 + position % 4 - 1]);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HexagonAvatar(
          width: width,
          avatarUrl: avatarUrl,
          tag: nickname,
        ),
        SizedBox(height: width * 0.1),
        SizedBox(
            width: width * 0.43,
            height: width * 0.21,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Global.getAssetImageUrl("avatar/vr_icon_white_bord.png")),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Center(
                child: Text(
                  deviceId,
                  style: Global.getNormalTextStyle(width * 0.11),
                ),
              ),
            )),
      ],
    );
  }
}
