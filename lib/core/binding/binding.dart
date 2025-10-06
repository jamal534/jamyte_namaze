
import 'package:get/get.dart';
import 'package:jamayate_namaj/features/Home_flow/widgets/custom_dropdown.dart';
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => DropdownController());
  }
}
