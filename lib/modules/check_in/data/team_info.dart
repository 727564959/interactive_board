import '../../../../common.dart';

class TeamInfo {
  TeamInfo({
    required this.name,
    required this.teamId,
    required this.iconPath,
  });
  final String name;
  final int teamId;
  final String iconPath;

  factory TeamInfo.fromStrapiJson(Map<String, dynamic> json) {
    final String iconPath = "$baseStrapiUrl${json['iconPath']}";

    return TeamInfo(
      name: json['name'],
      teamId: json['teamId'],
      iconPath: iconPath,
    );
  }

  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    final String iconPath = "$baseStrapiUrl${json['iconPath']}";

    return TeamInfo(
      name: json['name'],
      teamId: json['teamId'],
      iconPath: iconPath,
    );
  }
}
