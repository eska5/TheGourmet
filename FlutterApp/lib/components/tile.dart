class Tile {
  final String mealName;
  final String mealDescription;
  final double mealProbability;
  final dynamic color;
  final dynamic gradient1;
  final dynamic gradient2;
  final int numberOfStars;
  bool isExpanded;

  Tile({
  required this.mealName,
  required this.mealDescription,
  required this.mealProbability,
  required this.color,
  required this.gradient1,
  required this.gradient2,
  required this.numberOfStars,
  this.isExpanded = true,
});

}