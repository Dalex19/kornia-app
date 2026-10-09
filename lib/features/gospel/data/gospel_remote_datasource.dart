import 'package:dio/dio.dart';
import 'package:kornia/features/gospel/data/gospel_dto.dart';
import 'package:kornia/features/gospel/utils.dart';

class GospelRemoteDatasource {
  final Dio dio;

  GospelRemoteDatasource(this.dio);

  Future<GospelDTO> getGospel(DateTime date) async {
    final response = await Future.wait([
      _fetch('reading_st', date),
      _fetch('reading', date),
    ]);

    return GospelDTO(title: response[0], content: response[1]);
  }

  Future<String> _fetch(String type, DateTime date) async {
    final response = await dio.get<String>(
      'reader.php',
      queryParameters: {
        'date': Utils.formatDate(date),
        'type': type,
        'lang': 'SP',
        'content': 'GSP',
      },
      options: Options(responseType: ResponseType.plain),
    );
    return response.data ?? '';
  }
}
