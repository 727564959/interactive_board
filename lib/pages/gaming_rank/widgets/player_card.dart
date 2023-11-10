import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../common.dart';
import '../../../widgets/hexagon_avatar.dart';

enum PlayerCardSize { large, middle, small }

String getAssetImageUrl(int position, String filename) {
  final team = position < 5 ? 0 : 1;
  return team == 0 ? "assets/images/team_wolf/$filename" : "assets/images/team_shark/$filename";
}

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
      return parentWidth * 0.47;
    } else if (size == PlayerCardSize.middle) {
      return parentWidth * 0.49;
    } else {
      return parentWidth * 0.7;
    }
  }

  double get height {
    if (size == PlayerCardSize.small) {
      return width * 1.23;
    } else if (size == PlayerCardSize.middle) {
      return width * 1.15;
    } else {
      return width;
    }
  }

  Alignment get contentAlignment {
    if (size == PlayerCardSize.small) {
      return Alignment.topCenter;
    } else {
      return const Alignment(0, 0);
    }
  }

  Widget get background {
    if (size == PlayerCardSize.small) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: width,
          height: height,
          child: Image.asset(
            getAssetImageUrl(position, "avatar/card_bg.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          getAssetImageUrl(position, "avatar/card_bg.png"),
          fit: BoxFit.fill,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background,
        SizedBox(
          width: width,
          height: height,
          child: Align(
            alignment: contentAlignment,
            child: _Content(
              width: parentWidth * 0.33,
              avatarUrl: avatarUrl,
              nickname: nickname,
              position: position,
            ),
          ),
        ),
      ],
    ).animate().scaleX();
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
    final deviceId = ascii.decode([position <= 4 ? 0x40 + position : 0x3c + position]);
    final team = position < 5 ? 0 : 1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HexagonAvatar(
          width: width,
          avatarUrl: avatarUrl,
          tag: nickname,
          team: team,
        ),
        SizedBox(height: width * 0.08),
        SizedBox(
          width: width * 0.43,
          height: width * 0.21,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(getAssetImageUrl(position, "avatar/vr_icon_white_bord.png")),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Center(
              child: Text(
                deviceId,
                style: Global.getNormalTextStyle(width * 0.11),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
