import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psychology/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/my_string.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint("on ${message.notification!.body} message ");
  print(message.notification!.body.toString());

  Fluttertoast.showToast(
    gravity: ToastGravity.TOP,
    msg: message.notification!.body!.contains("audio call")||message.notification!.body!.contains("video call")
        ? "you have incoming call"
        : "New message from " + message.notification!.title.toString(),
    backgroundColor: mainColor2,
  );

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();

  var token = await FirebaseMessaging.instance.getToken();
  debugPrint(token.toString());
  await FirebaseMessaging.instance.getNotificationSettings();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((message) {});
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.notification!.body.toString());

    Fluttertoast.showToast(
      gravity: ToastGravity.TOP,
      msg: "New message from " + event.notification!.title.toString(),
      backgroundColor: Colors.red,
    );
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'psychology',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: GetStorage().read("auth") == patientsCollectionKey
          ? Routes.patientMainScreen
          : GetStorage().read("auth") == doctorsCollectionKey
              ? Routes.doctorMainScreen
              : Routes.SplashScreen,
      getPages: AppRoutes.routes,

      //Fraon
    );
  }
}
