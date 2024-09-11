import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../model/user_model.dart';

const String userBoxName = 'userModel';

class LocalAutProvider extends ChangeNotifier {
  ///persist user data
  ///update user data
  var box = Hive.box<UserModel>(userBoxName);

  ///update or store newly logged in user data
  void updateUser(UserModel? user) async {
    await box.put(0, user!);
    notifyListeners();
  }

  ///get logged in user data
  UserModel? getUser() {
    return box.isNotEmpty ? box.get(0) : null;
  }

  ///delete logged in user data
  Future<void> deleteUser() async{
    await box.delete(0);
    notifyListeners();
  }
}
