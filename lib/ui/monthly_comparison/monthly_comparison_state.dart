import 'package:flutter/cupertino.dart';
import 'package:impact_hack/data/model/business_details.dart';
import 'package:impact_hack/util/helpers.dart';

import '../../data/model/chatgpt_request.dart';
import '../../data/model/chatgpt_response.dart';
import '../../data/model/review.dart';
import '../../services/business_service.dart';
import '../../services/gpt_service.dart';

class MonthlyComparisonState extends ChangeNotifier {
  final BuildContext context;
  final _businessService = BusinessService();
  final OpenAIService openAiService;

  Future<ChatCompletionResponse?>? gptResponseLastMonth;
  Future<ChatCompletionResponse?>? gptResponseThisMonth;
  Future<ChatCompletionResponse?>? comparisonGptResponse;

  bool firstLoaded = false;
  bool comparisonLoaded = false;

  String lastMonthString = getMonthString(DateTime.now().month-2);
  String thisMonthString = getMonthString(DateTime.now().month-1);

  String? businessAnalysisThisMonth;
  String? businessAnalysisLastMonth;
  String? comparisonAnalysis;

  BusinessDetails? businessDetails;

  List<Review>? businessReviewsThisMonth;
  List<Review>? businessReviewsLastMonth;

  MonthlyComparisonState(this.context, this.googleId) : openAiService = OpenAIService() {
    generateAnalysis();
  }

  final String googleId;

  Future<void> generateAnalysis() async {
    await _businessService.fetchBusinessDetails(businessId: googleId, lang: 'en').then((details) {
      businessDetails = details;
      _businessService
          .fetchBusinessReviews(businessId: googleId, lang: 'en', limit: 100, newest: true)
          .then((reviews) {
        final date = DateTime.now();
        businessReviewsThisMonth = selectReviewByMonth(reviews, DateTime(date.year, date.month - 1), DateTime(date.year, date.month));
        businessReviewsLastMonth = selectReviewByMonth(reviews, DateTime(date.year, date.month - 2), DateTime(date.year, date.month-1));
        fetchBusinessAnalysis(businessDetails: details, businessReviews: businessReviewsThisMonth!, thisMonth: true);
        fetchBusinessAnalysis(businessDetails: details, businessReviews: businessReviewsLastMonth!, thisMonth: false);
      });
    });
  }

  Future<void> fetchComparisonAnalysis() async {
    String compiledDetails = "$lastMonthString:\n\n$businessAnalysisLastMonth";
    compiledDetails = "$compiledDetails\n\n$thisMonthString\n\n$businessAnalysisThisMonth";

    final messages = [
      ChatMessage(role: 'system', content: compiledDetails),
      ChatMessage(
          role: 'user',
          content:
          "Identify and discuss factors that have improved and factors that factors that worsened between the two months. Keep the reply greater than 300 words."),
    ];

    const temperature = 1.0;

    comparisonGptResponse = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {
      comparisonAnalysis = response.choices.first.message.content;
      comparisonLoaded = true;
      notifyListeners();
    }).catchError((error) {
      comparisonAnalysis = 'Failed to fetch description';
      comparisonLoaded = true;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> fetchBusinessAnalysis(
      {required BusinessDetails businessDetails, required List<Review> businessReviews, required bool thisMonth}) async {
    String compiledDetails = compileBusinessDetailsAndReviews(businessDetails, businessReviews);

    List<ChatMessage> messages = <ChatMessage>[];

    if (thisMonth) {
      messages = [
        ChatMessage(role: 'system', content: compiledDetails),
        ChatMessage(
            role: 'user',
            content:
            "These are the reviews from $thisMonthString, use the above information to describe the positive aspects, negative aspects, and areas for improvement of the hotel. Keep the reply greater than 300 words."),
      ];
    } else {
      messages = [
        ChatMessage(role: 'system', content: compiledDetails),
        ChatMessage(
            role: 'user',
            content:
            "These are the reviews from $lastMonthString, use the above information to describe the positive aspects, negative aspects, and areas for improvement of the hotel. Keep the reply greater than 300 words."),
      ];
    }



    const temperature = 1.0;

    if (thisMonth) {
      gptResponseThisMonth = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {
        businessAnalysisThisMonth = response.choices.first.message.content;
        if (firstLoaded) {
          fetchComparisonAnalysis();
        } else {
          firstLoaded = true;
        }
      }).catchError((error) {
        businessAnalysisThisMonth = 'Failed to fetch description';
        comparisonLoaded = true;
        notifyListeners();
      });
      notifyListeners();
    } else {
      gptResponseLastMonth = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {

        businessAnalysisLastMonth = response.choices.first.message.content;
        if (firstLoaded) {
          fetchComparisonAnalysis();
        } else {
          firstLoaded = true;
        }
      }).catchError((error) {
        businessAnalysisLastMonth = 'Failed to fetch description';
        comparisonLoaded = true;
        notifyListeners();
      });
      notifyListeners();
    }



  }
}
