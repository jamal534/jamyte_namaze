import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class DropdownController extends GetxController {
  final _selectedValues = <String, String>{}.obs;

  void initValue(String key, String value) {
    if (!_selectedValues.containsKey(key)) {
      Future.delayed(Duration.zero, () {
        _selectedValues[key] = value; // ✅ Delayed update avoids setState() error
      });
    }
  }

  void changeValue(String key, String value) {
    _selectedValues[key] = value;
  }

  String getSelectedValue(String key) {
    return _selectedValues[key] ?? "";
  }
}



class CustomDropdown extends StatelessWidget {
  final String dropdownKey;
  final List<String> items;
  final Function(String) onChanged;

  CustomDropdown({
    Key? key,
    required this.dropdownKey,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DropdownController controller=Get.put(DropdownController());

    // ✅ Ensure the value is initialized without causing build errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initValue(dropdownKey, items.first);
    });

    return Obx(() {
      return Container(
        height: 48.h,
        width: 166.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1EB38E),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.getSelectedValue(dropdownKey),
            onChanged: (newValue) {
              controller.changeValue(dropdownKey, newValue!);
              onChanged(newValue!);
            },
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              );
            }).toList(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            isExpanded: true,
          ),
        ),
      );
    });
  }
}
