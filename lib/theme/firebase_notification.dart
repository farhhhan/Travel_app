// import 'dart:math';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseServices {
//    FirebaseMessaging messaging = FirebaseMessaging.instance;
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   FirebaseServices() {
//     // Initialize the FlutterLocalNotificationsPlugin
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//        // This is where you define iOS initialization settings
//     );

//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }

//   Future<void> onSelectNotification(String? payload) async {
//     // Handle notification tapped logic here
//     print("Notification Tapped: $payload");
//   }

//   void firebaseInit() {
//     FirebaseMessaging.onMessage.listen((event) {
//       showMessageNotification(event);
//     });
//   }

//   void requestNotificationPermission() async {
//     NotificationSettings notificationSettings =
//         await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       sound: true,
//       criticalAlert: true,
//       provisional: true,
//     );

//     if (notificationSettings.authorizationStatus ==
//         AuthorizationStatus.authorized) {
//       print("User Granted Permission");
//     } else if (notificationSettings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print("User Provisional Permission");
//     } else {
//       print("User Permission Denied");
//     }
//   }

//   Future<void> showMessageNotification(RemoteMessage message) async {
//     print(message.notification!.title);
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       Random.secure().nextInt(10000).toString(),
//       "High Importance Notifications",
//       importance: Importance.max,
//     );

//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       channel.id,
//       channel.name,
//       priority: Priority.high,
//       importance: Importance.high,
//       channelDescription: "Your device description",
//       ticker: 'ticker',
//     );

//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );

//     flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification!.title,
//       message.notification!.body,
//       notificationDetails,
//     );
//   }

//   Future<String?> getDeviceToken() async {
//     return await messaging.getToken();
//   }
// }
