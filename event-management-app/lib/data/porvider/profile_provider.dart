import 'package:flutter/material.dart';
import 'package:sales_tracker/data/model/user_model.dart';
import 'package:sales_tracker/utils/utils.dart';

class ProfileProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    nameController.text = user.name ?? '';
    emailController.text = user.email ?? '';
    notifyListeners();
  }

  Future<void> updateProfile(BuildContext context) async {
    if (_user == null) return;

    // Create an updated user model
    final updatedUser = UserModel(
      name: nameController.text,
      email: emailController.text,
      token: _user!.token,
    );

    printDebug(updatedUser);

    // Call the API to update the user profile
    try {
      // Simulate an API call
      await Future.delayed(const Duration(seconds: 2));
      // Update the user data
      _user = updatedUser;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }
}
