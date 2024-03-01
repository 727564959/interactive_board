class Customer {
  String email;
  String name;
  String telephone;
  Customer({
    required this.email,
    required this.name,
    required this.telephone,
  });
}

class VerifyInfo {
  DateTime startingTime;
  int showId;
  int transactionId;
  int bookingId;
  Customer customer;
  VerifyInfo({
    required this.startingTime,
    required this.showId,
    required this.transactionId,
    required this.bookingId,
    required this.customer,
  });
  factory VerifyInfo.fromJson(dynamic map) {
    final customerMap = map["customer"];
    final startingTime = DateTime.parse(map["startingTime"]);
    final customer = Customer(
      email: customerMap["email"],
      name: customerMap["name"],
      telephone: customerMap["telephone"],
    );
    return VerifyInfo(
      startingTime: startingTime,
      showId: map["showId"],
      transactionId: map["transactionId"],
      bookingId: map["bookingId"],
      customer: customer,
    );
  }
}
