import '../../../common.dart';

class PlayerCardInfo {
  PlayerCardInfo({
    this.userId,
    this.nickname,
    this.bTemped,
    this.bShowRegisterDialog,
    this.avatarId,
    this.avatarIcon,
    this.avatarName,
    this.avatarLevel,
    this.bodyId,
    this.bodyIcon,
    this.bodyName,
    this.bodyLevel,
    required this.isUserCard,
  });

  factory PlayerCardInfo.fromJson(Map<String, dynamic> json) {
    // final avatarIcon = "$baseStrapiUrl${json["avatarIcon"]}";
    // final bodyIcon = "$baseStrapiUrl${json["bodyIcon"]}";
    return PlayerCardInfo(
      userId: json['userId'],
      nickname: json['nickname'],
      bTemped: json['bTemped'] != null ? json['bTemped'] : true,
      bShowRegisterDialog: json['bShowRegisterDialog'] != null ? json['bShowRegisterDialog'] : true,
      avatarId: json["avatarId"],
      avatarIcon: json["avatarIcon"],
      avatarName: json["avatarName"],
      avatarLevel: json["avatarLevel"],
      bodyId: json["bodyId"],
      bodyIcon: json["bodyIcon"],
      bodyName: json["bodyName"],
      bodyLevel: json["bodyLevel"],
      isUserCard: true,
    );
  }
  final int? userId;
  final String? nickname;
  final bool? bTemped;
  final bool? bShowRegisterDialog;
  final int? avatarId;
  final String? avatarIcon;
  final String? avatarName;
  final int? avatarLevel;
  final int? bodyId;
  final String? bodyIcon;
  final String? bodyName;
  final int? bodyLevel;
  final bool isUserCard;
}