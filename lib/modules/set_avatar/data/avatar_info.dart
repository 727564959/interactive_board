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
