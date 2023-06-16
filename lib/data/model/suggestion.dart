class Suggestion {
  final String googleId;
  final String description;

  Suggestion({this.googleId = "", this.description = ""});

  @override
  String toString() {
    return 'Suggestion(description: $description, googleId: $googleId)';
  }
}
