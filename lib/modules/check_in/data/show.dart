class ShowInfo {
  DateTime startTime;
  int showId;
  // String status;
  List<int> fullTables;
  ShowInfo({
    required this.startTime,
    required this.showId,
    // required this.status,
    required this.fullTables});
  factory ShowInfo.fromJson(dynamic map) {
    // print("map ${map}");
    // final startTime = DateTime.parse(map["startTime"]);
    final startTime = DateTime.parse(map["startDate"] + " " + map["startTime"]);
    final fullTables = <int>[];
    for (final item in map["associatedUsers"] ?? []) {
      fullTables.add(item['tableId']);
    }
    // print("startTime ${startTime}");
    return ShowInfo(
        startTime: startTime,
        showId: map["showId"],
        // status: map["status"],
        fullTables: fullTables);
  }
}
