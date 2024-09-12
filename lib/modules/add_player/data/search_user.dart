import '../../../../common.dart';

class SearchUser {
  SearchUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  factory SearchUser.fromJson(Map<String, dynamic> json) {
    return SearchUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
