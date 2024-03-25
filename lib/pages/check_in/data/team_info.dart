import '../../../common.dart';

class TeamInfo {
  final String name;
  final String icon;
  String get iconPath => "$baseStrapiUrl$icon";
  TeamInfo({required this.name, required this.icon});
  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      name: json["attributes"]["name"],
      icon: json["attributes"]["icon"]["data"]["attributes"]["formats"]["small"]["url"],
    );
  }
}
