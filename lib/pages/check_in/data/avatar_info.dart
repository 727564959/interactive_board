class AvatarInfo {
  AvatarInfo({
    required this.id,
    required this.name,
    required this.url,
    required this.transparentBackgroundUrl,
  });

  factory AvatarInfo.fromJson(Map<String, dynamic> json) {
    final path = json['attributes']["avatar"]['data']['attributes']["formats"]["thumbnail"]['url'];
    final path1 =
        json['attributes']["transparentBackgroundAvatar"]['data']['attributes']["formats"]["thumbnail"]['url'];
    final avatarUrl = "http://10.1.4.13:1337$path";
    final transparentBackgroundUrl = "http://10.1.4.13:1337$path1";
    return AvatarInfo(
      id: json['id'].toString(),
      name: json['attributes']['name'],
      url: avatarUrl,
      transparentBackgroundUrl: transparentBackgroundUrl,
    );
  }
  final String id;
  final String name;
  final String url;
  final String transparentBackgroundUrl;
}
