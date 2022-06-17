library gourmet.globals;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:new_ui/components/tile.dart';

String mealTag = "Nazwa twojej potrawy";
String modelOutput = 'Tutaj pojawi się wynik';
String modelOutput1 = 'Tutaj nazwa';
double modelChance1 = 0;
String modelOutput2 = 'Tutaj nazwa';
double modelChance2 = 0;
String modelOutput3 = 'Tutaj nazwa';
double modelChance3 = 0;
Color firstColor = Color(0xFFE5B80B);
Color secondColor = Color(0xFFC4CACE);
Color thirdColor = Color(0xFFA46628);
Color ErrorColor = Color(0xFFDC143C);
File? mobileImageAdd;
Uint8List? webImageAdd;
File? mobileImageClassify;
Uint8List? webImageClassify;
bool mealClassified = false;
String ReportMealName = "";
Tile tile1 = Tile(mealName: modelOutput1, mealDescription: modelOutput1, mealProbability: modelChance1*100, color: firstColor, gradient1: Colors.orange,gradient2: Colors.amber,numberOfStars: 3);
Tile tile2 = Tile(mealName: modelOutput2, mealDescription: modelOutput2, mealProbability: modelChance2*100, color: secondColor,gradient1: Color(0xFF526573),gradient2: Color(0xFF9CAABD),numberOfStars: 2);
Tile tile3 = Tile(mealName: modelOutput3, mealDescription: modelOutput3, mealProbability: modelChance3*100, color: thirdColor,gradient1: Color(0xFF7B4C1E),gradient2: Color(0xFFB9772D),numberOfStars: 1);
  
List<Tile> listOfTiles = [tile1,tile2,tile3];