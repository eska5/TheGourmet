import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

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
  if (Platform.isAndroid) {
    if (mode == 1) {
      return "https://gourmet.hopto.org:5000";
    } else {
      return "http://10.0.2.2:5000";
    }
  } else if (Platform.isIOS) {
    if (mode == 1) {
      return "https://gourmet.hopto.org:5000";
    } else {
      return "http://localhost:5000";
    }
  } else if (kIsWeb) {
    //TODO for web
    return "";
  }
  return "error";
}
