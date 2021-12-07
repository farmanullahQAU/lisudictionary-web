import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageServices extends GetxService {
  final idBox = GetStorage();
  String? get getId => idBox.read('id') ?? "";
  bool? get isAdmin => idBox.read('role') ?? null;

  Future saveId(String? userId) async {
    await idBox.write('id', userId);
  }

  Future saveRole(bool? isAdmin) async {
    await idBox.write('role', isAdmin);
  }
}
