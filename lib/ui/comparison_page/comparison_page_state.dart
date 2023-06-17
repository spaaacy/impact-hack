import 'package:flutter/cupertino.dart';
import 'package:impact_hack/data/model/business_details.dart';

import '../../data/model/chatgpt_request.dart';
import '../../data/model/chatgpt_response.dart';
import '../../data/model/review.dart';
import '../../services/business_service.dart';
import '../../services/gpt_service.dart';
import '../../util/helpers.dart';

class ComparisonPageState extends ChangeNotifier {
  final BuildContext context;
  final String googleId;
  final OpenAIService openAiService = OpenAIService();

  Future<ChatCompletionResponse?>? analysisGptResponse;
  Future<ChatCompletionResponse?>? comparisonGptResponse;

  final _businessService = BusinessService();

  String previousBusinessAnalysis;
  BusinessDetails previousBusinessDetails;
  List<Review> previousBusinessReviews;

  String? currentBusinessAnalysis;
  BusinessDetails? currentBusinessDetails;
  List<Review>? currentBusinessReviews;

  String? comparisonAnalysis;

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
    String compiledDetails = compileBusinessDetailsAndReviews(businessDetails, businessReviews);

    final messages = [
      ChatMessage(role: 'system', content: compiledDetails),
      ChatMessage(
          role: 'user',
          content:
              "Use the above information to describe the positive aspects, negative aspects, and areas for improvement of the hotel. Keep the reply greater than 300 words."),
    ];

    const temperature = 1.0;

    analysisGptResponse = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {
      currentBusinessAnalysis = response.choices.first.message.content;
      fetchComparisonAnalysis(
          firstBusinessAnalysis: previousBusinessAnalysis, secondBusinessAnalysis: currentBusinessAnalysis!);
    }).catchError((error) {
      currentBusinessAnalysis = 'Failed to fetch description';
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> fetchComparisonAnalysis(
      {required String firstBusinessAnalysis, required String secondBusinessAnalysis}) async {
    String compiledDetails = "Here are details about two hotels:\n\nHotel 1:";
    compiledDetails = "$compiledDetails\n\n$firstBusinessAnalysis\n\nHotel 2:\n\n$secondBusinessAnalysis";

    final messages = [
      ChatMessage(role: 'system', content: compiledDetails),
      ChatMessage(
          role: 'user',
          content:
              "Compare and contrast the positive aspects, negative aspects, and areas for improvement for both hotels. Keep the reply greater than 300 words"),
    ];

    const temperature = 1.0;

    comparisonGptResponse = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {
      comparisonAnalysis = response.choices.first.message.content;
      notifyListeners();
    }).catchError((error) {
      comparisonAnalysis = 'Failed to fetch description';
      notifyListeners();
    });
    notifyListeners();
  }
}
