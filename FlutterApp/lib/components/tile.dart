class Tile {
  String mealName;
  String mealDescription;
  double mealProbability;
  dynamic color;
  dynamic gradient1;
  dynamic gradient2;
  int numberOfStars;
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
