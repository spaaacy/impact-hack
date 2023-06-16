class BusinessDetails {
  final String businessId;
  final String name;
  final int reviewCount;
  final double rating;
  final Map reviewsPerRating;
  final Map aboutDetails;

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
    return   """The information given below is a restaurant's details and it's details:

Business Name: "$name"

Overall Rating: $rating/5

Total Reviews: $reviewCount

$aboutDetails

There are multiple reviews. Based on these reviews, you should provide professional feedback. 

""";
  }

}
