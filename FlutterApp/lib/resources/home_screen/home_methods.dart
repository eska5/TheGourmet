import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:new_ui/main.dart';

void handleButtonClick() {
  final GButton gbtn = MainScreen.gButtonClassifyKey.currentWidget as GButton;
  gbtn.onPressed!();
}
