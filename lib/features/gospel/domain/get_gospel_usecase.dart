import 'package:kornia/features/gospel/domain/gospel_entity.dart';
import 'package:kornia/features/gospel/domain/gospel_repository.dart';


class GetGospelUseCase {
  final GospelRepository repository;

  GetGospelUseCase(this.repository);

  Future<GospelEntity> call(DateTime time) async {
    return await repository.getGospelOfTheDay(time);
  }


}