
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kornia/core/notifications/notification_providers.dart';
import 'package:kornia/firebase_options.dart';

Future<ProviderContainer> bootstrap() async {
   WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 
 await initializeDateFormatting('es', null);

 final container = ProviderContainer();
 unawaited(_initNotifications(container));

 return container;
}
   Future<void> _initNotifications(ProviderContainer container) async {
  try {
    await container.read(notificationServiceProvider).initialize();
  } catch (e, st) {
    debugPrint('No se pudieron inicializar las notificaciones: $e\n$st');
  }
}