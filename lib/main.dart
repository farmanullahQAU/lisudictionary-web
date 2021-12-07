import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lisudictionary_web/core/services/auth_services.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';
import 'package:lisudictionary_web/pages.dart';
import 'package:url_strategy/url_strategy.dart';

import 'binder.dart';
import 'constants.dart';
import 'core/services/firestore_services.dart';



void initServices() async {

 // await Get.putAsync(() => AuthService().init());

  await GetStorage.init();
  Get.lazyPut(() => FirestoreService());

  Get.lazyPut(() => AuthService());
  Get.lazyPut(() => GetStorageServices());
}
Future<void> main() async {

  //initializing all service before app starts
  setPathUrlStrategy();
   initServices();
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
      initialRoute: "/",
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
