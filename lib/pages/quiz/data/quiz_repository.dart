import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:dio/dio.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../../../data/network/utils.dart';
import '../../../common.dart';
import '../data/question.dart';

class QuizRepository {
  MqttServerClient? _client;
  final _dio = Dio();
  final baseUrl = "http://10.1.4.13:1337/api";
  final void Function(QuestionInfo) onQuestionRound;
  final void Function() onAnswerShow;
  final void Function() onClose;
  QuizRepository({required this.onQuestionRound, required this.onAnswerShow, required this.onClose}) {
    getMQTTClient().then((client) async {
      _client = client;
      client.subscribe("event/quiz/#", MqttQos.atMostOnce);
      await for (final msgQueue in client.updates!) {
        for (final item in msgQueue) {
          final recMess = item.payload as MqttPublishMessage;
          final topic = item.topic;
          if (topic == "event/quiz/question-time") {
            final payload = jsonDecode(MqttPublishPayload.bytesToStringAsString(recMess.payload.message));
            onQuestionRound(QuestionInfo.fromJson(payload));
          } else if (topic == "event/quiz/answer-share") {
            onAnswerShow();
          } else if (topic == "event/quiz/complete" || topic == "event/quiz/stop") {
            onClose();
          }
        }
      }
    });
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
