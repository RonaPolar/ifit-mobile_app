import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ifit/main.dart';
import 'package:ifit/views/home.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FirebaseNotif extends ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  static void onNotificationTap(NotificationResponse response) {
    onClickNotification.add(response.payload!);
  }

  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {});
    const LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "your channel id", "your channel name",
      channelDescription: "your channel description",
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  String? schedule;

  void updateSchedule(value) {
    schedule = value;
    notifyListeners();
  }

  void clearSchedule() {
    schedule = null;
    notifyListeners();
  }

  RepeatInterval get repeatedInterval {
    if (schedule == "Daily") {
      return RepeatInterval.daily;
    } else if (schedule == "Every Minute") {
      return RepeatInterval.everyMinute;
    } else if (schedule == "Every Hour") {
      return RepeatInterval.hourly;
    } else if (schedule == "Weekly") {
      return RepeatInterval.weekly;
    } else {
      return RepeatInterval.daily;
    }

  }

  int generateUnique4DigitNumber() {
    Random random = Random();
    Set<int> generatedNumbers = {};

    while (true) {
      int randomNumber = 1000 + random.nextInt(9000); // Generate a 4-digit number
      if (!generatedNumbers.contains(randomNumber)) {
        generatedNumbers.add(randomNumber);
        return randomNumber;
      }
    }
  }

  int counter = 0;

  Future showPeriodicNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "channel 2", "your channel name",
      channelDescription: "your channel description",
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      generateUnique4DigitNumber(),
      title,
      body,
      payload: payload,
      repeatedInterval,
      notificationDetails,
    );
  }

  static Future showScheduleNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    var localTime = tz.local;

    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "channel 3", "your channel name",
      channelDescription: "your channel description",
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      payload: payload,
      tz.TZDateTime.now(localTime).add(const Duration(seconds: 5)),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }



  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notification",
    importance: Importance.defaultImportance,
  );

  static final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint("Title: ${message.notification?.title}");
    debugPrint("Body: ${message.notification?.body}");
    debugPrint("Payload: ${message.data}");
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => HomeNotification()));
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/ic_launcher",
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future notifNow({
    int id = 0,
    required String title,
    required String body,
    required String payload,
  }) async {
    FlutterLocalNotificationsPlugin().show(id,
      title,
      body,
      notificationDetails(),
      payload: payload,
    );
  }

  tz.TZDateTime _nextInstanceOfNineAM(int dateFinished, int daysOfThePlan, int day) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = now;

    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    if (dateFinished > daysOfThePlan) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    scheduledDate = tz.TZDateTime.local(
      now.year,
      now.month,
      now.day,
      9,
      0,
    );
    return scheduledDate;
  }

  Future<void> showScheduledNotification({
    required String title,
    required String body,
    required String payload,
    required int dateFinished,
    required int daysOfThePlan,
    required int day,
  }) async {
    await checkNotificationPermission();

    try {
      tz.initializeTimeZones();
      print("${tz.getLocation("Asia/Manila")}");
      await FlutterLocalNotificationsPlugin().zonedSchedule(
        3,
        title,
        body,
        _nextInstanceOfNineAM(
          dateFinished,
          daysOfThePlan,
          day,
        ),
        notificationDetails(),
        payload: payload,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
      print("Notification scheduled successfully");
      notifyListeners(); // Notify listeners after scheduling the notification
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }

  Future<void> checkNotificationPermission() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    // Check notification permission status
    final bool? isNotificationEnabled =
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.getNotificationChannels().then((channels) => channels?.any((channel) => channel.importance != Importance.none) ??
      false,
    );

    if (isNotificationEnabled != null) {
      print('Notification permission granted');
    } else {
      print('Notification permission not granted');
    }
  }

  // Future showScheduledNotification({
  //   int id = 1,
  //   required String title,
  //   required String body,
  //   required String payload,
  //   required DateTime scheduledDate,
  // }) async {
  //   try {
  //     print("${tz.local}");
  //     await FlutterLocalNotificationsPlugin().zonedSchedule(
  //       id,
  //       title,
  //       body,
  //       tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails("your channel id", "your channel name"),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       payload: "${title} | ${body}",
  //       matchDateTimeComponents: DateTimeComponents.time,
  //       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     ).then((value) {
  //       print("Notification scheduled successfully");
  //     });
  //
  //     notifyListeners();
  //   } catch (e) {
  //     print("Error scheduling notification: $e");
  //   }
  // }


  static NotificationDetails notificationDetails() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
     AndroidNotificationDetails(
      "com.fitness.app",
      'com.fitness.app.channel', // Replace with your own channel name
      importance: Importance.max,
      channelDescription: "Channel Description"
    );
    return const NotificationDetails(android: androidPlatformChannelSpecifics);
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings("@drawable/img");
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
        handleMessage(message);
      }
    );

    //
    // final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    // await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: $fCMToken");
    initPushNotifications();
    initLocalNotifications();
  }
}