import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/data/models/lesson_quiz.dart';
import 'package:jay2xcoder/data/models/localized_text.dart';
import 'package:jay2xcoder/data/models/quiz_question.dart';
import 'package:jay2xcoder/l10n/app_localizations.dart';
import 'package:jay2xcoder/presentation/shared/widgets/soft_card.dart';
import 'package:jay2xcoder/presentation/shared/widgets/state_placeholder.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  final Map<int, int> _answers = <int, int>{};
  final Set<int> _revealed = <int>{};

  int _currentIndex = 0;
  bool _finished = false;
  int _score = 0;
  bool _passed = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;
    final String localeCode = ref.watch(appLocaleCodeProvider);
    final Map<String, LessonQuiz> quizzes = ref.watch(quizzesProvider);
    final LessonQuiz? quiz = quizzes[widget.lessonId];

    if (quiz == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.quizTitle),
          actions: <Widget>[
            IconButton(
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: StatePlaceholder(
            title: l10n.quizNotFoundTitle,
            message: l10n.quizNotFoundMessage,
            icon: Icons.help_outline_rounded,
          ),
        ),
      );
    }

    final int total = quiz.questions.length;
    final QuizQuestion currentQuestion = quiz.questions[_currentIndex];
    final bool currentRevealed = _revealed.contains(_currentIndex);
    final int? selected = _answers[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.quizLessonTitle),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _finished
              ? _ResultPane(
                  score: _score,
                  passed: _passed,
                  passScore: quiz.passScore,
                  onRetry: _resetQuiz,
                  onBackToLesson: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.pop();
                  },
                  onBackToHome: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.go('/home');
                  },
                  onNextLesson: () => _goNextLesson(context),
                  hasNextLesson: _hasNextLesson(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SoftCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              l10n.quizQuestionProgress(
                                _currentIndex + 1,
                                total,
                              ),
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _labelForType(l10n, currentQuestion.type),
                              style: theme.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _localized(currentQuestion.question, localeCode),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (currentQuestion.codeLine != null) ...<Widget>[
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.colorScheme.outline.withValues(
                                      alpha: 0.22,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  currentQuestion.codeLine!,
                                  style: GoogleFonts.firaCode(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 12),
                            ...currentQuestion.options.asMap().entries.map((
                              MapEntry<int, LocalizedText> optionEntry,
                            ) {
                              final int optionIndex = optionEntry.key;
                              final bool isSelected = selected == optionIndex;
                              final bool isCorrect =
                                  optionIndex == currentQuestion.correctIndex;

                              final Color borderColor;
                              final Color fillColor;

                              if (currentRevealed && isCorrect) {
                                borderColor = Colors.green;
                                fillColor = Colors.green.withValues(
                                  alpha: 0.12,
                                );
                              } else if (currentRevealed &&
                                  isSelected &&
                                  !isCorrect) {
                                borderColor = Colors.red;
                                fillColor = Colors.red.withValues(alpha: 0.12);
                              } else {
                                borderColor = isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outline.withValues(
                                        alpha: 0.26,
                                      );
                                fillColor = isSelected
                                    ? theme.colorScheme.primary.withValues(
                                        alpha: 0.08,
                                      )
                                    : Colors.transparent;
                              }

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: currentRevealed
                                      ? null
                                      : () {
                                          setState(() {
                                            _answers[_currentIndex] =
                                                optionIndex;
                                          });
                                        },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 160),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: borderColor),
                                      color: fillColor,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          isSelected
                                              ? Icons
                                                    .radio_button_checked_rounded
                                              : Icons.radio_button_off_rounded,
                                          size: 18,
                                          color: isSelected
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.outline,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _localized(
                                              optionEntry.value,
                                              localeCode,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            if (currentRevealed) ...<Widget>[
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    selected == currentQuestion.correctIndex
                                        ? Icons.check_circle_rounded
                                        : Icons.info_rounded,
                                    color:
                                        selected == currentQuestion.correctIndex
                                        ? Colors.green
                                        : theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      selected == currentQuestion.correctIndex
                                          ? l10n.quizCorrectLabel
                                          : l10n.quizIncorrectLabel,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.quizCorrectAnswerLabel(
                                  _localized(
                                    currentQuestion.options[currentQuestion
                                        .correctIndex],
                                    localeCode,
                                  ),
                                ),
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.quizExplanationPrefix(
                                  _localized(
                                    currentQuestion.explanation,
                                    localeCode,
                                  ),
                                ),
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (!currentRevealed) ...<Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitCurrent,
                            child: Text(l10n.quizSubmitAnswer),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _showAnswer,
                            child: Text(l10n.quizShowAnswer),
                          ),
                        ),
                      ] else
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _nextQuestion(quiz),
                            child: Text(
                              _currentIndex == total - 1
                                  ? l10n.quizFinish
                                  : l10n.quizNext,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  String _localized(LocalizedText text, String localeCode) {
    return text.resolve(localeCode);
  }

  String _labelForType(AppLocalizations l10n, QuizQuestionType type) {
    switch (type) {
      case QuizQuestionType.multipleChoice:
        return l10n.quizTypeMultipleChoice;
      case QuizQuestionType.trueFalse:
        return l10n.quizTypeTrueFalse;
      case QuizQuestionType.predictOutput:
        return l10n.quizTypePredictOutput;
      case QuizQuestionType.identification:
        return l10n.quizTypeIdentification;
      case QuizQuestionType.codeMeaning:
        return l10n.quizTypeCodeMeaning;
    }
  }

  void _submitCurrent() {
    final int? selected = _answers[_currentIndex];
    if (selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.quizSelectAnswerSnack)),
      );
      return;
    }

    if (_revealed.contains(_currentIndex)) {
      return;
    }

    setState(() {
      _revealed.add(_currentIndex);
    });
  }

  void _showAnswer() {
    if (_revealed.contains(_currentIndex)) {
      return;
    }

    setState(() {
      _revealed.add(_currentIndex);
    });
  }

  Future<void> _nextQuestion(LessonQuiz quiz) async {
    if (!_revealed.contains(_currentIndex)) {
      return;
    }

    if (_currentIndex < quiz.questions.length - 1) {
      setState(() {
        _currentIndex += 1;
      });
      return;
    }

    int correct = 0;
    for (int i = 0; i < quiz.questions.length; i++) {
      if (_answers[i] == quiz.questions[i].correctIndex) {
        correct += 1;
      }
    }

    final int score = ((correct / quiz.questions.length) * 100).round();
    final bool passed = score >= quiz.passScore;

    if (passed) {
      final controller = ref.read(appStateControllerProvider.notifier);
      await controller.markLessonComplete(widget.lessonId);
      await controller.markQuizPassed(widget.lessonId);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _score = score;
      _passed = passed;
      _finished = true;
    });
  }

  void _resetQuiz() {
    setState(() {
      _answers.clear();
      _revealed.clear();
      _currentIndex = 0;
      _finished = false;
      _score = 0;
      _passed = false;
    });
  }

  bool _hasNextLesson() {
    final List<LearningLevel> levels = ref.read(levelsProvider);
    final LessonItem? lesson = findLessonById(levels, widget.lessonId);
    if (lesson == null) {
      return false;
    }
    return nextLessonAfter(levels: levels, currentLesson: lesson) != null;
  }

  void _goNextLesson(BuildContext context) {
    final List<LearningLevel> levels = ref.read(levelsProvider);
    final LessonItem? lesson = findLessonById(levels, widget.lessonId);
    if (lesson == null) {
      context.pop();
      return;
    }

    final LessonItem? next = nextLessonAfter(
      levels: levels,
      currentLesson: lesson,
    );
    if (next == null) {
      context.go('/roadmap');
      return;
    }

    context.push('/lesson/${next.id}');
  }
}

class _ResultPane extends StatelessWidget {
  const _ResultPane({
    required this.score,
    required this.passed,
    required this.passScore,
    required this.onRetry,
    required this.onBackToLesson,
    required this.onBackToHome,
    required this.onNextLesson,
    required this.hasNextLesson,
  });

  final int score;
  final bool passed;
  final int passScore;
  final VoidCallback onRetry;
  final VoidCallback onBackToLesson;
  final VoidCallback onBackToHome;
  final VoidCallback onNextLesson;
  final bool hasNextLesson;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    passed ? Icons.emoji_events_rounded : Icons.school_rounded,
                    color: passed ? Colors.green : theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      passed
                          ? l10n.quizPassedBanner(score)
                          : l10n.quizFailedBanner(score, passScore),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                l10n.quizScoreSummary(score),
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: passed ? onNextLesson : onRetry,
            child: Text(
              passed
                  ? (hasNextLesson
                        ? l10n.quizNextLesson
                        : l10n.lessonFinishPathButton)
                  : l10n.quizRetry,
            ),
          ),
        ),
        if (passed) ...<Widget>[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onRetry,
              child: Text(l10n.quizRetry),
            ),
          ),
        ],
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onBackToHome,
            icon: const Icon(Icons.home_rounded),
            label: const Text('Back to Home'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onBackToLesson,
            icon: const Icon(Icons.menu_book_rounded),
            label: Text(l10n.quizBackToLesson),
          ),
        ),
      ],
    );
  }
}
