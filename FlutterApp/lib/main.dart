import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ui/screens/add.dart';
import 'package:new_ui/screens/classify.dart';
import 'package:new_ui/screens/home.dart';

import 'functions/func.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Gourmet';

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
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  int currentPage = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    ClassifyImage(),
    AddImage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Center(
            child: _widgetOptions[currentPage],
          ),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          barBackgroundColor: Colors.indigo[100],
          inactiveIconColor: Colors.indigo,
          textColor: Colors.grey[850],
          circleColor: Colors.indigo,
          activeIconColor: Colors.indigo[100],
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.calculate_rounded, title: "Rozpoznaj"),
            TabData(iconData: Icons.add_photo_alternate_rounded, title: "Dodaj")
          ],
          initialSelection: 0,
          key: bottomNavigationKey,
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ));
  }
}
