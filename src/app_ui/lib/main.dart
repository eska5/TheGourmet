import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ui/resources/common/methods.dart';
import 'package:new_ui/resources/common/nav_bar.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(milliseconds: 100));
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  static const String _title = 'Gourmet';
  static PageController controller = PageController();
  static GlobalKey gButtonClassifyKey = GlobalKey(debugLabel: "mid_nav_btn");

  @override
  Widget build(BuildContext context) {
    fetchCatalog();
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: navBar(
        controller: controller,
        gButtonClassifyKey: gButtonClassifyKey,
      ), //MyStatefulWidget(),
    );
  }
}
