import 'package:flutter/cupertino.dart';

import '../../model/chatgpt_request.dart';
import '../../services/gpt_service.dart';

class BusinessDetailState extends ChangeNotifier {
  final BuildContext context;
  final OpenAIService openAiService;
  String description = 'Loading...';

  BusinessDetailState(this.context) : openAiService = OpenAIService();

  Future<String> fetchBusinessDescription() {
    final messages = [
      ChatMessage(role: 'user', content: 'Tell me 10 random colors'),
    ];

    const temperature = 1.0;

    return openAiService
        .sendChatCompletionRequest(messages, temperature)
        .then((response) {
      final completionMessage = response.choices.first.message.content;
      return completionMessage;
    }).catchError((error) {
      return 'Failed to fetch description';
    });
  }
}
