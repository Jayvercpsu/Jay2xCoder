import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/data/models/lesson_quiz.dart';
import 'package:jay2xcoder/data/models/localized_text.dart';
import 'package:jay2xcoder/data/models/quiz_question.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  int? _selected;
  bool _submitted = false;
  bool _correct = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;
    final String localeCode = ref.watch(appLocaleCodeProvider);
    final List<LearningLevel> levels = ref.watch(levelsProvider);
    final Map<String, LessonQuiz> quizzes = ref.watch(quizzesProvider);

    final LessonItem? lesson = findLessonById(levels, widget.lessonId);
    if (lesson == null) {
      return const Scaffold(body: Center(child: Text('Lesson not found.')));
    }

    final LessonQuiz? quiz = quizzes[widget.lessonId];
    final QuizQuestion? question = quiz?.questions.firstOrNull;

    final String questionText = question == null
        ? 'Which step should come first in coding practice?'
        : _resolved(question.question, localeCode);

    final List<String> options = question == null
        ? <String>[
            'Understand the problem',
            'Skip reading',
            'Guess random output',
            'Ignore examples',
          ]
        : question.options
              .take(4)
              .map((LocalizedText text) => _resolved(text, localeCode))
              .toList();

    final int answerIndex = question?.correctIndex ?? 0;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const DevBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      Text(
                        'Practice Quiz',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: ReferencePalette.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ReferenceCard(
                    child: Text(
                      questionText,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: ReferencePalette.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Multiple Choice',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: ReferencePalette.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.separated(
                      itemCount: options.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (BuildContext context, int index) {
                        final bool selected = _selected == index;
                        final bool showState = _submitted;
                        final bool right = index == answerIndex;

                        Color fill = Colors.white;
                        Color border = const Color(0xFFD6E2F6);
                        if (selected) {
                          fill = const Color(0xFFE8F0FF);
                          border = ReferencePalette.primary;
                        }
                        if (showState && right) {
                          fill = const Color(0xFFDDF6E8);
                          border = const Color(0xFF43A96B);
                        }
                        if (showState && selected && !right) {
                          fill = const Color(0xFFFFE4E4);
                          border = const Color(0xFFD96D6D);
                        }

                        final String letter = String.fromCharCode(65 + index);

                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: _submitted
                              ? null
                              : () {
                                  setState(() {
                                    _selected = index;
                                  });
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: fill,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: border),
                            ),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: const Color(0xFFE2E8F8),
                                  child: Text(
                                    letter,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: ReferencePalette.textPrimary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    options[index],
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: ReferencePalette.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ReferencePrimaryButton(
                    label: _submitted && _correct
                        ? 'Continue to Quiz'
                        : 'Check Answer',
                    onPressed: () async {
                      if (_submitted && _correct) {
                        context.push('/lesson/${widget.lessonId}/quiz');
                        return;
                      }

                      if (_selected == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.quizSelectAnswerSnack)),
                        );
                        return;
                      }

                      final bool isCorrect = _selected == answerIndex;
                      if (isCorrect) {
                        await ref
                            .read(appStateControllerProvider.notifier)
                            .markPracticeComplete(lesson.levelId);
                      }

                      setState(() {
                        _submitted = true;
                        _correct = isCorrect;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      _submitted
                          ? (_correct
                                ? 'Good job!'
                                : 'Try again then check answer.')
                          : 'Choose one answer first.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: _submitted && _correct
                            ? const Color(0xFF28985B)
                            : ReferencePalette.textMuted,
                        fontWeight: _submitted && _correct
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _resolved(LocalizedText text, String localeCode) {
    return text.resolve(localeCode);
  }
}

extension _FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
