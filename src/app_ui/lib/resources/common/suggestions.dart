import 'dart:convert';

import 'package:http/http.dart' as http;

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
    final url = Uri.parse('https://gourmetapp.net/api/v1/suggestions');
    final response =
        await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});

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
