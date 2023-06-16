class Review {
  final String reviewId;
  final String text;
  final double rating;
  final int timestamp;
  final int likeCount;
  final Map ratingBreakdown;
  final Map reviewForm;

  Review({
    this.reviewId = "",
    this.text = "",
    this.rating = 0,
    this.timestamp = 0,
    this.likeCount = 0,
    this.ratingBreakdown = const {},
    this.reviewForm = const {},
  });
}
