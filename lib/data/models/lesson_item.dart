class LessonItem {
  const LessonItem({
    required this.id,
    required this.levelId,
    required this.order,
    required this.title,
    required this.shortExplanation,
    required this.detailedExplanation,
    required this.example,
    required this.keyTakeaways,
    required this.miniActivity,
    required this.techIconAsset,
    required this.techLabel,
  });

  final String id;
  final String levelId;
  final int order;
  final String title;
  final String shortExplanation;
  final String detailedExplanation;
  final String example;
  final List<String> keyTakeaways;
  final String miniActivity;
  final String techIconAsset;
  final String techLabel;
}
