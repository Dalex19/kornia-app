import 'package:kornia/features/gospel/domain/gospel_entity.dart';

abstract class GospelRepository {
  Future<GospelEntity> getGospelOfTheDay(DateTime time);
}