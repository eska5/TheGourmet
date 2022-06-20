import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/components/globals.dart' as globals;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:universal_platform/universal_platform.dart';

bool smallSreen() {
  var pixelRatio = window.devicePixelRatio;
  var logicalScreenSize = window.physicalSize / pixelRatio;
  var logicalWidth = logicalScreenSize.width;

  if (logicalWidth < 370) {
    return true;
  } else {
    return false;
  }
}

String getDomain(int mode) {
  if (UniversalPlatform.isAndroid) {
    if (mode == 1) {
      return "https://gourmetapp.net";
    } else {
      return "http://localhost:5000";
    }
  } else if (UniversalPlatform.isIOS) {
    if (mode == 1) {
      return "https://gourmetapp.net";
    } else {
      return "http://localhost:5000";
    }
  } else if (UniversalPlatform.isWeb) {
    if (mode == 1) {
      return "https://gourmetapp.net";
    } else {
      return "http://localhost:5000";
    }
  }
  return "error";
}

bool validateFileExtension(XFile image) {
  //int? idx = image.mimeType?.indexOf('/');
  String? ext = image.name.split(".").last;
  if (ext == "jpg" || ext == "png" || ext == "jpeg") {
    return true;
  }
  return false;
}

bool validateRequest(String mode) {
  var imagePresent;
  bool tagPresent = true;
  if (mode == "Classify") {
    if (UniversalPlatform.isWeb) {
      imagePresent = globals.webImageClassify ?? false;
    } else {
      imagePresent = globals.mobileImageClassify ?? false;
    }
  } else if (mode == "Add") {
    if (UniversalPlatform.isWeb) {
      imagePresent = globals.webImageAdd ?? false;
      if (globals.mealTag == "Nazwa twojej potrawy" ||
          globals.mealTag == "Brak") {
        tagPresent = false;
      }
    } else {
      imagePresent = globals.mobileImageAdd ?? false;
      if (globals.mealTag == "Nazwa twojej potrawy" ||
          globals.mealTag == "Brak") {
        tagPresent = false;
      }
    }
  } else if (mode == "Report") {
    if (UniversalPlatform.isWeb) {
      imagePresent = globals.webImageClassify ?? false;
      if (globals.ReportMealName == "") {
        tagPresent = false;
      }
    } else {
      imagePresent = globals.mobileImageClassify ?? false;
      if (globals.ReportMealName == "") {
        tagPresent = false;
      }
    }
  }

  if (imagePresent == false || tagPresent == false) {
    return false;
  }
  return true;
}

void showTopSnackBarCustomSuccess(dynamic context, dynamic text) {
  showTopSnackBar(
    context,
    CustomSnackBar.success(
      icon: Icon(null),
      backgroundColor: Color.fromARGB(255, 0, 211, 109),
      message: text,
    ),
  );
}

void showTopSnackBarCustomError(dynamic context, dynamic text) {
  showTopSnackBar(
    context,
    CustomSnackBar.error(
      icon: Icon(null),
      // backgroundColor: color,
      message: text,
    ),
  );
}
