
import 'package:get/get.dart';
import 'package:lisudictionary_web/controllers/user_controller.dart';
import 'package:lisudictionary_web/screens/dashboard/components/login_controller.dart';

import 'controllers/MenuController.dart';
import 'controllers/dictionary_form_controller.dart';
import 'controllers/recent_controller.dart';

class Binder extends Bindings {
  @override
  void dependencies() {
    Get.put( UserController());

    Get.put( MenuController());
    Get.put( RecentController());
    Get.put( DictFormController());
    Get.lazyPut<LoginRegisterController>(() => LoginRegisterController());

  }
}