String trimDescription(String description) {
  return description.split(", ").take(3).join(', ');
}