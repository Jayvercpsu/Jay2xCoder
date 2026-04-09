import 'package:jay2xcoder/data/models/quiz_question.dart';

class LessonQuiz {
  const LessonQuiz({
    required this.lessonId,
    required this.passScore,
    required this.questions,
  });

  final String lessonId;
  final int passScore;
  final List<QuizQuestion> questions;
}
