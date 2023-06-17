import 'package:flutter/cupertino.dart';
import 'package:impact_hack/data/model/business_details.dart';
import 'package:impact_hack/data/model/chatgpt_response.dart';
import 'package:impact_hack/services/business_service.dart';

import '../../data/model/chatgpt_request.dart';
import '../../data/model/review.dart';
import '../../services/gpt_service.dart';

class BusinessDetailPageState extends ChangeNotifier {
  final BuildContext context;
  final _businessService = BusinessService();
  final OpenAIService openAiService;

  Future<ChatCompletionResponse?>? gptResponse;

  String? businessAnalysis;
  BusinessDetails? businessDetails;
  List<Review>? businessReviews;

  BusinessDetailPageState(this.context, this.googleId) : openAiService = OpenAIService() {
    generateAnalysis();
  }

  final searchController = TextEditingController();

  final String googleId;

  Future<void> generateAnalysis() async {
    await _businessService.fetchBusinessDetails(businessId: googleId, lang: 'en').then((details) {
      businessDetails = details;
      _businessService
          .fetchBusinessReviews(businessId: googleId, lang: 'en')
          .then((reviews) {
        businessReviews = reviews;
        fetchBusinessAnalysis(businessDetails: details, businessReviews: reviews);
      });
    });
  }

  Future<void> fetchBusinessAnalysis(
      {required BusinessDetails businessDetails, required List<Review> businessReviews}) async {
    final compiledDetails = "$businessDetails\n\n$businessReviews";

    final messages = [
      ChatMessage(role: 'system', content: compiledDetails),
      ChatMessage(
          role: 'user',
          content:
              'I want to know the positive aspects and areas of improvements. Ignore reviews where owner has responded to the comment and fixed the problem. Also, add a count beside each positive aspect and areas of improvement indicating how many reviews highlight that same topic. An example is "positive aspect 1 (1 review)". Do not add a new section for count.'),
    ];

    const temperature = 1.0;

    gptResponse = openAiService.sendChatCompletionRequest(messages, temperature).then((response) {
      businessAnalysis = response.choices.first.message.content;
      notifyListeners();
    }).catchError((error) {
      businessAnalysis = 'Failed to fetch description';
      notifyListeners();
    });
    notifyListeners();
  }
}
