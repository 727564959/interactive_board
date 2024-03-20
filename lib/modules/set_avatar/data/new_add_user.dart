import '../../../common.dart';

class NewAddUser {
  NewAddUser({
    required this.userId,
    required this.showId,
    required this.showStatus,
  });
  final int? userId;
  final int? showId;
  final String showStatus;

  factory NewAddUser.fromJson(Map<String, dynamic> json) {
    return NewAddUser(
      userId: json['userId'],
      showId: json['showId'],
      showStatus: json['showStatus'],
    );
  }
  // Map<String, dynamic> toJson() => {
  //   'userId': userId,
  // };
}
