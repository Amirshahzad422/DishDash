class Formatters {
  static String currency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static String rating(double score) {
    return score.toStringAsFixed(1);
  }

  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
