import 'package:jay2xcoder/data/models/localized_text.dart';

enum QuizQuestionType {
  multipleChoice,
  trueFalse,
  predictOutput,
  identification,
  codeMeaning,
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.codeLine,
  });

  final String id;
  final QuizQuestionType type;
  final LocalizedText question;
  final List<LocalizedText> options;
  final int correctIndex;
  final LocalizedText explanation;
  final String? codeLine;
}
