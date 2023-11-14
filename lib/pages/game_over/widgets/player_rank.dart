import 'package:flutter/material.dart';

class PlayerRank extends StatelessWidget {
  const PlayerRank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class RankBar extends StatefulWidget {
  const RankBar({
    Key? key,
    required this.rank,
    required this.score,
    required this.nickname,
    required this.tableId,
    required this.avatar,
  }) : super(key: key);
  final int rank;
  final int score;
  final String nickname;
  final int tableId;
  final String avatar;

  @override
  State<RankBar> createState() => _RankBarState();
}

class _RankBarState extends State<RankBar> {
  int get rank => widget.rank;
  int get score => widget.score;
  String get nickname => widget.nickname;
  int get tableId => widget.tableId;
  String get avatar => widget.avatar;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
