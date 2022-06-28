library gourmet.globals;

import 'dart:io';
import 'dart:typed_data';

import 'package:new_ui/components/tile.dart';

String mealTag = "Nazwa twojej potrawy";

//Images section
File? mobileImageAdd;
Uint8List? webImageAdd;
File? mobileImageClassify;
Uint8List? webImageClassify;
bool mealClassified = false;
// ignore: non_constant_identifier_names
String ReportMealName = "";
List<String> catalogBody = [];

// Is it on classify site
bool isClassify = false;
// Is picture for classify ready
bool isClassifyReady = false;

// Tile Section
Tile? tile1;
Tile? tile2;
Tile? tile3;
