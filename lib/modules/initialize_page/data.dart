class BoardInfo {
  BoardInfo(this.id, this.udid, this.bChecked, this.type, this.tableId);
  final String id;
  final String udid;
  final bool bChecked;
  final String? type;
  final int? tableId;
  factory BoardInfo.fromJsom(Map data) {
    final type = data.containsKey("type") ? data['type'] : null;
    final tableId = data.containsKey('tableId') ? data['tableId'] : null;
    return BoardInfo(data['id'], data['udid'], data['checked'], type, tableId);
  }
}
