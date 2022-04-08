import 'dart:ui';

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
