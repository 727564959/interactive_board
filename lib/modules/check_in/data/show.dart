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
    final startTime = DateTime.parse(map["startTime"]);
    final fullTables = <int>[];
    for (final item in map["associatedUsers"] ?? []) {
      fullTables.add(item['tableId']);
    }
    return ShowInfo(
        startTime: startTime,
        showId: map["showId"],
        // status: map["status"],
        fullTables: fullTables);
  }
}
