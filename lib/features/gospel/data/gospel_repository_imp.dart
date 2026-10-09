import 'package:kornia/features/gospel/data/gospel_remote_datasource.dart';
import 'package:kornia/features/gospel/domain/gospel_entity.dart';
import 'package:kornia/features/gospel/domain/gospel_repository.dart';

class GospelRepositoryImp implements GospelRepository {
  final GospelRemoteDatasource remoteDatasource;

  GospelRepositoryImp(this.remoteDatasource);

  @override
  Future<GospelEntity> getGospelOfTheDay(DateTime time) async {
    try {
      final dto = await remoteDatasource.getGospel(time);

      return dto.toDomain(dto);
    } catch (e) {
      print('Error in PhotoRepositoryImpl.getPhotos: $e');
      throw Exception(e);
    }
  }
}
