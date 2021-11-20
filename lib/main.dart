import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/pages.dart';

import 'binder.dart';
import 'constants.dart';

void main() async {
 //  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  Get.lazyPut(() => FirestoreService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()],
      title: "Lisu Dictionary",
      initialBinding: Binder(),
      initialRoute: "/home",
      getPages: pages,
      smartManagement: SmartManagement.keepFactory,
      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),


    );
  }
}
