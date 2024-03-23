import 'package:dio/dio.dart';

class WinnerApi {
  static WinnerApi? _instance;

  factory WinnerApi() => _instance ?? WinnerApi._internal();
  final dio = Dio();

  WinnerApi._internal() {
    _instance = this;
  }
}