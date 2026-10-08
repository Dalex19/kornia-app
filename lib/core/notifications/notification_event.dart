enum NotificationTapSource{foreground, background, terminated}

class NotificationTap {
final String? payload;
final NotificationTapSource source;

const NotificationTap({this.payload, required this.source});
}

