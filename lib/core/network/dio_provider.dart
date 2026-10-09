import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProviderGlobal = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
  return dio;
});

final dioGospelProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://feed.evangelizo.org/v2/'));
  return dio;
});