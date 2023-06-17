import 'package:flutter/cupertino.dart';
import 'package:impact_hack/data/model/business_details.dart';

import '../../data/model/chatgpt_request.dart';
import '../../data/model/chatgpt_response.dart';
import '../../data/model/review.dart';
import '../../services/business_service.dart';
import '../../services/gpt_service.dart';

class ComparisonPageState extends ChangeNotifier {
  final BuildContext context;
  final String googleId;
  final OpenAIService openAiService = OpenAIService();

  Future<ChatCompletionResponse?>? gptResponse;

  final _businessService = BusinessService();

  String previousBusinessAnalysis;
  BusinessDetails previousBusinessDetails;
  List<Review> previousBusinessReviews;

  String? currentBusinessAnalysis;
  BusinessDetails? currentBusinessDetails;
  List<Review>? currentBusinessReviews;

  ComparisonPageState(this.context, this.googleId, this.previousBusinessAnalysis, this.previousBusinessDetails,
      this.previousBusinessReviews) {
    generateAnalysis();
  }

  Future<void> generateAnalysis() async {
    await _businessService.fetchBusinessDetails(businessId: googleId, lang: 'en').then((details) {
      currentBusinessDetails = details;
      _businessService.fetchBusinessReviews(businessId: googleId, lang: 'en').then((reviews) {
        previousBusinessReviews = reviews;
        fetchBusinessAnalysis(businessDetails: details, businessReviews: reviews);
      });
    });
  }

  Future<void> fetchBusinessAnalysis(
      {required BusinessDetails businessDetails, required List<Review> businessReviews}) async {
    final compiledDetails = """
        $businessDetails

        $businessReviews
      """;

    final messages = [
      ChatMessage(role: 'system', content: compiledDetails),
      ChatMessage(
          role: 'user',
          content:
              "Use the above information to describe the positive aspects, negative aspects, and areas for improvement of the hotel. Keep the reply greater than 300 words."),
    ];

    const temperature = 1.0;

    gptResponse = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {
      currentBusinessAnalysis = response.choices.first.message.content;
      notifyListeners();
    }).catchError((error) {
      currentBusinessAnalysis = 'Failed to fetch description';
      notifyListeners();
    });
    notifyListeners();
  }
}
