import 'package:flutter/cupertino.dart';
import 'package:impact_hack/util/constants.dart';

import '../../model/chatgpt_request.dart';
import '../../services/gpt_service.dart';

class BusinessDetailState extends ChangeNotifier {
  final BuildContext context;
  final OpenAIService openAiService;
  String? businessAnalysis;

  String description = 'Loading...';

  BusinessDetailState(this.context, this.googleId)
      : openAiService = OpenAIService();

  final searchController = TextEditingController();

  final String googleId;

  final String systemContext =
      """The information given below is a restaurant's details and it's details:

Business Name: "Suki-Ya @ Pavilion KL"

Price Range: ?
Overall Rating: 4.3/5
Restaurant Type: Shabu Shabu Restaurant

Total Reviews: 3

Reviews:

Review 1:
-rating: 5
-text review: "You have to choose 2 type of soups. They have variety of choices, no actual seafood and no grill. The taste is good.
Price-wise: weekend/weekday/lunch/dinner all are different price. To me it’s a bit pricey (if you’re not the type who eat a lot)
Queue for about 15 mins only, I guess I was lucky as the staff told me that we have to queue for 1 hour."
-like count: 4
-recommended dishes:none
-hotel_rating_breakdown
 -food: none
 -service: none
 -atmosphere: none
-review form
   how much did you spend per person: RM20-40
   owner response text(owner response): Hi, Thank you very much for your visit. Hope to see you again.

Review 2:
-rating: 4
-text review: "If you love steamboat... you should give a try here... varieties of fresh food and of course the soup is very tip top and delicious... anyway, there will be a long queue during lunch and dinner time.. better come early... affordable price.. worth waiting to get in.. just bring your friends and family to dine in here.. you won't regret... Happy dining"

-like count: 4
-recommended dishes:none
-hotel_rating_breakdown
 -food: none
 -service: none
 -atmosphere: none
-review form
   how much did you spend per person: none
   owner response text(owner response): Thank you very much for your visit. We hope to see you soon.

Review 3:
-rating: 4
-text review: "The were 4 kinds of soup bases to choose from. The waiter was very attentive to my partner only. Lots of different dipping sauces to choose from. The meat was thin but filling. Small range of seafoods. A range of sushi dishes available. Fruits and ice cream for dessert."

-like count: none
-recommended dishes:Sushi Deluxe, Shabu-Shabu, Sukiyaki Soup, Matcha Ice Cream, Mix Mushrooms
-hotel_rating_breakdown
 -food: none
 -service: none
 -atmosphere: none
-review form
   how much did you spend per person: RM20-40
   owner response text(owner response): None

Review 4:
-rating: 5
-text review: "The soups was good. Meat and the buffet line was be refill fast. Like them a lot. But the free orange juice was bad. It was too plain. Good place for hotpot one in kuala lumpur l."

-like count: 1
-recommended dishes:none
-hotel_rating_breakdown
 -food: 5/5
 -service: 5/5
 -atmosphere: 4/5
-review form
   how much did you spend per person: RM40-60
   owner response text(owner response): None

there are multiple reviews. Based on these reviews, you should provide professional feedback. 
""";

  Future<String> fetchBusinessDescription() async {
    final messages = [
      ChatMessage(role: 'system', content: systemContext),
      ChatMessage(
          role: 'user',
          content:
              "can you analysize and summarise how the restaurant is doing? I want to know  a summary of the positive aspects,  areas of improvements, and suggestion to improve Only analyze the reviews that has 'owner response text(owner response): None' otherwise ignore the review. "),
    ];

    const temperature = 1.0;

    return openAiService
        .sendChatCompletionRequest(messages, temperature)
        .then((response) {
      businessAnalysis = response.choices.first.message.content;
      return businessAnalysis!;
    }).catchError((error) {
      return 'Failed to fetch description';
    });
  }
}
