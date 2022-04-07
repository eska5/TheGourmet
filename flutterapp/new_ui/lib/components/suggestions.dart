import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui/components/button.dart';

class Suggestions {
  String suggest = "";

  Suggestions({
    required this.suggest,
  });

  static Suggestions fromJson(String json) => Suggestions(
        suggest: json,
      );
}

class SuggestionsApi {
  static Future<List<Suggestions>> getSuggestionsSuggestions(
      String query) async {
    final url = Uri.parse('https://gourmet.hopto.org:5000/suggestions');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List suggestions = json.decode(response.body);

      return suggestions
          .map((json) => Suggestions.fromJson(json))
          .where((suggestion) {
        final suggestionLower = suggestion.suggest.toString().toLowerCase();
        final queryLower = query.toString().toLowerCase();

        return suggestionLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
