import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ifit/models/push_notification.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class HomeNotification extends StatefulWidget {
  const HomeNotification({super.key});

  @override
  State<HomeNotification> createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {

  late int _totalNotif;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  void requestAndRegisterNotification() async {
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
      String? token = await _messaging.getToken();
      print("The token is $token");

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification? notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotif++;
        });

        if (_notificationInfo != null) {
          showDialog(context: context, builder: (context) => AlertDialog(
            content: ListTile(
              title: Text("${_notificationInfo!.title}"),
              leading: Text("Total notifications: $_totalNotif"),
              subtitle: Text("${_notificationInfo!.body}"),
            ),
          ),);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    requestAndRegisterNotification();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotif++;
      });
    });
    _totalNotif = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("App for capturing notifications"),
          const SizedBox(height: 16.0),
          Text("$_totalNotif"),
          Text("${_notificationInfo?.title}"),
          Text("${_notificationInfo?.body}"),
        ],
      )
    );
  }
}
