import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void showSnackBarAtTop({
    required String message,
    String? title,
    Color? color,
  }) {
    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      borderRadius: 8.r,
      snackStyle: SnackStyle.FLOATING,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          13.w.horizontalSpace,
          InkWell(
            onTap: Get.back,
            child: Icon(Icons.close, color: Colors.white, size: 16.sp),
          )
        ],
      ),
      titleText: Container(),
      backgroundColor: color??Colors.red,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 6),
    );
  }
}


