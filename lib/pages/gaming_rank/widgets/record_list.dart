import 'package:flutter/material.dart';
import 'record_item.dart';

class RecordList extends StatelessWidget {
  const RecordList({Key? key, required this.width, required this.height}) : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // color: Colors.cyanAccent,
      child: Column(
        children: [
          RecordItem(
            width: width,
            rank: 1,
            avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
            score: 1433,
          ),
          RecordItem(
            width: width,
            rank: 2,
            avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
            score: 1433,
          ),
          RecordItem(
            width: width,
            rank: 3,
            avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
            score: 1433,
          ),
          RecordItem(
            width: width,
            rank: 4,
            avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
            score: 1433,
          ),
          RecordItem(
            width: width,
            rank: 1,
            avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
            score: 1433,
          ),
          RecordItem(
            width: width,
            rank: 1,
            avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
            score: 1433,
          ),
          RecordItem(
            width: width,
            rank: 1,
            avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
            score: 1433,
          ),
          RecordItem(
            width: width,
            rank: 1,
            avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
            score: 1433,
          ),
        ],
      ),
    );
  }
}
