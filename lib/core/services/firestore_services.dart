import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/models/user_model.dart';
import 'package:lisudictionary_web/models/word_model.dart';

//in this file we have kept all firestore methods

class FirestoreService extends GetxService {
  final _firestore = FirebaseFirestore.instance;

//add new word to firestore with auto generated id
  Future addWord(Word word) async {
    try {
      return await _firestore.collection('words').add(word.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isExist(String? word) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('words')
          .where("word", isEqualTo: word)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future updateWord(Word word, String? id) async {
    try {
      return await _firestore.collection('words').doc(id).update(word.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Word>> getWords() async {
    return await _firestore.collection("words").get().then((value) =>
        value.docs.map((e) => Word.fromJson(e.data(), e.id)).toList());
  }

  Future<List<Word>> getContributorWords(String userId) async {
    return await _firestore
        .collection("words")
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) =>
            value.docs.map((e) => Word.fromJson(e.data(), e.id)).toList());
  }

  Future<UserModel> getCurrentUser(String? id) async {
    return await _firestore
        .collection("users")
        .doc(id)
        .get()
        .then((value) => UserModel.fromJson(value.data() as Map, value.id));
  }

  Future check(String id, bool action) async {
    return action == false
        ? await _firestore.collection("words").doc(id).delete()
        : await _firestore
            .collection("words")
            .doc(id)
            .update({"isVerified": action});
  }

  Future addUser(UserModel user, String? id) async {
    try {
      return await _firestore.collection("users").doc(id).set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
