import 'package:intl/intl.dart';

class Utils {
  static String clean(String text) {
    return text
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), ' ')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&quot;', '"')
        .replaceAll(RegExp(r'&#0?39;'), "'")
        .replaceAll('&amp;', '&') // al final para no doble-decodificar
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static String formatDate(DateTime d) =>
      '${d.year}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}';

  static String formatDateForUi(DateTime now) {
    final dateFormat = DateFormat("EEEE, d 'de' MMMM", 'es').format(now);
    return '${dateFormat[0].toUpperCase()}${dateFormat.substring(1)}';
  }
}
