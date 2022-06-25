library gourmet.globals;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:new_ui/components/tile.dart';

//Data For Tiles
String mealTag = "Nazwa twojej potrawy";
String modelOutput1 = 'Tutaj nazwa';
double modelChance1 = 0;
String modelOutput2 = 'Tutaj nazwa';
double modelChance2 = 0;
String modelOutput3 = 'Tutaj nazwa';
double modelChance3 = 0;
Color firstColor = Color(0xFFE5B80B);
Color secondColor = Color(0xFFC4CACE);
Color thirdColor = Color(0xFFA46628);

//Error section
// ignore: non_constant_identifier_names
Color ErrorColor = Color(0xFFDC143C);

//Images section
File? mobileImageAdd;
Uint8List? webImageAdd;
File? mobileImageClassify;
Uint8List? webImageClassify;
bool mealClassified = false;
// ignore: non_constant_identifier_names
String ReportMealName = "";

// Is it on classify site
bool isClassify = false;
// Is picture for classify ready
bool isClassifyReady = false;

// Tile Section
Tile? tile1;
Tile? tile2;
Tile? tile3;
