import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/auth_services.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';
import 'package:lisudictionary_web/models/user_model.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

  UserModel? currentUser;

  bool isAdmin() {
    if (this.currentUser?.isAdmin == true)
      return true;
    else
      return false;
  }

  Future<UserModel> getCurrentUser() async {
    UserModel currUser = new UserModel();
    if (Get.find<GetStorageServices>().getId != "") {
      //get detail for current user
      currUser = await Get.find<FirestoreService>()
          .getCurrentUser(Get.find<GetStorageServices>().getId);

      await Get.find<GetStorageServices>().saveRole(currentUser?.isAdmin);
      this.currentUser = currUser;
    }

    return currUser;
  }
}
