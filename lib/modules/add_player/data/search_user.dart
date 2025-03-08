import '../../../../common.dart';

// class SearchUser {
//   SearchUser({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//   });
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phone;
//
//   factory SearchUser.fromJson(Map<String, dynamic> json) {
//     return SearchUser(
//       id: json['id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       phone: json['telephone'],
//     );
//   }
// }
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
    // final gameResource = json['gameResource'];
    final customization = json['customization'];
    final headgear = json['customization']['headgear'];
    // final String avatarUrl = "$baseStrapiUrl${json['avatarUrl']}";
    return SearchUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['telephone'],
    );
  }
}
