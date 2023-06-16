import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../data/model/business_details.dart';
import '../data/model/suggestion.dart';
import '../data/model/review.dart';

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
        "https://local-business-data.p.rapidapi.com/business-details?business_id=$businessId&extract_emails_and_contacts=${true}&extract_share_link=${false}&region=ms&language=${lang}";
    final response = await client.get(Uri.parse(request), headers: {
      'X-RapidAPI-Key': 'a368014d7emsh42b952724a1738dp199cbbjsnd23fb0d00942',
      'X-RapidAPI-Host': 'local-business-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result.length < 1) {
        throw Exception("Business not found.");
      }

      if (result['status'] == 'OK') {
        final data = result['data'][0];
        return BusinessDetails(
            businessId: data['business_id'],
            name: data['name'],
            reviewCount: data["review_count"],
            rating: data["rating"],
            aboutDetails: data['about']['details']);
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<List<Review>> fetchBusinessReviews(
      {required String businessId,
      int limit = 20,
      required String lang}) async {
    final request =
        "https://local-business-data.p.rapidapi.com/business-reviews?business_id=$businessId&limit=$limit&region=ms&language=$lang";
    final response = await client.get(Uri.parse(request), headers: {
      'X-RapidAPI-Key': 'a368014d7emsh42b952724a1738dp199cbbjsnd23fb0d00942',
      'X-RapidAPI-Host': 'local-business-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result['status'] == 'OK') {
        return result['data'].map<Review>((review) {
          return Review(
            reviewId: review["review_id"],
            text: review["review_text"],
            rating: review["rating"],
            timestamp: review["timestamp"],
            likeCount: review["like_count"],
            ratingBreakdown: review["hotel_rating_breakdown"],
            reviewForm: review["review_form"],
          );
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
