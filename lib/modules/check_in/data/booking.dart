class Customer {
  String email;
  String name;
  String phone;
  String firstName;
  String lastName;
  Customer({
    required this.email,
    required this.name,
    required this.phone,
    required this.firstName,
    required this.lastName,
  });
}

class BookingInfo {
  // DateTime bookingTime;
  String bookingTime;
  String status;
  String? tableId;
  String? showId;
  String bookingDate;
  String bookingEnd;
  int duration;
  String timezone;
  Customer customer;
  BookingInfo({
    required this.bookingTime,
    required this.status,
    this.tableId,
    this.showId,
    required this.bookingDate,
    required this.bookingEnd,
    required this.duration,
    required this.timezone,
    required this.customer,
  });
  factory BookingInfo.fromJson(dynamic map) {
    final customerMap = map["customer"];
    // final bookingTime = DateTime.parse(map["booking"]["time"]);
    final bookingTime = map["booking"]["bookingTime"];
    final status = map["booking"]["status"];
    final tableId = map["booking"]["tableId"];
    final showId = map["booking"]["showId"];
    final bookingDate = map["booking"]["bookingDate"];
    final bookingEnd = map["booking"]["bookingEnd"];
    final duration = map["booking"]["duration"];
    final timezone = map["booking"]["timezone"];
    final customer = Customer(
      email: customerMap["email"],
      name: customerMap["name"],
      phone: customerMap["phone"],
      firstName: customerMap["firstName"],
      lastName: customerMap["lastName"],
    );
    return BookingInfo(
      bookingTime: bookingTime,
      status: status,
      tableId: tableId,
      showId: showId,
      bookingDate: bookingDate,
      bookingEnd: bookingEnd,
      duration: duration,
      timezone: timezone,
      customer: customer,
    );
  }
}
