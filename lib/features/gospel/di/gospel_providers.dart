import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/core/network/dio_provider.dart';
import 'package:kornia/features/gospel/data/gospel_remote_datasource.dart';
import 'package:kornia/features/gospel/data/gospel_repository_imp.dart';
import 'package:kornia/features/gospel/domain/get_gospel_usecase.dart';
import 'package:kornia/features/gospel/domain/gospel_repository.dart';

final gospelDataSourceProvider = Provider<GospelRemoteDatasource>((ref) {
  return GospelRemoteDatasource(ref.watch(dioGospelProvider));
});

final gospelRepositoryProvider = Provider<GospelRepository>((ref) {
  return GospelRepositoryImp(ref.watch(gospelDataSourceProvider));
});

final gospelUsecaseProvider = Provider<GetGospelUseCase>((ref) {
  return GetGospelUseCase(ref.watch(gospelRepositoryProvider));
});

