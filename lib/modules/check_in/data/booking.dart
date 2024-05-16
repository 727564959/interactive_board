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
  String status;
  String? tableId;
  String? showId;
  Customer customer;
  BookingInfo({
    required this.bookingTime,
    required this.status,
    this.tableId,
    this.showId,
    required this.customer,
  });
  factory BookingInfo.fromJson(dynamic map) {
    final customerMap = map["customer"];
    final bookingTime = DateTime.parse(map["booking"]["time"]);
    final status = map["booking"]["status"];
    final tableId = map["booking"]["tableId"];
    final showId = map["booking"]["showId"];
    final customer = Customer(
      email: customerMap["email"],
      name: customerMap["name"],
      phone: customerMap["phone"],
    );
    return BookingInfo(
      bookingTime: bookingTime,
      status: status,
      tableId: tableId,
      showId: showId,
      customer: customer,
    );
  }
}
