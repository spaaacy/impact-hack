import 'dart:convert';

import 'package:http/http.dart';
import 'package:impact_hack/util/constants.dart';
import 'package:latlong2/latlong.dart';

import '../data/model/suggestion.dart';

class BusinessService {
  final client = Client();

  Future<List<Suggestion>> fetchSuggestions(
      {required String input, LatLng? currentLocation, required String lang, required String sessionToken}) async {
    if (input.isEmpty) {
      return [];
    }

    currentLocation ??= defaultLatLng;

    final request =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&location=${currentLocation.latitude}%2C${currentLocation.longitude}&types=establishment&language=$lang&components=country:my&key=$mapsApiKey&sessiontoken=$sessionToken";
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result['status'] == 'OK') {
        return result['predictions'].map<Suggestion>((prediction) {
          return Suggestion(placeId: prediction['place_id'], description: prediction['description']);
        }).toList();
      }

      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }


}