import 'package:kornia/features/home/domain/entities/photo_entity.dart';

class PhotoDto {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoDto({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoDto.fromJson(Map<String, dynamic> json) {
    return PhotoDto(
      id: json['id'] as int,
      albumId: json['albumId'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }

  // Convert PhotoDto to PhotoEntity
  PhotoEntity toDomain() {
    return PhotoEntity(
      id: id,
      albumId: albumId,
      title: title,
      url: url,
      thumbnailUrl: thumbnailUrl,
    );
  }
}
