class SinglePlayer {
  SinglePlayer({
    required this.id,
    required this.nickname,
    required this.email,
    required this.phone,
  });
  final int id;
  final String nickname;
  final String email;
  final String phone;

  factory SinglePlayer.fromJson(Map<String, dynamic> json) {
    return SinglePlayer(
      id: json['id'],
      nickname: json['nickname'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nickname': nickname,
    'email': email,
    'phone': phone,
  };
}
