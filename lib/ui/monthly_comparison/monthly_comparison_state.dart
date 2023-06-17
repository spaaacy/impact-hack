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

  bool firstLoaded = false;
  bool secondLoaded = false;

  String lastMonthString = getMonthString(DateTime.now().month-2);
  String thisMonthString = getMonthString(DateTime.now().month-1);

  String? businessAnalysisThisMonth;
  String? businessAnalysisLastMonth;

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

  Future<void> fetchBusinessAnalysis(
      {required BusinessDetails businessDetails, required List<Review> businessReviews, required bool thisMonth}) async {
    final compiledDetails = "$businessDetails\n\n$businessReviews";

    List<ChatMessage> messages = <ChatMessage>[];

    if (thisMonth) {
      messages = [
        ChatMessage(role: 'system', content: compiledDetails),
        ChatMessage(
            role: 'user',
            content:
            "These are the reviews from $thisMonthString, can you analyze and summarise how the hotel is doing? I want to know  a summary of the positive aspects,  areas of improvements, and suggestion to improve Only analyze the reviews that has 'owner response text(owner response): None' otherwise ignore the review. "),
      ];
    } else {
      messages = [
        ChatMessage(role: 'system', content: compiledDetails),
        ChatMessage(
            role: 'user',
            content:
            "These are the reviews from $lastMonthString, can you analyze and summarise how the hotel is doing? I want to know  a summary of the positive aspects,  areas of improvements, and suggestion to improve Only analyze the reviews that has 'owner response text(owner response): None' otherwise ignore the review. "),
      ];
    }



    const temperature = 1.0;

    if (thisMonth) {
      gptResponseThisMonth = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {

        businessAnalysisThisMonth = response.choices.first.message.content;
        if (firstLoaded) {
          secondLoaded = true;
        } else {
          firstLoaded = true;
        }
        notifyListeners();

      }).catchError((error) {
        businessAnalysisThisMonth = 'Failed to fetch description';
        notifyListeners();
      });
      notifyListeners();
    } else {
      gptResponseLastMonth = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {

        businessAnalysisLastMonth = response.choices.first.message.content;
        if (firstLoaded) {
          secondLoaded = true;
        } else {
          firstLoaded = true;
        }
        notifyListeners();

      }).catchError((error) {
        businessAnalysisLastMonth = 'Failed to fetch description';
        notifyListeners();
      });
      notifyListeners();


    }


  }
}
