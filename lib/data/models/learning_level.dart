import 'package:jay2xcoder/data/models/lesson_item.dart';

class LearningLevel {
  const LearningLevel({
    required this.id,
    required this.order,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.iconAsset,
    required this.lessons,
  });

  final String id;
  final int order;
  final String title;
  final String subtitle;
  final String description;
  final String iconAsset;
  final List<LessonItem> lessons;
}
