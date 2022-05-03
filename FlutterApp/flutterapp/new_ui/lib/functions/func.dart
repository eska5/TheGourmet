import 'dart:ui';

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
      return "https://gourmetapp.net:5000";
    } else {
      return "http://10.0.2.2:5000";
    }
  } else if (UniversalPlatform.isIOS) {
    if (mode == 1) {
      return "https://gourmetapp.net:5000";
    } else {
      return "http://localhost:5000";
    }
  } else if (UniversalPlatform.isWeb) {
    if (mode == 1) {
      return "https://gourmetapp.net:5000";
    } else {
      return "http://localhost:5000";
    }
  }
  return "error";
}
