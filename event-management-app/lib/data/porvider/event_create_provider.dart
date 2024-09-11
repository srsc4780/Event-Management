import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_tracker/data/network/repository/repository.dart';
import 'package:sales_tracker/pages/bottom_nav_bar/custom_bottom_nav.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/utils.dart';

class EventCreateProvider with ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController organizerController = TextEditingController();
  final TextEditingController eventTypeController = TextEditingController();

  String? titleError;
  String? descriptionError;
  String? dateError;
  String? locationError;
  String? organizerError;
  String? eventTypeError;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearErrors() {
    titleError = null;
    descriptionError = null;
    dateError = null;
    locationError = null;
    organizerError = null;
    eventTypeError = null;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final String title = titleController.text.trim();
      final String description = descriptionController.text.trim();
      final String date = dateController.text.trim();
      final String location = locationController.text.trim();
      final String organizer = organizerController.text.trim();
      final String eventType = eventTypeController.text.trim();

      final Map<String, dynamic> requestData = {
        'title': title,
        'description': description,
        'date': date,
        'location': location,
        'organizer': organizer,
        'eventType': eventType,
      };

      try {
        setLoading(true);
        clearErrors();

        var apiResponse = await RepositoryImpl(context).postEvent(requestData);
        printDebug("apiResponse");
        printDebug(apiResponse);

        bool success = apiResponse['success'] ?? false;
        String message = apiResponse['message'] ?? '';

        if (success) {
          Fluttertoast.showToast(msg: message);
          // Navigate to another page or show a success message
          NavUtil.navigateScreen(
            context, const CustomBottomNavBar(bottomNavigationIndex: 1));
          // For example: NavUtil.navigateScreen(context, const SuccessPage());
        } else {
          if (apiResponse['data'] != null) {
            _processErrors(apiResponse['data']);
          } else {
            Fluttertoast.showToast(msg: message);
          }
        }
      } catch (e) {
        printDebug(e);
        _showErrorDialog(context, 'Failed to connect to the server.');
      } finally {
        setLoading(false);
      }
    }
  }

  void _processErrors(List<dynamic> errors) {
    clearErrors(); // Clear previous errors

    for (var error in errors) {
      String field = error['path'];
      String message = error['msg'];

      if (field == 'title') {
        titleError = message;
      } else if (field == 'description') {
        descriptionError = message;
      } else if (field == 'date') {
        dateError = message;
      } else if (field == 'location') {
        locationError = message;
      } else if (field == 'organizer') {
        organizerError = message;
      } else if (field == 'eventType') {
        eventTypeError = message;
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
