import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui/components/button.dart';
import 'package:new_ui/components/suggestions.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddImage extends StatefulWidget {
  AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? image;
  TextEditingController inputText = new TextEditingController();
  TextEditingController recognizedMeal = new TextEditingController();

  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 10);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future sendToServer() async {
    try {
      final uri = Uri.parse("https://gourmet.hopto.org:5000/meals");
      final headers = {'Content-Type': 'application/json'};
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = base64Encode(bytes);
      Map<String, dynamic> body = {
        'mealName': inputText.text.toString(),
        'mealPhoto': base64Image
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      int statusCode = response.statusCode;
      String responseBody = response.body;
      print(responseBody);
      print(statusCode);
      print("OK");
    } on PlatformException catch (e) {
      print('Failed to send to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo[50],
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.file(
                    image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset('assets/dish.png', width: 200, height: 200),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TypeAheadField<Suggestions?>(
              hideSuggestionsOnKeyboardHide: true,
              debounceDuration: Duration(milliseconds: 500),
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  hintText: 'Podaj nazwę potrawy',
                ),
                controller: this.inputText,
              ),
              suggestionsCallback: SuggestionsApi.getSuggestionsSuggestions,
              itemBuilder: (context, Suggestions? suggestion) {
                final hint = suggestion;
                return ListTile(
                  title: Text(hint!.suggest.toString()),
                );
              },
              noItemsFoundBuilder: (context) => Container(
                height: 40,
                child: Center(
                  child: Text(
                    'Brak potraw w bazie',
                  ),
                ),
              ),
              onSuggestionSelected: (Suggestions? suggestion) {
                final potrawa = suggestion!;
                inputText.text = potrawa.suggest;
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('Podano potrawe: ${potrawa.suggest}'),
                  ));
                child:
                TextField(
                  controller: inputText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'podaj nazwe potrawy',
                  ),
                );
              },
            ),
          ),
          Expanded(child: Container()),
          UploadImageButton(
              title: "Wybierz zdjęcie",
              icon: Icons.image_rounded,
              onClicked: () => pickImage(ImageSource.gallery)),
          SizedBox(
            height: 15,
          ),
          TakeImageButton(
              title: "Zrób zdjęcie",
              icon: Icons.camera_alt_rounded,
              onClicked: () => pickImage(ImageSource.camera)),
          SizedBox(
            height: 15,
          ),
          SubmitImageButton(
              title: "Wyślij potrawę",
              icon: Icons.send_rounded,
              onClicked: () => pickImage(ImageSource.camera)),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
