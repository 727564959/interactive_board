class ShowInfo {
  DateTime startTime;
  int showId;
  List<int> fullTables;
  ShowInfo({required this.startTime, required this.showId, required this.fullTables});
  factory ShowInfo.fromJson(dynamic map) {
    print(map);
    final startTime = DateTime.parse(map["startTime"]);
    final fullTables = <int>[];
    for (final item in map["associatedUsers"]) {
      fullTables.add(item['tableId']);
    }
    return ShowInfo(startTime: startTime, showId: map["showId"], fullTables: fullTables);
  }
}
