
import 'package:kornia/features/home/domain/entities/photo_entity.dart';
import 'package:kornia/features/home/domain/repositories/photo_repository.dart';

class GetPhotoUsecase {
  final PhotoRepository repository;
  GetPhotoUsecase(this.repository);

  Future<List<PhotoEntity>> call() async {
    return await repository.getPhotos();
  }
}