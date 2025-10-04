import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:jamayate_namaj/features/auth/presentation/screen/create_newPassword.dart';
import 'package:jamayate_namaj/features/auth/presentation/screen/forgot_password.dart';
import 'package:jamayate_namaj/features/auth/presentation/screen/login_screen.dart';
import 'package:jamayate_namaj/features/auth/presentation/screen/reset_password_verify.dart';
import 'package:jamayate_namaj/features/auth/presentation/screen/sing_up_screen.dart';
import 'package:jamayate_namaj/features/navbar/presentation/screen/bottom_navbar.dart';
import 'package:jamayate_namaj/features/notification/presentation/screen/notification_screen.dart';
import 'package:jamayate_namaj/features/onbording/presentation/screen/onbording_screen.dart';
import '../../features/auth/presentation/screen/singUPotp_screen.dart';
import '../../features/splash_screen/presentation/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String loginScreen = "/loginScreen";
  static String singUpScreen = "/singUpScreen";
  static String singUPOtpScreen = "/singUPOtpScreen";
  static String forgotPassword = "/forgotPassword";
  static String resetPasswordVerify = "/resetPasswordVerify";
  static String createNewPassword = "/createNewPassword";
  static String notificationScreen = "/notificationScreen";
  static String navBar = "/navBar";

  static List<GetPage> route = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnbordingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: singUpScreen, page: () => SingUpScreen()),
    GetPage(name: singUPOtpScreen, page: () => SignUpOtpScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPassword()),
    // GetPage(name: resetPasswordVerify, page: () => ResetPasswordVerify()),
    GetPage(name: createNewPassword, page: () => CreateNewPassword()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: navBar, page: () => NavBar()),
  ];
}
