import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:dio/dio.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../data/network/utils.dart';
import '../../../common.dart';
import 'question.dart';
import 'settlement.dart';

class QuizRepository {
  final _dio = Dio();
  final baseUrl = "http://10.0.0.4:1337/api";
  late final Socket socket;
  final void Function(QuestionInfo) onQuestionRound;
  final void Function() onAnswerShow;
  final void Function(List<SettlementInfo>) onComplete;
  final void Function() onClose;
  QuizRepository({
    required this.onQuestionRound,
    required this.onAnswerShow,
    required this.onComplete,
    required this.onClose,
  }) {
    final option = OptionBuilder().setTransports(['websocket']).build();
    socket = io('http://10.0.0.4:12333/listener/quiz', option);

    socket.on('Q&A_time', (data) {
      onQuestionRound(QuestionInfo.fromJson(data));
    });

    socket.on('answer_show', (_) {
      onAnswerShow();
    });

    socket.on('complete', (data) {
      final result = <SettlementInfo>[];
      final record = data["totalScores"];
      for (final key in record.keys) {
        final int score = record[key];
        final int tableId = int.parse(key);
        result.add(SettlementInfo(tableId: tableId, score: score));
      }
      result.sort((a, b) => b.score - a.score);
      result[0].rank = 1;
      for (int i = 1; i < result.length; i++) {
        if (result[i].score == result[i - 1].score) {
          result[i].rank = result[i - 1].rank;
        } else {
          result[i].rank = i + 1;
        }
      }
      result.sort((a, b) => a.tableId - b.tableId);
      onComplete(result);
    });

    socket.on('stop', (_) {
      onClose();
    });
  }
  Future<void> join() async {
    await _dio.post("$baseUrl/quiz/join", data: {"tableId": Global.tableId});
  }

  Future<void> select(int idx) async {
    await _dio.post(
      "$baseUrl/quiz/choice-answer",
      data: {
        "tableId": Global.tableId,
        "answer": idx,
      },
    );
  }

  void dispose() {
    socket.close();
  }
}
