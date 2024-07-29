class Customer {
  int userId;
  String email;
  String phone;
  String name;
  String firstName;
  String lastName;
  Customer({
    required this.userId,
    required this.email,
    required this.phone,
    required this.name,
    required this.firstName,
    required this.lastName,
  });

  factory Customer.fromJson(dynamic json) {
    return Customer(
      userId: json['id'],
      email: json['email'],
      phone: json['telephone'],
      name: json['firstName'] + " " + json['lastName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class BookingState {
  BookingState({
    required this.transactionId,
    required this.bookingId,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    this.tableId,
    required this.customer,
  });
  final int transactionId;
  final int bookingId;
  final String bookingDate;
  final String bookingTime;
  final String status;
  final int? tableId;
  Customer customer;

  factory BookingState.fromJson(Map<String, dynamic> json) {
    return BookingState(
      bookingId: json['id'],
      transactionId: json['transactionId'],
      bookingDate: json['bookingDate'],
      bookingTime: json['bookingTime'],
      status: json['status'],
      tableId: json['tableId'],
      customer: Customer.fromJson(json['customer']),
    );
  }

  // factory BookingState.fromJson(dynamic map) {
  //   final customerMap = map["customer"];
  //   final transactionId = map["bookings"]["transactionId"];
  //   final bookingId = map["bookings"]["bookingId"];
  //   final bookingDate = map["bookings"]["bookingDate"];
  //   final bookingTime = map["bookings"]["bookingTime"];
  //   final status = map["bookings"]["status"];
  //   final tableId = map["bookings"]["tableId"];
  //   final customer = Customer(
  //     userId: customerMap["userId"],
  //     email: customerMap["email"],
  //     phone: customerMap["phone"],
  //     firstName: customerMap["firstName"],
  //     lastName: customerMap["lastName"],
  //   );
  //   return BookingState(
  //     transactionId: transactionId,
  //     bookingId: bookingId,
  //     bookingDate: bookingDate,
  //     bookingTime: bookingTime,
  //     status: status,
  //     tableId: tableId,
  //     customer: customer,
  //   );
  // }
}
// {
// "bookings": [
// {
// "id": 51,
// "transactionId": 51,
// "bookingDate": "2024-07-23",
// "bookingTime": "18:00:00",
// "during": 60,
// "quantity": 1,
// "status": "pending",
// "tableId": null,
// "customerId": 15,
// "createTime": "2024-07-23T10:58:53.268Z",
// "updateTime": "2024-07-23T10:58:53.268Z",
// "customer": {
// "id": 15,
// "firstName": "Test",
// "lastName": "Cs",
// "telephone": "1213454545",
// "email": "danny.luo@miraverse.net",
// "createTime": "2024-07-23T10:58:53.268Z",
// "updateTime": "2024-07-23T10:58:53.268Z"
// }
// }
// ]
// }