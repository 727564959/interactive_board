import 'package:dio/dio.dart';

class HonorApi {
  static HonorApi? _instance;

  factory HonorApi() => _instance ?? HonorApi._internal();
  final dio = Dio();

  HonorApi._internal() {
    _instance = this;
  }
}