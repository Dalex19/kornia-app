
import 'package:kornia/app/router/route_names.dart';

String? routeForNotificationPayload(String? payload) => switch (payload) {
  'evangelio' => RouteNames.gospel,
  _ => null,
  
};