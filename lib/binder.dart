
import 'package:get/get.dart';

import 'controllers/MenuController.dart';
import 'controllers/dictionary_form_controller.dart';
import 'controllers/recent_controller.dart';

class Binder extends Bindings {
  @override
  void dependencies() {

    Get.put( MenuController());
    Get.put( RecentController());
    Get.put( DictFormController());

  }
}