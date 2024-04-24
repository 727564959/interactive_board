import '../../../common.dart';

class CasualUser {
  CasualUser({
    required this.userId,
    required this.nickname,
    required this.bTemped,
    required this.bShowRegisterDialog,
  });
  final int userId;
  final String nickname;
  final bool? bTemped;
  final bool? bShowRegisterDialog;

  factory CasualUser.fromStrapiJson(Map<String, dynamic> json) {
    return CasualUser(
      userId: json['userId'],
      nickname: json['nickname'],
      bTemped: json['bTemped'] != null ? json['bTemped'] : true,
      bShowRegisterDialog: json['bShowRegisterDialog'] != null ? json['bShowRegisterDialog'] : true,
    );
  }

  factory CasualUser.fromJson(Map<String, dynamic> json) {
    return CasualUser(
      userId: json['userId'],
      nickname: json['nickname'],
      bTemped: json['bTemped'] != null ? json['bTemped'] : true,
      bShowRegisterDialog: json['bShowRegisterDialog'] != null ? json['bShowRegisterDialog'] : true,
    );
  }
}
