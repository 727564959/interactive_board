import '../../../common.dart';

class TeamInfo {
  final String name;
  final String icon;
  final String noBorderIcon;
  String get iconPath => "$baseStrapiUrl$icon";
  TeamInfo({required this.name, required this.icon, required this.noBorderIcon});
  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      name: json["attributes"]["name"],
      icon: json["attributes"]["icon"]["data"]["attributes"]["formats"]["small"]["url"],
      noBorderIcon: json["attributes"]["noBorderIcon"]["data"]["attributes"]["formats"]["small"]["url"],
    );
  }
}
