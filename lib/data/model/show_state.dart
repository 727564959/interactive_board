enum ShowStatus {
  waiting,
  showPreparing,
  gamePreparing,
  gaming,
  complete;

  factory ShowStatus.status(String status) {
    if (status == "waiting") {
      return ShowStatus.waiting;
    } else if (status == "show_preparing") {
      return ShowStatus.showPreparing;
    } else if (status == "game_preparing") {
      return ShowStatus.gamePreparing;
    } else if (status == "gaming") {
      return ShowStatus.gaming;
    } else if (status == "complete") {
      return ShowStatus.complete;
    }
    throw TypeError();
  }
}

class ShowState {
  ShowState({
    required this.showId,
    required this.status,
    required this.details,
  });
  final int? showId;
  final ShowStatus status;
  final dynamic details;
  factory ShowState.fromJson(Map<String, dynamic> json) {
    late final dynamic details;
    final status = ShowStatus.status(json['status']);

    if (status == ShowStatus.waiting) {
      details = null;
    } else if (status == ShowStatus.showPreparing) {
      final detailsData = json['details'];
      final startTime = DateTime.parse(detailsData["startTime"]);
      final customers = <CustomerItem>[];
      for (final item in detailsData["customers"]) {
        customers.add(CustomerItem(userId: item["consumerId"], tableId: item["tableId"]));
      }
      details = ShowPreparingDetails(
        showId: detailsData["showId"],
        startTime: startTime,
        mode: detailsData["mode"],
        customers: customers,
      );
    } else {
      final detailsData = json['details'];
      details = GamingDetails(
        showId: detailsData["showId"],
        roundId: detailsData["roundId"],
        roundNumber: detailsData["roundNumber"],
        mode: detailsData["mode"],
        game: detailsData["game"],
      );
    }

    return ShowState(
      showId: json['showId'],
      status: status,
      details: details,
    );
  }
}

class ShowPreparingDetails {
  ShowPreparingDetails({
    required this.showId,
    required this.startTime,
    required this.mode,
    required this.customers,
  });
  final int showId;
  final DateTime startTime;
  final String mode;
  final List<CustomerItem> customers;
}

class GamingDetails {
  GamingDetails({
    required this.showId,
    required this.roundId,
    required this.roundNumber,
    required this.mode,
    required this.game,
  });
  final int showId;
  final int roundId;
  final int roundNumber;
  final String mode;
  final String game;
}

class CustomerItem {
  int userId;
  int tableId;
  CustomerItem({required this.userId, required this.tableId});
}
