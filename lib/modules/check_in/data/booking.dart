class Customer {
  String email;
  String name;
  String phone;
  Customer({
    required this.email,
    required this.name,
    required this.phone,
  });
}

class BookingInfo {
  DateTime bookingTime;
  Customer customer;
  BookingInfo({
    required this.bookingTime,
    required this.customer,
  });
  factory BookingInfo.fromJson(dynamic map) {
    final customerMap = map["customer"];
    final bookingTime = DateTime.parse(map["booking"]["time"]);
    final customer = Customer(
      email: customerMap["email"],
      name: customerMap["name"],
      phone: customerMap["phone"],
    );
    return BookingInfo(
      bookingTime: bookingTime,
      customer: customer,
    );
  }
}
