class ChatCompletionRequest {
  final String model;
  final List<ChatMessage> messages;
  final double temperature;

  ChatCompletionRequest({
    required this.model,
    required this.messages,
    required this.temperature,
  });

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'messages': messages.map((message) => message.toJson()).toList(),
      'temperature': temperature,
    };
  }
}

class ChatMessage {
  final String role;
  final String content;

  ChatMessage({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
