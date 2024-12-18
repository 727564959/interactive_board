import 'dart:convert';

import 'package:flutter/material.dart';

const String baseApiUrl = 'http://10.1.10.8:1337/api';
const String baseSocketIoUrl = 'http://10.1.10.8:12333';
const String baseStrapiUrl = 'http://10.1.10.8:1337';
const String basePayloadApiUrl = "http://10.1.10.8:3000/api";
const String baseTriviaUrl = "http://mini-game.mirramr.com:3000/trivia-by-show";
const String baseBonusUrl = "http://mini-game.mirramr.com:3000/score-wheel";

// const String baseTriviaUrl = "http://mini-game.mirratest.com:3000/trivia-by-show";
// const String baseBonusUrl = "http://mini-game.mirratest.com:3000/score-wheel";

// const String baseBonusUrl = "http://10.1.10.6:3000/score-wheel";
// const String baseTriviaUrl = "http://10.1.10.6:3000/trivia-by-show";
// const String basePayloadApiUrl = "http://10.1.10.6:3000/api";
// const String baseApiUrl = 'http://10.1.10.6:1337/api';
// const String baseSocketIoUrl = 'http://10.1.10.6:12333';
// const String baseStrapiUrl = 'http://10.1.10.6:1337';

final routeObserver = RouteObserver<ModalRoute<void>>();

class Global {
  static int? _tableId;
  static int get tableId => _tableId!;
  static void setTableId(int tableId) {
    _tableId = tableId;
  }

  static String getDeviceName(int position) {
    final char = ascii.decode([0x40 + (position + 1) ~/ 2]);
    return "Device $char${(position + 1) % 2 + 1}";
  }

  static String getGifUrl(String filename) => "assets/images/gif/$filename";

  static String getSetAvatarImageUrl(String filename) => "assets/images/set_avatar/$filename";
}
