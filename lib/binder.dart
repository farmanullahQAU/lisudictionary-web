import 'package:get/get.dart';
import 'package:lisudictionary_web/controllers/user_controller.dart';
import 'package:lisudictionary_web/screens/login/login_controller.dart';

import 'controllers/MenuController.dart';
import 'screens/dictionary_form/dictionary_form_controller.dart';
import 'controllers/allwords_controller.dart';

class Binder extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());

    Get.put(MenuController());
    Get.put(RecentController());
    Get.put(DictFormController());
    Get.put(LoginRegisterController());
  }
}
