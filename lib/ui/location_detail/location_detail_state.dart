import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:impact_hack/data/model/business_details.dart';
import 'package:impact_hack/data/model/chatgpt_response.dart';
import 'package:impact_hack/services/business_service.dart';

import '../../data/model/chatgpt_request.dart';
import '../../services/gpt_service.dart';
import '../../util/helpers.dart';

class LocationDetailState extends ChangeNotifier {
  final BuildContext context;
  final _businessService = BusinessService();
  final OpenAIService openAiService;

  Future<ChatCompletionResponse?>? gptResponse;

  late String locationName;
  String? locationAnalysis;
  List<BusinessDetails>? businessesNearby;
  String businessesNearbyNames = '';


  LocationDetailState(this.context, this.input) : openAiService = OpenAIService() {
    locationName = input.capitalize();
    searchController.addListener(() => notifyListeners());
    generateAnalysis();
  }

  final searchController = TextEditingController();

  String gptSystemContent = 'Here are some hotels in a similar area:';

  final String input;

  Future<void> generateAnalysis() async {
    businessesNearby = await _businessService.fetchNearbyBusinesses(input: "hotel $input", lang: 'en', limit: 4);

    for (var business in businessesNearby!) {

      if (businessesNearbyNames.isEmpty) {
        businessesNearbyNames = '${business.name}';
      } else {
        businessesNearbyNames = '$businessesNearbyNames, ${business.name}';
      }

      final businessReviews =
          await _businessService.fetchBusinessReviews(businessId: business.businessId!, lang: 'en', limit: 5);
      String compiledDetails = compileBusinessDetailsAndReviews(business, businessReviews);
      gptSystemContent = '$gptSystemContent\n\n$compiledDetails';
      await Future.delayed(const Duration(milliseconds: 500));
    }

    fetchBusinessAnalysis();
  }

  Future<void> fetchBusinessAnalysis() async {
    final messages = [
      ChatMessage(role: 'system', content: gptSystemContent),
      ChatMessage(
          role: 'user',
          content:
              'Compile and use the above information to describe the positive aspects, negative aspects, and areas for improvement for hotels in the $locationName area, without naming specific hotels. Keep the reply within 500 words.'),
    ];

    const temperature = 1.0;

    gptResponse = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {
      locationAnalysis = response.choices.first.message.content;
      notifyListeners();
    }).catchError((error) {
      locationAnalysis = 'Failed to fetch description';
      notifyListeners();
    });
    notifyListeners();
  }
}
