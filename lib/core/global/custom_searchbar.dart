import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/asset_path.dart';


class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    super.key,
    this.searchController,
    required this.isEnabled,
    required this.isHomeColor,
    this.height,
    this.width,
  });

  final searchQueryNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> searchResult = ValueNotifier<String>("");
  final TextEditingController? searchController;
  final bool isEnabled;
  final bool isHomeColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: searchQueryNotifier,
      builder: (context, searchQuery, _) {
        return Container(
          height: height ?? 70.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isHomeColor ? Color(0xFFF5F5F5) : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Color(0xFFDFE1E7), width: 1.w),
          ),
          child: TextFormField(
            // controller: searchController,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            // onChanged: (value) {
            //   // searchQueryNotifier.value = value;
            //   validateLicenseNumber(context, licenseController);
            // },
            decoration: InputDecoration(
              enabled: isEnabled,
              prefixIcon: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetPath.searchIcon,
                      width: width ?? 18.w,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              hintText: 'findEvent'.tr,
              hintStyle: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF718096),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            ),
          ),
        );
      },
    );
  }
}
