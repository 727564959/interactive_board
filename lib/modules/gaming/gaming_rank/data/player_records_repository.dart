import 'package:dio/dio.dart';

import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../common.dart';
import 'player.dart';

class RecordsRepository {
  final baseUrl = "http://10.1.4.13:1337";
  final _dio = Dio();
  late final Socket gameServerSocket;

  Future<void> Function(List<dynamic>) onGamingUpdate;
  void Function(dynamic) onGameOver;

  RecordsRepository({required this.onGamingUpdate, required this.onGameOver}) {
    final option = OptionBuilder().setTransports(['websocket']).enableReconnection().disableAutoConnect().build();
    gameServerSocket = io('$baseSocketIoUrl/listener/game-server', option);
    gameServerSocket.on('gaming_tick', (data) {
      onGamingUpdate(data["details"]);
    });
    gameServerSocket.on('game_over', (data) {
      onGameOver(data);
    });
    gameServerSocket.connect();
  }

  Future<PlayerInfo> fetchPlayerInfo(int playerId, int position) async {
    final response = await _dio.get("$baseApiUrl/players/$playerId/avatar");
    final data = response.data;
    return PlayerInfo.fromJson({
      ...data,
      "position": position,
    });
  }

  void dispose() {
    gameServerSocket.close();
  }
}
