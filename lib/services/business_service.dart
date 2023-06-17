import 'dart:convert';

import 'package:http/http.dart';
import 'package:impact_hack/util/helpers.dart';

import '../data/model/business_details.dart';
import '../data/model/review.dart';
import '../data/model/suggestion.dart';
import '../util/constants.dart';

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
      'X-RapidAPI-Key': rapidApiKey,
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
        "https://local-business-data.p.rapidapi.com/business-details?business_id=$businessId&extract_emails_and_contacts=${true}&extract_share_link=${false}&region=ms&language=${lang}";
    final response = await client.get(Uri.parse(request), headers: {
      'X-RapidAPI-Key': rapidApiKey,
      'X-RapidAPI-Host': 'local-business-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result.length < 1) {
        throw Exception("Business not found.");
      }

      if (result['status'] == 'OK') {
        final data = result['data'][0];
        final details = BusinessDetails(
            businessId: data['business_id'],
            name: data['name'],
            reviewCount: data["review_count"],
            rating: data["rating"],
            aboutDetails: data['about']['details']);
        return details;
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<List<Review>> fetchBusinessReviews(
      {required String businessId,
      int limit = 20,
      required String lang,
      bool newest = false}) async {
    final request = newest
        ? "https://local-business-data.p.rapidapi.com/business-reviews?business_id=$businessId&limit=$limit&region=ms&language=$lang&sort_by=newest"
        : "https://local-business-data.p.rapidapi.com/business-reviews?business_id=$businessId&limit=$limit&region=ms&language=$lang";
    final response = await client.get(Uri.parse(request), headers: {
      'X-RapidAPI-Key': rapidApiKey,
      'X-RapidAPI-Host': 'local-business-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      final result = json.decode(utf8.decode(response.bodyBytes));

      if (result['status'] == 'OK') {
        final reviews = result['data'].map<Review>((review) {
          return Review(
            reviewId: review["review_id"],
            text: review["review_text"],
            rating: review["rating"],
            timestamp: review["review_timestamp"],
            ratingBreakdown: review["hotel_rating_breakdown"],
            reviewForm: review["review_form"],
          );
        }).toList();

        return reviews;
      }

      if (result['data'].length < 1) {
        return [];
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<List<BusinessDetails>> fetchNearbyBusinesses({
    required String input,
    int limit = 20,
    required String lang,
  }) async {
    final request =
        "https://local-business-data.p.rapidapi.com/search?query=$input&limit=$limit&language=$lang&region=ms";
    final response = await client.get(Uri.parse(request), headers: {
      'X-RapidAPI-Key': rapidApiKey,
      'X-RapidAPI-Host': 'local-business-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final details = result['data'].map<BusinessDetails>((data) {
          return BusinessDetails(
              businessId: data['business_id'],
              name: data['name'],
              reviewCount: data["review_count"],
              rating: data["rating"],
              aboutDetails: data['about'] == null ? null : data['about']['details']);
        }).toList();

        return details;
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
