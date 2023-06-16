String trimDescription(String description) {
  return description.split(", ").take(3).join(', ');
}

extension StringExtension on String {
  String capitalize() {
    if (trim().isEmpty) {
      return '';
    }
    return split(' ')
        .map((element) =>
    "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}")
        .join(" ");
  }
}