import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  ///============================ Sign In =========================///

  final TextEditingController logInEmailController = TextEditingController();
  final TextEditingController logInPasswordController = TextEditingController();

  ///================================= Sing UP ========================================///

  final TextEditingController singUpUserName = TextEditingController();
  final TextEditingController singUpEmail = TextEditingController();
  final TextEditingController singUpPassword = TextEditingController();

  ///==================================== Forget ==========================================///
  final TextEditingController forget = TextEditingController();

  ///===================================== Otp =============================================///

  final TextEditingController otp = TextEditingController();
  final TextEditingController resetOtp = TextEditingController();


  /// ============================= CreatNew Password ===========================================//

  TextEditingController newPassword = TextEditingController();
  TextEditingController newConfirmPass = TextEditingController();

  /// =================================== Change Password Controller ========================================///

  TextEditingController changePassController = TextEditingController();
  TextEditingController changeConfirmPass = TextEditingController();

  /// ================================== Reset Email <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<///

  TextEditingController resetEmail = TextEditingController();
  TextEditingController resetPhone = TextEditingController();


  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Reset Otp <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<///


// RxString activationCode = "".obs;
  @override
  void onClose() {
    // logInEmailController.dispose();
    // logInPasswordController.dispose();
    // singUpUserName.dispose();
    // singUpEmail.dispose();
    // singUpPassword.dispose();
    // forget.dispose();
    otp.dispose();
    // newPassword.dispose();
    // newConfirmPass.dispose();
    // changePassController.dispose();
    // changeConfirmPass.dispose();
    super.onClose();
  }
}
