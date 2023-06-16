import 'dart:convert';

import 'package:http/http.dart';

import '../data/model/suggestion.dart';

class BusinessService {
  final client = Client();

  Future<List<Suggestion>> fetchSuggestions(
      {required String input, required String lang}) async {
    if (input.isEmpty) {
      return [];
    }

    final request =
        "https://local-business-data.p.rapidapi.com/autocomplete?query=$input&region=ms&language=$lang";
    final response = await client.get(Uri.parse(request), headers: {
      'X-RapidAPI-Key': 'a368014d7emsh42b952724a1738dp199cbbjsnd23fb0d00942',
      'X-RapidAPI-Host': 'local-business-data.p.rapidapi.com'
    });
    //print("before reponse body");
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      //print("before reponse body");
      if (result['status'] == 'OK') {
        return result['data'].map<Suggestion>((prediction) {
          return Suggestion(
              googleId: prediction['google_id'],
              description: prediction['description']);
        }).toList();
      }

      if (result['data'].length < 1) {
        return [];
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
