class BusinessDetails {
  final String? businessId;
  final String? name;
  final int? reviewCount;
  final double? rating;
  final Map? reviewsPerRating;
  final Map? aboutDetails;

  // TODO: Add price
  // TODO: Add type

  BusinessDetails({
    this.businessId = "",
    this.name = "",
    this.reviewCount = 0,
    this.rating = 0,
    this.reviewsPerRating = const {},
    this.aboutDetails = const {},
  });

  // TODO: Enumerate reviews

  // TODO: Enumerate about details
  @override
  String toString() {
    String output = "The information given below is a restaurant's details and it's details:\n\n"
        "Business Name: $name\n"
        "Overall Rating: $rating/5\n"
        "Total Reviews: $reviewCount\n";

    if (aboutDetails != null) {
      aboutDetails!.forEach((key, value) {
        output = '$output\n$key: $value';
      });
    }

    output = "$output\n\nThere are multiple reviews. Based on these reviews, you should provide professional feedback.";

    return output;
  }

}
