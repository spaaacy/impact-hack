import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/model/chatgpt_request.dart';
import '../data/model/chatgpt_response.dart';

class OpenAIService {
  static const String apiEndpoint =
      'https://api.openai.com/v1/chat/completions';
  static const String apiKey =
      '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';

  Future<ChatCompletionResponse> sendChatCompletionRequest(
      List<ChatMessage> messages, double temperature) async {
    final request = ChatCompletionRequest(
      model: 'gpt-3.5-turbo',
      messages: messages,
      temperature: temperature,
    );

    final requestBody = jsonEncode(request.toJson());

    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ChatCompletionResponse.fromJson(jsonResponse);
    } else {
      throw Exception(
          'Failed to send chat completion request. Status code: ${response.statusCode}');
    }
  }
}
