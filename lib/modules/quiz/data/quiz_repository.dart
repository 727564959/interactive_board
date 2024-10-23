import 'package:dio/dio.dart';

import 'package:socket_io_client/socket_io_client.dart';

import '../../../common.dart';
import 'question.dart';
import 'settlement.dart';

class QuizRepository {
  final _dio = Dio();
  late final Socket socket;
  final void Function(QuestionInfo) onQuestionRound;
  final void Function() onAnswerShow;
  final void Function(List<SettlementInfo>) onSettlement;
  final void Function() onClose;
  final void Function(int, String) onCategoryShow;
  QuizRepository({
    required this.onCategoryShow,
    required this.onQuestionRound,
    required this.onAnswerShow,
    required this.onSettlement,
    required this.onClose,
  }) {
    final option = OptionBuilder().setTransports(['websocket']).disableAutoConnect().build();
    socket = io(baseTriviaUrl, option);
    socket.on('category_show', (data) {
      onCategoryShow(data["round"], data["category"]);
    });
    socket.on('Q&A_time', (data) {
      onQuestionRound(QuestionInfo.fromJson(data));
    });

    socket.on('answer_show', (_) {
      onAnswerShow();
    });
    socket.on('settlement', (data) {
      final result = <SettlementInfo>[];
      for (final item in data["records"]) {
        result.add(
          SettlementInfo(
            tableId: item["teamId"],
            score: item["total"],
            rank: item["rank"],
            rankScore: item["rankScore"],
          ),
        );
      }
      onSettlement(result);
    });

    socket.on('complete', (_) {
      onClose();
    });

    socket.on('stop', (_) {
      onClose();
    });
    socket.connect();
  }

  Future<int> select(int idx) async {
    final response = await _dio.post(
      "$baseTriviaUrl/choice-answer",
      data: {
        "teamId": Global.tableId,
        "answer": idx,
      },
    );
    return response.data['score'];
  }

  void dispose() {
    socket.close();
  }
}
