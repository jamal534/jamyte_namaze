class AppUrls {
  static const String _baseUrl = 'https://salahmarhaba.com/api/v1';
  static const String registerUrl = '$_baseUrl/users/create';
  static const String signup_verify_otp =
      '$_baseUrl/users/signup-verification';

  static const String loginUrl = '$_baseUrl/auth/login';

  static const String auth_login = '$_baseUrl/auth/auth-login';

  static const String send_otp = '$_baseUrl/auth/send-otp';
  static const String verify_otp = '$_baseUrl/auth/verify-otp';
  static const String reset_pass = '$_baseUrl/auth/reset-password';


  static const String profile = '$_baseUrl/auth/profile';

  static const String profileImage = '$_baseUrl/auth/update/profile-image';

  static const String complaint = '$_baseUrl/auth/submit-complaint';


  static const String update_location = '$_baseUrl/auth/update/user-location';

  static const String create_advertising = '$_baseUrl/advertising/create';
  static const String leave = '$_baseUrl/advertising/leave-jamat';

  static const String my_rooms = '$_baseUrl/messages/my-rooms';


  // static const String complaint = '$_baseUrl/auth/submit-complaint';
  // static const String complaint = '$_baseUrl/auth/submit-complaint';
  // static const String complaint = '$_baseUrl/auth/submit-complaint';





}

