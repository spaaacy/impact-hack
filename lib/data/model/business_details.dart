class BusinessDetails {
  final String businessId;
  final String name;
  final String phoneNumber;
  final String fullAddress;
  final int reviewCount;
  final double rating;
  final Map reviewsPerRating;
  final Map aboutDetails;

  BusinessDetails({
    this.businessId = "",
    this.name = "",
    this.phoneNumber = "",
    this.fullAddress = "",
    this.reviewCount = 0,
    this.rating = 0,
    this.reviewsPerRating = const {},
    this.aboutDetails = const {},
  });
}
