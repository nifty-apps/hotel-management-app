import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:hotel_management/controller/auth_controller.dart';
import 'package:hotel_management/models/user.dart';
import 'package:hotel_management/utils/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends GetxController {
  Future<void> saveUser(User user) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('currentUser', user.toJson());
  }

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }

  Future<void> removeTokenAndUser() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.remove('currentUser');
  }

  Future<List<dynamic>?> loadTokenAndUser() async {
    final pref = await SharedPreferences.getInstance();
    final currentUser = pref.getString('currentUser') != null
        ? User.fromJson(pref.getString('currentUser')!)
        : null;
    final token = pref.getString('token');
    if (currentUser == null || token == null) return null;
    Get.find<ApiClient>().updateToken(token);
    Get.find<AuthController>().userData = currentUser;
    return [token, currentUser];
  }
}
