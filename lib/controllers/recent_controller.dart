import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/models/word_model.dart';
import 'package:lisudictionary_web/screens/dashboard/components/recent_files.dart';

class RecentController extends GetxController{
  RxList<Word>? words= [
    Word(
        isVerified: false,
        word: "Hungry",
        engDefinition: "Feeling hunger",
        burmerDefinition: "sarlaungmhuko  hkanhcarrrahkyinn",
        lisuDefinition: "Hunger definition in lisu language",
        engExamples: ["i dont feel hungry", "he seems hungry"],
        burmerExamples: ["hunger example1 in burmer", "hunger example2 in burmer"],

        lisuExamples: ["hunger example 1 in lisu", "hunger example 2 in lisu"]
    ),
    Word(
        word: "Beloved",
        isVerified: false,


        engDefinition: "A beloved person",
        burmerDefinition: "beloved definition in burmer ",
        lisuDefinition: "beloved definition in lisu language",
        engExamples: ["beloved child", "he is her beloved son"],
        burmerExamples: ["beloved example1 in burmer", "beloved example2 in burmer"],

        lisuExamples: ["beloved example 1 in lisu", "beloved example 2 in lisu"]
    ),


    Word(
        isVerified: false,


        word: "Love",
        engDefinition: "love some one",
        burmerDefinition: "burmer definition",
        lisuDefinition: "defintion in lisu",
        engExamples: ["to beloved osomeone very", "this is example 2 in enblish"],
        burmerExamples: ["burmer examples 1", "burmer example 2"],

        lisuExamples: ["isu example 1",'isu exmple 2', "isu example 3"]
    ),

    Word(
        word: "Hate",
        isVerified: true,
        engDefinition: "hate someone .....",
        burmerDefinition: "burmer definition Hate",
        lisuDefinition: "defintion in lisu",
        engExamples: [
          "to hate osomeone very hated",
          "this is hate example 2 in enblish"
        ],
        burmerExamples: [
          "burmer examples of hate",
          "burmer example 2"
        ],

        lisuExamples: ["isu example for hate 1",'isu exmple for hate 2', "isu example for hate 3"]

    )
  ].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

//verify or reject contributor word
  myAction(word,bool action){
    Get.find<FirestoreService>().check(word.id,action);

  }
}