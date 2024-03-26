import '../../../common.dart';

class TeamInfo {
  final String name;
  final String icon;
  final String blackBorderIcon;
  String get iconPath => "$baseStrapiUrl$icon";
  TeamInfo({required this.name, required this.icon, required this.blackBorderIcon});
  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      name: json["attributes"]["name"],
      icon: json["attributes"]["icon"]["data"]["attributes"]["formats"]["small"]["url"],
      blackBorderIcon: json["attributes"]["blackBorderIcon"]["data"]["attributes"]["formats"]["small"]["url"],
    );
  }
}
