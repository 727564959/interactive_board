import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:dio/dio.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../../../data/network/utils.dart';
import '../../../common.dart';
import 'question.dart';
import 'settlement.dart';

class QuizRepository {
  MqttServerClient? _client;
  final _dio = Dio();
  final baseUrl = "http://10.1.4.13:1337/api";
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
    final client = getMQTTClient();
    _client = client;
    client.onConnected = () async {
      client.subscribe("event/quiz/#", MqttQos.atMostOnce);
      client.updates!.listen((c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final topic = c[0].topic;
        if (topic == "event/quiz/question-time") {
          final payload = jsonDecode(MqttPublishPayload.bytesToStringAsString(recMess.payload.message));
          onQuestionRound(QuestionInfo.fromJson(payload));
        } else if (topic == "event/quiz/answer-share") {
          onAnswerShow();
        } else if (topic == "event/quiz/complete") {
          final payload =
              jsonDecode(MqttPublishPayload.bytesToStringAsString(recMess.payload.message)) as Map<String, dynamic>;
          final result = <SettlementInfo>[];
          final record = payload["record"];
          for (final key in record.keys) {
            final int score = record[key];
            final int tableId = int.parse(key);
            result.add(SettlementInfo(tableId: tableId, score: score));
          }
          result.sort((a, b) => b.score - a.score);
          for (int i = 0; i < result.length; i++) {
            result[i].rank = i + 1;
          }
          result.sort((a, b) => a.tableId - b.tableId);
          onComplete(result);
        } else if (topic == "event/quiz/stop") {
          onClose();
        }
      });
    };
    client.connect();
  }
  Future<void> join() async {
    await _dio.post("$baseUrl/quiz/table-joined", data: {"tableId": Global.tableId});
  }

  Future<void> select(int idx) async {
    await _dio.post(
      "$baseUrl/quiz/select-answer",
      data: {
        "tableId": Global.tableId,
        "answer": idx,
      },
    );
  }

  void dispose() {
    _client?.disconnect();
  }
}
