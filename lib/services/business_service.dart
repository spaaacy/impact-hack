import 'dart:convert';

import 'package:http/http.dart';

import '../data/model/business_details.dart';
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

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

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

  Future<BusinessDetails> fetchBusinessDetails(
      {required String businessId, required String lang}) async {
    final request =
        "https://local-business-data.p.rapidapi.com/business-details?business_id$businessId&extract_emails_and_contacts=${true}&extract_share_link=${false}&region=ms&language=${lang}";
    final response = await client.get(Uri.parse(request), headers: {
      'X-RapidAPI-Key': 'a368014d7emsh42b952724a1738dp199cbbjsnd23fb0d00942',
      'X-RapidAPI-Host': 'local-business-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result.data.length < 1) {
        throw Exception("Business not found.");
      }

      if (result['status'] == 'OK') {
        final data = result['data'][0];
        return BusinessDetails(
            businessId: data['business_id'],
            name: data['name'],
            phoneNumber: data['phone_number'],
            fullAddress: data['full_address'],
            reviewCount: data["review_count"],
            rating: data["rating"],
            aboutDetails: data['about']['details']);
      }

      throw Exception("Business not found.");
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
