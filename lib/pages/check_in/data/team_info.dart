import '../../../common.dart';

class TeamInfo {
  final String name;
  final String icon;
  TeamInfo({required this.name, required this.icon});
  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    final icon = "$baseStrapiUrl${json["attributes"]["icon"]["data"]["attributes"]["formats"]["small"]["url"]}";
    return TeamInfo(
      name: json["attributes"]["name"],
      icon: icon,
    );
  }
}
