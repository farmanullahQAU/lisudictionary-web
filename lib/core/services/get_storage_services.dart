import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageServices extends GetxService{

  final idBox = GetStorage();
  String? get getId => idBox.read('id') ?? "";

  Future saveId(String? userId) async{

  return await idBox.write('id', userId);


  }

}