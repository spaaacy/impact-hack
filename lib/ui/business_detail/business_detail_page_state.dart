import 'dart:ui';

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

  BusinessDetailPageState(this.context, this.googleId)
      : openAiService = OpenAIService() {
    //temp();
    print(googleId);
    generateAnalysis();
  }

  final searchController = TextEditingController();

  final String googleId;

  Future<void> generateAnalysis() async {
    await _businessService
        .fetchBusinessDetails(businessId: googleId, lang: 'en')
        .then((details) {
      businessDetails = details;
      _businessService
          .fetchBusinessReviews(businessId: googleId, lang: 'en')
          .then((reviews) {
        businessReviews = reviews;
        fetchBusinessAnalysis(
            businessDetails: details, businessReviews: reviews);
      });
    });
  }

  Future<void> temp() async {
    await justAI();

    String business2 =
        """Based on the reviews without any owner responses, Al-Amar Express seems to be a popular restaurant in the Bukit Bintang area, with a variety of authentic and tasty Lebanese food options. Customers have generally enjoyed the food, atmosphere, and service, with several positive comments on the shawarma, hummus, and pizza. 

Positive aspects:
- Tasty and authentic Lebanese food
- Good service and friendly staff
- Cozy and pleasant atmosphere
- Convenient location in the bustling Bukit Bintang area
- Good variety of options for different diets

Areas of improvement:
- Inconsistent quality of food, with some dishes being overpriced, dry, bland, or cold
- Limited vegetarian options
- Challenging parking situation
- Inadequate portion sizes and high prices for some items
- Some customers experienced difficulty finding seating during busy times

Suggestions for improvement:
- Ensure consistent quality of food and reasonable pricing
- Improve vegetarian options and portion sizes for some items
- Offer more parking options or guidance to customers
- Consider expanding seating capacity during busy times
- Offer more promotions or discounts to make prices more attractive

Overall, Al-Amar Express appears to be a well-liked restaurant with potential for improvement in certain areas. Addressing these issues could help attract more customers and maintain positive reviews.""";

    //await justAI(business1);
  }

  Future<void> fetchBusinessAnalysis(
      {required BusinessDetails businessDetails,
      required List<Review> businessReviews}) async {
    final compiledDetails = "$businessDetails\n\n$businessReviews";

    final messages = [
      ChatMessage(role: 'system', content: compiledDetails),
      ChatMessage(
          role: 'user',
          content:
              'I want to know the positive aspects and areas of improvements. Ignore reviews where owner has responded to the comment and fixed the problem. Also, add a count beside each positive aspect and areas of improvement indicating how many reviews highlight that same topic. An example is "positive aspect 1 (1 review)". Do not add a new section for count.'),
    ];

    const temperature = 1.0;

    gptResponse = openAiService
        .sendChatCompletionRequest(messages, temperature)
        .then((response) {
      businessAnalysis = response.choices.first.message.content;
      notifyListeners();
    }).catchError((error) {
      businessAnalysis = 'Failed to fetch description';
      notifyListeners();
    });
    notifyListeners();
  }
}
