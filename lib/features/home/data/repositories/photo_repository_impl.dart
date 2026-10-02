import 'package:kornia/features/home/data/datasource/photo_remote_datasource.dart';
import 'package:kornia/features/home/data/dtos/photo_dto.dart';
import 'package:kornia/features/home/domain/entities/photo_entity.dart';
import 'package:kornia/features/home/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDatasource remoteDatasource;

  PhotoRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<PhotoEntity>> getPhotos() async {
    try {
      //first raw data from remote datasource
      final json = await remoteDatasource.getPhotos();

      //second convert raw data to dtos
      final dtos = json.map((json) => PhotoDto.fromJson(json)).toList();

      //third convert dtos to entities
      final result = dtos.map((dto) => dto.toDomain()).toList();
      return result;
    } catch (e) {
      print('Error in PhotoRepositoryImpl.getPhotos: $e');
      throw Exception(e);
    }
  }
}
