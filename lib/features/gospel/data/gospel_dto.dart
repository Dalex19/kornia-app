import 'package:kornia/features/gospel/domain/gospel_entity.dart';
import 'package:kornia/features/gospel/utils.dart';

class GospelDTO {
  final String title;
  final String content;

  GospelDTO({required this.title, required this.content});

    GospelEntity toDomain (GospelDTO dto) {
       final body = dto.content.split(RegExp(r'<br\s*/?>\s*<br\s*/?>'))[0];
       final content = Utils.clean(body);

        final reference = Utils.clean(dto.title).replaceFirst(RegExp(r'\.$'), '');

    if (content.isEmpty) throw Exception('Evangelio vacío');

    return GospelEntity(title: reference, content: content);
  }
}