import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/components/globals.dart' as globals;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:universal_platform/universal_platform.dart';

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

String getDomain(int mode) {
  if (UniversalPlatform.isAndroid) {
    if (mode == 1) {
      return "https://gourmetapp.net";
    } else {
      return "http://localhost:5000";
    }
  } else if (UniversalPlatform.isIOS) {
    if (mode == 1) {
      return "https://gourmetapp.net";
    } else {
      return "http://localhost:5000";
    }
  } else if (UniversalPlatform.isWeb) {
    if (mode == 1) {
      return "https://gourmetapp.net";
    } else {
      return "http://localhost:5000";
    }
  }
  return "error";
}

bool validateFileExtension(XFile image) {
  //int? idx = image.mimeType?.indexOf('/');
  String? ext = image.name.split(".").last;
  if (ext == "jpg" || ext == "png" || ext == "jpeg") {
    return true;
  }
  return false;
}

bool validateRequest(String mode) {
  var imagePresent;
  bool tagPresent = true;
  if (mode == "Classify") {
    if (UniversalPlatform.isWeb) {
      imagePresent = globals.webImageClassify ?? false;
    } else {
      imagePresent = globals.mobileImageClassify ?? false;
    }
  } else if (mode == "Add") {
    if (UniversalPlatform.isWeb) {
      imagePresent = globals.webImageAdd ?? false;
      if (globals.mealTag == "Nazwa twojej potrawy" ||
          globals.mealTag == "Brak") {
        tagPresent = false;
      }
    } else {
      imagePresent = globals.mobileImageAdd ?? false;
      if (globals.mealTag == "Nazwa twojej potrawy" ||
          globals.mealTag == "Brak") {
        tagPresent = false;
      }
    }
  } else if (mode == "Report") {
    if (UniversalPlatform.isWeb) {
      imagePresent = globals.webImageClassify ?? false;
      if (globals.ReportMealName == "") {
        tagPresent = false;
      }
    } else {
      imagePresent = globals.mobileImageClassify ?? false;
      if (globals.ReportMealName == "") {
        tagPresent = false;
      }
    }
  }

  if (imagePresent == false || tagPresent == false) {
    return false;
  }
  return true;
}

void showTopSnackBarCustomSuccess(dynamic context, dynamic text) {
  showTopSnackBar(
    context,
    CustomSnackBar.success(
      icon: Icon(null),
      backgroundColor: Color.fromARGB(255, 0, 211, 109),
      message: text,
    ),
  );
}

void showTopSnackBarCustomError(dynamic context, dynamic text) {
  showTopSnackBar(
    context,
    CustomSnackBar.error(
      icon: Icon(null),
      // backgroundColor: color,
      message: text,
    ),
  );
}

Widget buildPicture() {
  return globals.isClassify
      // Classify
      ? globals.webImageClassify != null || globals.mobileImageClassify != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: globals.webImageClassify != null
                  ? Image.memory(
                      globals.webImageClassify!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      globals.mobileImageClassify!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ))
          : Image.asset('assets/diet.png', width: 200, height: 200)
      // Add
      : globals.webImageAdd != null || globals.mobileImageAdd != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: globals.webImageAdd != null
                  ? Image.memory(
                      globals.webImageAdd!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      globals.mobileImageAdd!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ))
          : Image.asset('assets/dish.png', width: 200, height: 200);
}

void fetchCatalog() async {
  //Until android will be able to connect to our API we will use static list.
  if (UniversalPlatform.isAndroid) {
    globals.catalogBody = [
      "Brokuł",
      "Sałatka cezar",
      "Marchewka",
      "Sernik",
      "Skrzydełka kurczaka",
      "Tort czekoladowy",
      "Babeczki",
      "Winniczki",
      "Frytki",
      "Hamburger",
      "Hot dog",
      "Lody",
      "Lasagne",
      "Omlet",
      "Naleśniki",
      "Pizza",
      "Żeberka",
      "Jajecznica",
      "Zupa",
      "Spaghetti bolognese",
      "Spaghetti carbonara",
      "Stek",
      "Sushi",
      "Tiramisu",
      "Gofry",
    ];
  } else {
    //For other IOS and WEB we can download catalog with API.
    List<String> catalogString = [];
    final response =
        await http.get(Uri.parse('https://gourmetapp.net/catalog'));

    if (response.statusCode == 200) {
      var catalogJson = json.decode(response.body);
      for (var element in catalogJson) {
        catalogString.add(element);
      }
      globals.catalogBody = catalogString;
    } else {
      throw Exception('Failed to load catalog');
    }
  }
}

// void initializeCards() {
//   globals.tile1 = Tile(
//       mealName: "[Animacja 3 kropek]",
//       mealDescription: "",
//       mealProbability: 0,
//       color: const Color(0xFFE5B80B),
//       gradient1: Colors.orange,
//       gradient2: Colors.amber,
//       numberOfStars: 3);
//   // Tile 2
//   globals.tile2 = Tile(
//       mealName: "[Animacja 3 kropek]",
//       mealDescription: "",
//       mealProbability: 0,
//       color: const Color(0xFFC4CACE),
//       gradient1: const Color(0xFF526573),
//       gradient2: const Color(0xFF9CAABD),
//       numberOfStars: 2);
//   // Tile 3
//   globals.tile3 = Tile(
//       mealName: "[Animacja 3 kropek]",
//       mealDescription: "",
//       mealProbability: 0,
//       color: const Color(0xFFA46628),
//       gradient1: const Color(0xFF7B4C1E),
//       gradient2: const Color(0xFFB9772D),
//       numberOfStars: 1);
// }
