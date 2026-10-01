import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/core/network/dio_provider.dart';
import 'package:kornia/features/home/data/datasource/photo_remote_datasource.dart';
import 'package:kornia/features/home/data/repositories/photo_repository_impl.dart';
import 'package:kornia/features/home/domain/repositories/photo_repository.dart';
import 'package:kornia/features/home/domain/usecases/get_photos_usecase.dart';

// call to dio provider global instance and insert it into the data source constructor
final photoDataSourceProvider = Provider<PhotoRemoteDatasource>((ref) {
  return PhotoRemoteDatasource(ref.watch(dioProviderGlobal));
});

//register the repository in another provider
final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  return PhotoRepositoryImpl(ref.watch(photoDataSourceProvider));
});

//register the use case in another provider
final photoUsecaseProvider = Provider<GetPhotoUsecase>((ref) {
  return GetPhotoUsecase(ref.watch(photoRepositoryProvider));
});
