import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/network/api_constance.dart';
import 'package:takatof/core/network/dio_helper.dart';
import 'package:takatof/core/routes/app_pages.dart';
import 'package:takatof/core/services/services_locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'id',
  'name',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async{
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  ApiConstance.fcmToken = fcmToken.toString();
  print('fcmToken : ${fcmToken}');
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((message) {
    print('Got a message whilst in the foreground!');

    if (message.notification != null) {
      // final snackBar = SnackBar(
      //   content: Text(message.notification?.title ?? '', maxLines: 2),
      // );
      // Get.snackbar(
      //   message.notification!.title!,
      //   message.notification!.body!,
      //   duration: Duration(seconds: 3),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  });
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.splash,
      getPages: AppPages.routes,
      fallbackLocale: const Locale('ar'),
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorResources.white2,
        primaryColor: ColorResources.greenPrimary
      ),
      // initialBinding: BindingsBuilder(() => Get.put<DioHelper>(DioHelper(), permanent: true)),
    );
  }
}
