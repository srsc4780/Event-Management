import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/local/local_auth_provider.dart';
import 'package:sales_tracker/data/model/user_model.dart';
import 'package:sales_tracker/data/network/dio/global_state.dart';
import 'package:sales_tracker/data/network/repository/repository.dart';
import 'package:sales_tracker/pages/bottom_nav_bar/custom_bottom_nav.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/utils.dart';

class LoginProvider extends  ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearErrors() {
    emailError = null;
    passwordError = null;
    notifyListeners();
  }

  // Function to handle login
  Future<void> postLogin(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passController.text.trim();

    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    try {
      setLoading(true);
      clearErrors();

      var apiResponse = await RepositoryImpl(context)
          .postLogin(requestData); 
      bool success = apiResponse['success'] ?? false;
      String message = apiResponse['message'] ?? '';

      if (success) {
        var user = apiResponse['data'];
        GlobalState.instance.set('token', user["token"]);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User Login Successfully")),
        );
        context.read<LocalAutProvider>().updateUser(UserModel(
              token: user["token"],
              name: user["name"],
              email: user["email"],
            ));
        NavUtil.navigateScreen(
            context, const CustomBottomNavBar(bottomNavigationIndex: 0));
        Fluttertoast.showToast(msg: message);
        // ignore: use_build_context_synchronously
       NavUtil.navigateScreen(
            context, const CustomBottomNavBar(bottomNavigationIndex: 0));
      } else {
        printDebug("apiResponse['data']");
        printDebug(apiResponse['data']);
        if (apiResponse['data'] != null) {
          _processErrors(apiResponse['data']);
        } else {
          Fluttertoast.showToast(msg: message);
        }
      }
    } catch (e) {
      printDebug(e.toString());
      // ignore: use_build_context_synchronously
      _showErrorDialog(context, 'Failed to login');
    } finally {
      setLoading(false);
    }
  }

  void _processErrors(Map<String, dynamic> errors) {
    clearErrors(); // Clear previous errors

    // Process validation errors
    if (errors.containsKey('email')) {
      emailError = errors['email']?.toString();
    }
    if (errors.containsKey('password')) {
      passwordError = errors['password']?.toString();
    }

    notifyListeners();
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
