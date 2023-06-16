class Review {
  final String? reviewId;
  final String? text;
  final double? rating;
  final int? timestamp;
  final Map? ratingBreakdown;
  final Map? reviewForm;

  Review({
    this.reviewId = "",
    this.text = "",
    this.rating = 0,
    this.timestamp = 0,
    this.ratingBreakdown = const {},
    this.reviewForm = const {},
  });

  @override
  String toString() {
    String output = "Review:\n"
        "-Rating: $rating\n"
        "-Description: $text";

    if (ratingBreakdown != null) {
      ratingBreakdown!.forEach((key, value) {
        output = '$output\n$key: $value';
      });
    }

    if (reviewForm != null) {
      reviewForm!.forEach((key, value) {
        output = '$output\n$key: $value';
      });
    }

    return output;
  }
}
