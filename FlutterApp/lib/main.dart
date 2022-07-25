import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ui/screens/add.dart';
import 'package:new_ui/screens/classify.dart';
import 'package:new_ui/screens/home.dart';

import 'navbar.dart';
import 'resources/common/func.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const String _title = 'Gourmet';
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    fetchCatalog();
    FlutterNativeSplash.remove();
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: navBar(controller: controller), //MyStatefulWidget(),
    );
  }
}
