import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/auth_services.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';
import 'package:lisudictionary_web/models/user_model.dart';

class UserController extends GetxController{

UserModel? currentUser;

  @override
  Future<void> onInit()

  async {

   if( Get.find<GetStorageServices>().getId!="")
     {
 this.currentUser=      await Get.find<FirestoreService>().getCurrentUser( Get.find<GetStorageServices>().getId);

     }
    super.onInit();
  }
}