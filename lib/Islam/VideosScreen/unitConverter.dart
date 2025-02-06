String formatNumber(String number) {
  if (int.parse(number) >= 1000000000) {
    return '${(int.parse(number) / 1000000000).toStringAsFixed(1)}B'; // For Billion
  } else if (int.parse(number) >= 1000000) {
    return '${(int.parse(number) / 1000000).toStringAsFixed(1)}M'; // For Million
  } else if (int.parse(number) >= 1000) {
    return '${(int.parse(number) / 1000).toStringAsFixed(1)}K'; // For Thousand
  } else {
    return number.toString(); // If number is less than 1000
  }
}
