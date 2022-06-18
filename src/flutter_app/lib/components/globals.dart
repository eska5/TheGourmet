library gourmet.globals;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

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
