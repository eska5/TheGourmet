import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showSuccessMessage(dynamic context, dynamic text) {
  showTopSnackBar(
    context,
    CustomSnackBar.success(
      icon: const Icon(null),
      backgroundColor: const Color(0xFF00D36D),
      message: text,
    ),
    displayDuration: Duration(seconds: 1),
  );
}

void showErrorMessage(dynamic context, dynamic text) {
  showTopSnackBar(
    context,
    CustomSnackBar.error(
      icon: const Icon(null),
      // backgroundColor: color,
      message: text,
      backgroundColor: const Color(0xFFDC143C),
      textStyle: const TextStyle(
          fontFamily: 'avenir',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 19),
    ),
    displayDuration: const Duration(seconds: 1),
  );
}

void showWarningMessage(dynamic context, dynamic text) {
  showTopSnackBar(
    context,
    CustomSnackBar.info(
      icon: const Icon(null),
      // backgroundColor: color,
      message: text,
      backgroundColor: const Color(0xFFFE9901),
      textStyle: const TextStyle(
          fontFamily: 'avenir',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 19),
    ),
    displayDuration: const Duration(seconds: 2),
  );
}
