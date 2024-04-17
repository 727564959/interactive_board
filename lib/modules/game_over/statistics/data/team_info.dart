import '../../../../common.dart';

class TeamInfo {
  TeamInfo({
    required this.name,
    required this.teamId,
    required this.iconPath,
    required this.blackBorderIconPath,
  });
  final String name;
  final int teamId;
  final String iconPath;
  final String blackBorderIconPath;

  factory TeamInfo.fromStrapiJson(Map<String, dynamic> json) {
    final String iconPath = "$baseStrapiUrl${json['iconPath']}";
    final String blackBorderIconPath = "$baseStrapiUrl${json['blackBorderIconPath']}";

    return TeamInfo(
      name: json['name'],
      teamId: json['teamId'],
      iconPath: iconPath,
      blackBorderIconPath: blackBorderIconPath,
    );
  }

  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    final String iconPath = "$baseStrapiUrl${json['iconPath']}";
    final String blackBorderIconPath = "$baseStrapiUrl${json['blackBorderIconPath']}";

    return TeamInfo(
      name: json['name'],
      teamId: json['teamId'],
      iconPath: iconPath,
      blackBorderIconPath: blackBorderIconPath,
    );
  }
}
