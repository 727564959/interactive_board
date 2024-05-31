import 'package:interactive_board/pages/check_in/data/team_info.dart';

enum ShowStatus {
  waiting,
  choosePlayer,
  gamePreparing,
  gaming,
  complete;

  factory ShowStatus.status(String status) {
    if (status == "waiting") {
      return ShowStatus.waiting;
    } else if (status == "choose_player") {
      return ShowStatus.choosePlayer;
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
    } else if (status == ShowStatus.gamePreparing) {
      final detailsData = json['details'];
      final startTime = DateTime.parse(detailsData["startDate"] + " " + detailsData["startTime"]);
      final customers = <CustomerItem>[];
      for (final item in detailsData["customers"]) {
        customers.add(CustomerItem(userId: item["consumerId"], tableId: item["tableId"]));
      }
      final teams = <TeamItem>[];
      for (final item in detailsData["teams"]) {
        teams.add(
          TeamItem(
            teamId: item["teamId"],
            name: item["name"],
            icon: item["iconPath"],
          ),
        );
      }
      details = ShowPreparingDetails(
        showId: detailsData["showId"],
        startTime: startTime,
        mode: detailsData["mode"],
        customers: customers,
        teams: teams,
      );
    } else {
      final detailsData = json['details'];
      final customers = <CustomerItem>[];
      for (final item in detailsData["customers"]) {
        customers.add(CustomerItem(userId: item["consumerId"], tableId: item["tableId"]));
      }
      final teams = <TeamItem>[];
      for (final item in detailsData["teams"]) {
        teams.add(
          TeamItem(
            teamId: item["teamId"],
            name: item["name"],
            icon: item["iconPath"],
          ),
        );
      }
      details = GamingDetails(
        showId: detailsData["showId"],
        roundId: detailsData["roundId"],
        roundNumber: detailsData["roundNumber"],
        mode: detailsData["mode"],
        game: detailsData["game"],
        customers: customers,
        teams: teams,
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
    required this.teams,
  });
  final int showId;
  final DateTime startTime;
  final String mode;
  final List<CustomerItem> customers;
  final List<TeamItem> teams;
}

class GamingDetails {
  GamingDetails({
    required this.showId,
    required this.roundId,
    required this.roundNumber,
    required this.mode,
    required this.game,
    required this.customers,
    required this.teams,
  });
  final int showId;
  final int roundId;
  final int roundNumber;
  final String mode;
  final String game;
  final List<CustomerItem> customers;
  final List<TeamItem> teams;
}

class CustomerItem {
  int userId;
  int tableId;
  CustomerItem({required this.userId, required this.tableId});
}

class TeamItem {
  final String name;
  final String icon;
  final int teamId;
  TeamItem({
    required this.teamId,
    required this.name,
    required this.icon,
  });
}
