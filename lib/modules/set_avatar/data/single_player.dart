import '../../../common.dart';

class SinglePlayer {
  SinglePlayer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.headgearId,
    required this.headgearName,
    required this.bodyId,
    required this.bodyName,
  });
  final int id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String headgearId;
  final String headgearName;
  final String bodyId;
  final String bodyName;

  factory SinglePlayer.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "${baseStrapiUrl}${json['avatarUrl']}";
    return SinglePlayer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatarUrl: avatarUrl,
      headgearId: json['headgearId'],
      headgearName: json['headgearName'],
      bodyId: json['bodyId'],
      bodyName: json['bodyName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatarUrl': avatarUrl,
        'headgearId': headgearId,
        'headgearName': headgearName,
        'bodyId': bodyId,
        'bodyName': bodyName,
      };
}
