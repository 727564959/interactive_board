import '../../../common.dart';

class ResourceInfo {
  ResourceInfo({
    required this.id,
    required this.name,
    required this.url,
  });

  factory ResourceInfo.fromJson(Map<String, dynamic> json) {
    final path = json['attributes']["icon"]['data']['attributes']["formats"]["thumbnail"]['url'];
    final avatarUrl = "$baseStrapiUrl$path";
    return ResourceInfo(
      id: json['id'].toString(),
      name: json['attributes']['name'],
      url: avatarUrl,
    );
  }
  final String id;
  final String name;
  final String url;
}

class GameItemInfo {
  GameItemInfo({
    required this.id,
    required this.name,
    // required this.type,
    required this.icon,
    required this.level,
    required this.isLimited,
    this.isCardFlipped = false, // 设置默认值为false
  });

  factory GameItemInfo.fromJson(Map<String, dynamic> json) {
    // final icon = "$baseStrapiUrl${json["icon"]}";
    return GameItemInfo(
      id: json["id"],
      name: json["displayName"],
      // type: json["type"],
      // icon: icon,
      icon: json["icon"],
      level: json["level"],
      isLimited: json["isLimited"],
    );
  }
  final int id;
  final String name;
  // final String type;
  final int level;
  final String icon;
  final bool isLimited;
  bool isCardFlipped; // 新增的字段
}
