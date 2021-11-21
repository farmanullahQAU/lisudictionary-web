import 'package:get/get.dart';
import 'package:lisudictionary_web/controllers/dictionary_form_controller.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/models/word_model.dart';
import 'package:lisudictionary_web/screens/dashboard/components/dictionary_form.dart';
import 'package:lisudictionary_web/screens/dashboard/components/recent_files.dart';

class RecentController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

//verify or reject contributor word
  myAction(word,bool action){
    Get.find<FirestoreService>().check(word.id,action);

  }

  updateWord(Word word)
  {
    //to show updated button instead of submitt
    Get.find<DictFormController>().isUpdate=true;
    //to fill form with old values
    Get.find<DictFormController>().initFields(word);
    Get.to(()=>DictionarForm());

  }
}