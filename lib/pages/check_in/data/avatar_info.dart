class AvatarInfo {
  AvatarInfo({
    required this.id,
    required this.name,
    required this.url,
  });

  factory AvatarInfo.fromJson(Map<String, dynamic> json) {
    final path = json['attributes']["avatar"]['data']['attributes']["formats"]["thumbnail"]['url'];
    final String avatarUrl = "http://10.1.4.13:1337$path";
    return AvatarInfo(
      id: json['id'].toString(),
      name: json['attributes']['name'],
      url: avatarUrl,
    );
  }
  final String id;
  final String name;
  final String url;
}
