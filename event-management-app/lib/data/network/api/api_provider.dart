class ApiProvider {

  static const String baseUrl = 'http://192.168.0.155:5000/api';
  // static const String baseUrl = 'https://event-management-api-waic.onrender.com/api';

  static String login = '$baseUrl/auth/login';
  static String registration = '$baseUrl/auth/register';
  static String dashboard = '$baseUrl/dashboard';

  static String eventFilter = '$baseUrl/events/filter';
  static String eventCreate = '$baseUrl/events';


  static String forgetPassword = '$baseUrl/email/forgot-password';
  static String resetPassword = '$baseUrl/email/reset-password';
  static String profileUpdate = '$baseUrl/profile-update';
  static String passwordUpdate = '$baseUrl/password-update';
  static String notification = '$baseUrl/notifications';
  static String postRegisterApi = '$baseUrl/auth/registration';
  static String postRegisterApiStep2 = '$baseUrl/auth/registration';
  static String notificationApi = '$baseUrl/notifications';
}
