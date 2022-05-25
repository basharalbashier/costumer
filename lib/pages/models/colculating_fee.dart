String colculatingFedd(
    String priceForFirst12, String priceAfter, double distance) {
  if (distance <= 12) {
    return (distance * double.parse(priceForFirst12)).toStringAsFixed(2);
  }
  double remaining = distance - 12;
  double restPrice = remaining * double.parse(priceAfter);
  double finalPrice = (double.parse(priceForFirst12) * 12) + restPrice;

  return finalPrice.toStringAsFixed(2);
}
