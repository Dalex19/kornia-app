import 'package:dio/dio.dart';

class PhotoRemoteDatasource {
  final Dio dio;

  PhotoRemoteDatasource(this.dio);

  Future<List<dynamic>> getPhotos() async {
    final response = await dio.get('/photos',
    queryParameters: {
      '_start': 1,
      '_limit': 20, 
    });

    return response.data;
  }
}
