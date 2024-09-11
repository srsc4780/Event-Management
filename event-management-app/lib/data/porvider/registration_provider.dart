import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_tracker/data/network/repository/repository.dart';
import 'package:sales_tracker/pages/auth_pages/login/view/login_page.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/utils.dart';

class RegistrationProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? nameError;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearErrors() {
    emailError = null;
    passwordError = null;
    nameError = null;
    notifyListeners();
  }

  // Function to handle registration
  Future<void> postRegister(BuildContext context) async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passController.text.trim();
    final String confirmPassword = confirmPassController.text.trim();

    if (password != confirmPassword) {
      _showErrorDialog(context, 'Passwords do not match.');
      return;
    }

    final Map<String, dynamic> requestData = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      setLoading(true);
      clearErrors();

      var apiResponse = await RepositoryImpl(context).postRegister(requestData);
      printDebug("apiResponse");
      printDebug(apiResponse);

      // Remove the unnecessary type check
      bool success = apiResponse['success'] ?? false;
      String message = apiResponse['message'] ?? '';

      if (success) {
        Fluttertoast.showToast(msg: message);
        // ignore: use_build_context_synchronously
        NavUtil.navigateScreen(context, const LoginPage());
      } else {
        if (apiResponse['data'] != null) {
          // Process validation errors from the response
          _processErrors(apiResponse['data']);
        } else {
          Fluttertoast.showToast(msg: message);
        }
      }
    } catch (e) {
      printDebug(e);
      // ignore: use_build_context_synchronously
      _showErrorDialog(context, 'Failed to connect to the server.');
    } finally {
      setLoading(false);
    }
  }

  void _processErrors(List<dynamic> errors) {
    clearErrors(); // Clear previous errors

    for (var error in errors) {
      String field = error['path'];
      String message = error['msg'];

      if (field == 'email') {
        emailError = message;
      } else if (field == 'password') {
        passwordError = message;
      } else if (field == 'name') {
        nameError = message;
      }
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
