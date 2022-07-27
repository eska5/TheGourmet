import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/resources/common/globals.dart' as globals;
import 'package:new_ui/resources/common/snack_bars.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../screens/catalog.dart';
import '../classify_screen/classify_methods.dart';

void navigateToCatalog(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MealCatalog()),
  );
}

Future<Uint8List?> pickImage(
    ImageSource source, BuildContext context, bool forClassification) async {
  Uint8List? imageTemporary;
  //WEB
  if (kIsWeb) {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, maxWidth: 400, maxHeight: 400);
      if (image == null) return null;

      if (!validateFileExtension(image)) {
        showErrorMessage(context, "Wybrano niepoprawny format zdjęcia");
        return null;
      }

      imageTemporary = await image.readAsBytes();
      //categorizeThePhoto(context, imageTemporary);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
  //MOBILE
  else {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, maxWidth: 400, maxHeight: 400);
      if (image == null) return null;

      if (!validateFileExtension(image)) {
        showErrorMessage(context, "Wybrano niepoprawny format zdjęcia");
        return null;
      }

      imageTemporary = await image.readAsBytes();
      //categorizeThePhoto(context, imageTemporary);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
  if (forClassification) {
    categorizeThePhoto(context, imageTemporary);
  }
  return imageTemporary;
}

//----------------------------------------------------
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
