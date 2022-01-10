import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static const defaulId = 0;
  static const defaultTitle = 'Aplicativo lista de compras';
  static const defaultBody = 'Bora cadastrar um novo item?';
  static const defaultPaylod = 'simles.02';

  static Future _notificationDetails({String? bodyText}) async {
    BigTextStyleInformation style = bodyText != null
        ? BigTextStyleInformation(bodyText)
        : const BigTextStyleInformation('');

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        playSound: false,
        importance: Importance.max,
        styleInformation: style,
      ),
    );
  }

  static Future init() async {
    var androidConfif =
        const AndroidInitializationSettings("@mipmap/launcher_icon");
    var generalConfig = InitializationSettings(android: androidConfif);

    final details = await _notifications.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.payload);
    }

    _notifications.initialize(
      generalConfig,
      onSelectNotification: (payload) async {
        onNotification.add(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }

  static Future scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime data,
  }) async {
    final location = tz.UTC;
    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(data, location),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future scheduleNotificationWithBodyText({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime data,
  }) async {
    final location = tz.UTC;
    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(data, location),
      await _notificationDetails(bodyText: body),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ANCHOR - By minute
  static Future everyMinute({
    int id = 0,
    String title = defaultTitle,
    String body = defaultBody,
    String payload = defaultPaylod,
  }) async {
    _notifications.periodicallyShow(id, title, body, RepeatInterval.everyMinute,
        await _notificationDetails(bodyText: body),
        androidAllowWhileIdle: true);
  }

  // ANCHOR - By hour
  static Future everyHour({
    int id = 0,
    String title = defaultTitle,
    String body = defaultBody,
    String payload = defaultPaylod,
  }) async {
    _notifications.periodicallyShow(id, title, body, RepeatInterval.hourly,
        await _notificationDetails(bodyText: body),
        androidAllowWhileIdle: true);
  }

  // ANCHOR - By day
  static Future everyDay({
    int id = 0,
    String title = defaultTitle,
    String body = defaultBody,
    String payload = defaultPaylod,
  }) async {
    _notifications.periodicallyShow(id, title, body, RepeatInterval.daily,
        await _notificationDetails(bodyText: body),
        androidAllowWhileIdle: true);
  }

  // ANCHOR - By week
  static Future everyWeek({
    int id = 0,
    String title = defaultTitle,
    String body = defaultBody,
    String payload = defaultPaylod,
  }) async {
    _notifications.periodicallyShow(id, title, body, RepeatInterval.weekly,
        await _notificationDetails(bodyText: body),
        androidAllowWhileIdle: true);
  }

  // ANCHOR
  static Future cancelAll() async {
    await _notifications.cancelAll();
  }
}
