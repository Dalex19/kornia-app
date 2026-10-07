import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> getToken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    await FirebaseMessaging.instance.subscribeToTopic('todos');
  } catch (e) {
    print('No se pudo obtener el token: $e');
  }
}
