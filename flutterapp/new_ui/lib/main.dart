import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:ui';
import 'package:flutter_native_splash/flutter_native_splash.dart';

bool smallSreen() {
  var pixelRatio = window.devicePixelRatio;
  //Size in physical pixels
  var physicalScreenSize = window.physicalSize;
  var physicalWidth = physicalScreenSize.width;
  var physicalHeight = physicalScreenSize.height;

  //Size in logical pixels
  var logicalScreenSize = window.physicalSize / pixelRatio;
  var logicalWidth = logicalScreenSize.width;
  var logicalHeight = logicalScreenSize.height;

  if (logicalWidth < 390) {
    return true;
  } else {
    return false;
  }
}

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';
  @override
  Widget build(BuildContext context) {
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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Container(
      color: Colors.indigo[50],
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 9,
          ),
          Text('Gourmet',
              style: GoogleFonts.caveat(
                fontSize: 90,
                textStyle: TextStyle(letterSpacing: 7),
              )),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/hot.png",
            height: 290,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Jakub Sachajko & Łukasz Niedźwiadek © 2022',
              style: GoogleFonts.caveat(
                fontSize: 17,
                textStyle: TextStyle(letterSpacing: 0),
              )),
        ],
      ),
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
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
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: smallSreen()
            ? BottomNavigationBar(
                backgroundColor: Colors.indigo,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.indigo,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calculate_rounded),
                    label: 'Rozpoznaj potrawę',
                    backgroundColor: Colors.indigo,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_photo_alternate_rounded),
                    label: 'Dodaj potrawę',
                    backgroundColor: Colors.indigo,
                  )
                ],
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.indigo[50],
                onTap: _onItemTapped,
              )
            : BottomNavigationBar(
                backgroundColor: Colors.indigo,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.indigo,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calculate_rounded),
                    label: 'Rozpoznaj potrawę',
                    backgroundColor: Colors.indigo,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_photo_alternate_rounded),
                    label: 'Dodaj potrawę',
                    backgroundColor: Colors.indigo,
                  )
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.indigo[50],
                onTap: _onItemTapped,
              ));
  }
}
