import '../../../common.dart';

class NewAddUser {
  NewAddUser({
    required this.userId,
    required this.showId,
    required this.status,
  });
  final int? userId;
  final int? showId;
  final String? status;

  factory NewAddUser.fromJson(Map<String, dynamic> json) {
    return NewAddUser(
      userId: json['userId'],
      showId: json['showId'],
      status: json['status'],
    );
  }
}
