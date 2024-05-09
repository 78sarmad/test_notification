import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_notifications/firebase_options.dart';
// import 'package:test_notifications/loginpage.dart';
import 'package:test_notifications/splashscreen.dart';
// import 'package:test_notifications/splashscreen.dart';
 
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
  
  
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

       options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const MaterialColor blue2 = MaterialColor(
    0xFF509A77,
    <int, Color>{
      50: Color(0xFFE1FCEF),
      100: Color(0xFFBCFDDF),
      200: Color(0xFF8EFAC7),
      300: Color(0xFF63F6B1),
      400: Color(0xFF42F5A0),
      500: Color(0xFF509A77),
      600: Color(0xFF1DE586),
      700: Color(0xFF18D079),
      800: Color(0xFF14BD6D),
      900: Color(0xFF0CA05A),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
       SplashScreen()
   
    );
  }
}
 