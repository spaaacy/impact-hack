import 'package:flutter/cupertino.dart';
import 'package:impact_hack/util/constants.dart';

import '../../model/chatgpt_request.dart';
import '../../services/gpt_service.dart';

class BusinessDetailState extends ChangeNotifier {
  final BuildContext context;
  final OpenAIService openAiService;
  String description = 'Loading...';

  BusinessDetailState(this.context, this.googleId) : openAiService = OpenAIService();

  final String googleId;

  Future<String> fetchBusinessDescription() async {
    // final messages = [
    //   ChatMessage(role: 'user', content: 'Tell me 10 random colors'),
    // ];
    //
    // const temperature = 1.0;
    //
    // return openAiService
    //     .sendChatCompletionRequest(messages, temperature)
    //     .then((response) {
    //   final completionMessage = response.choices.first.message.content;
    //   return completionMessage;
    // }).catchError((error) {
    //   return 'Failed to fetch description';
    // });

    return loremImpsum;

  }
}
