import 'package:firebase_messaging/firebase_messaging.dart';

Future <void>  getToken () async{

  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
  } catch (e) {
    print('No se pudo obtener el token: $e');
  }
}