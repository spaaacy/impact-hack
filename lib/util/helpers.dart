import 'package:intl/intl.dart';

import '../data/model/review.dart';

String trimDescription(String description) {
  return description.split(", ").take(3).join(', ');
}

extension StringExtension on String {
  String capitalize() {
    if (trim().isEmpty) {
      return '';
    }
    return split(' ').map((element) => "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}").join(" ");
  }
}

List<Review> selectReviewByMonth(List<Review> reviews, DateTime startDateTime, DateTime endDateTime) {
  final startTimestamp = startDateTime.millisecondsSinceEpoch / 1000;
  final endTimestamp = endDateTime.millisecondsSinceEpoch / 1000;
  final reviewsOfMonth = <Review>[];
  for (var review in reviews) {
    if (review.timestamp != null && review.timestamp! < endTimestamp && review.timestamp! > startTimestamp) {
      reviewsOfMonth.add(review);
    }
  }
  return reviewsOfMonth;
}

String getMonthString(int month) {
  return DateFormat('MMMM').format(DateTime(0, month));
}
