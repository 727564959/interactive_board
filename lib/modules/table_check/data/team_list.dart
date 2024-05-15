import '../../../../common.dart';

class TeamList {
  TeamList({
    required this.name,
    required this.teamId,
    required this.iconPath,
  });
  final String name;
  final int teamId;
  final String iconPath;

  factory TeamList.fromStrapiJson(Map<String, dynamic> json) {
    final String iconPath = "$baseStrapiUrl${json['iconPath']}";

    return TeamList(
      name: json['name'],
      teamId: json['teamId'],
      iconPath: iconPath,
    );
  }

  factory TeamList.fromJson(Map<String, dynamic> json) {
    final String iconPath = "$baseStrapiUrl${json['iconPath']}";

    return TeamList(
      name: json['name'],
      teamId: json['teamId'],
      iconPath: iconPath,
    );
  }
}