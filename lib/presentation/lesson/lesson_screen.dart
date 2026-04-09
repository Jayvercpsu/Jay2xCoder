import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  late final FlutterTts _tts;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _tts = FlutterTts();
    _tts
      ..setSpeechRate(0.46)
      ..setPitch(1.0)
      ..setVolume(1.0);
    _tts.setStartHandler(() {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSpeaking = true;
      });
    });
    _tts.setCompletionHandler(() {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSpeaking = false;
      });
    });
    _tts.setCancelHandler(() {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSpeaking = false;
      });
    });
    _tts.setErrorHandler((dynamic _) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  @override
  void dispose() {
    unawaited(_tts.stop());
    super.dispose();
  }

  Future<void> _toggleNarration({
    required LessonItem lesson,
    required String title,
    required String intro,
    required String output,
  }) async {
    if (_isSpeaking) {
      await _tts.stop();
      return;
    }
    await _speakLesson(
      lesson: lesson,
      title: title,
      intro: intro,
      output: output,
    );
  }

  Future<void> _speakLesson({
    required LessonItem lesson,
    required String title,
    required String intro,
    required String output,
  }) async {
    final String localeCode = ref.read(appLocaleCodeProvider);
    final String language = switch (localeCode) {
      'ceb' => 'en-PH',
      'fil' => 'fil-PH',
      _ => 'en-US',
    };
    await _configureVoice(language);
    final String notes = lesson.keyTakeaways.take(4).join('. ');
    final String script =
        '$title. $intro. Key notes: $notes. Activity: $output.';
    await _tts.stop();
    await _tts.speak(script);
  }

  Future<void> _configureVoice(String language) async {
    await _tts.setLanguage(language);
    await _tts.setSpeechRate(0.46);
    await _tts.setPitch(0.95);

    try {
      final dynamic voicesRaw = await _tts.getVoices;
      if (voicesRaw is! List) {
        return;
      }

      final String baseLang = language.split('-').first.toLowerCase();
      Map<String, dynamic>? localeMale;
      Map<String, dynamic>? anyMale;
      Map<String, dynamic>? localeAny;

      for (final dynamic entry in voicesRaw) {
        if (entry is! Map) {
          continue;
        }
        final Map<String, dynamic> voice = Map<String, dynamic>.from(entry);
        final String locale = (voice['locale'] ?? voice['language'] ?? '')
            .toString()
            .toLowerCase();
        final String meta =
            '${voice['gender'] ?? ''} ${voice['name'] ?? ''} ${voice['identifier'] ?? ''}'
                .toLowerCase();
        final bool localeMatch = locale.startsWith(baseLang);
        final bool maleHint =
            meta.contains('male') ||
            meta.contains('man') ||
            meta.contains('boy') ||
            meta.contains('david') ||
            meta.contains('mark') ||
            meta.contains('john') ||
            meta.contains('paul');

        if (localeMatch && maleHint) {
          localeMale = voice;
          break;
        }
        if (maleHint) {
          anyMale ??= voice;
        }
        if (localeMatch) {
          localeAny ??= voice;
        }
      }

      final Map<String, dynamic>? selected = localeMale ?? anyMale ?? localeAny;
      if (selected == null) {
        return;
      }

      final String? name = selected['name']?.toString();
      final String locale =
          (selected['locale'] ?? selected['language'] ?? language).toString();
      if (name == null || name.isEmpty) {
        return;
      }

      await _tts.setVoice(<String, String>{'name': name, 'locale': locale});
    } catch (_) {
      // Voice list support differs per device/engine; fallback to default.
    }
  }

  Future<void> _showLessonFinishedOptions({
    required LessonItem? nextLesson,
    required bool canGoNext,
    required bool quizRequired,
    required bool quizPassed,
  }) async {
    if (!mounted) {
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (BuildContext sheetContext) {
        final ThemeData theme = Theme.of(sheetContext);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Lesson Completed',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Choose what you want to do next.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: ReferencePalette.onMuted(sheetContext),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pop(sheetContext);
                          context.go('/home');
                        },
                        child: const Text('Back to Home'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        child: const Text('Back to Lesson'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Proceed to Next Lesson'),
                    onPressed: () {
                      Navigator.pop(sheetContext);

                      if (!mounted) {
                        return;
                      }
                      if (nextLesson == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No next lesson yet.')),
                        );
                        return;
                      }

                      if (quizRequired && !quizPassed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Pass the lesson quiz first to unlock next lesson.',
                            ),
                          ),
                        );
                        return;
                      }

                      if (!canGoNext) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Finish this lesson first before opening next.',
                            ),
                          ),
                        );
                        return;
                      }

                      context.push('/lesson/${nextLesson.id}');
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;
    final state = ref.watch(appStateControllerProvider);
    final List<LearningLevel> levels = ref.watch(levelsProvider);

    final LessonItem? lesson = findLessonById(levels, widget.lessonId);
    if (lesson == null) {
      return Scaffold(body: const Center(child: Text('Lesson not found.')));
    }

    final bool unlocked = isLessonUnlocked(
      lesson: lesson,
      levels: levels,
      state: state,
    );
    final bool quizRequired = lessonRequiresQuiz(lesson.id);
    final bool quizPassed =
        !quizRequired || state.passedQuizzes.contains(lesson.id);
    final bool completed = state.completedLessons.contains(lesson.id);

    final LessonItem? next = nextLessonAfter(
      levels: levels,
      currentLesson: lesson,
    );
    final bool canGoNext =
        next != null && isLessonMastered(lesson: lesson, state: state);

    final String title = localizedLessonTitle(l10n, lesson);
    final String intro = localizedLessonIntro(l10n, lesson);
    final String output = localizedLessonExpectedOutput(
      l10n,
      lesson,
      lesson.miniActivity,
    );
    final String discussion = lesson.detailedExplanation.replaceAll(
      '\\n',
      '\n',
    );
    final String formattedExample = lesson.example.replaceAll('\\n', '\n');

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const DevBackground(),
          SafeArea(
            child: unlocked
                ? SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () => context.pop(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: ReferencePalette.onSurface(context),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _toggleNarration(
                                lesson: lesson,
                                title: title,
                                intro: intro,
                                output: output,
                              ),
                              icon: Icon(
                                _isSpeaking
                                    ? Icons.volume_off_rounded
                                    : Icons.volume_up_rounded,
                              ),
                            ),
                            IconButton(
                              onPressed: () => context.push('/settings'),
                              icon: const Icon(Icons.settings_outlined),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ReferenceCard(
                          color: const Color(0xFFEFEFFF),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'What is this?',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: ReferencePalette.onSurface(context),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                intro,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: ReferencePalette.onMuted(context),
                                  height: 1.45,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFD7DFF2),
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.volume_up_rounded,
                                      size: 18,
                                      color: ReferencePalette.accentStart,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Tap the speaker icon to read this lesson aloud.',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: ReferencePalette.onMuted(
                                                context,
                                              ),
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Discussion',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: ReferencePalette.onSurface(context),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFD7DFF2),
                                  ),
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 220,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      discussion,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: ReferencePalette.onMuted(
                                              context,
                                            ),
                                            height: 1.5,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Example',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: ReferencePalette.onSurface(context),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: ReferencePalette.codeBackground,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 260,
                                  ),
                                  child: SingleChildScrollView(
                                    child: SelectableText(
                                      formattedExample,
                                      style: GoogleFonts.firaCode(
                                        fontSize: 12,
                                        height: 1.4,
                                        color: const Color(0xFFD1E9FF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Key Notes',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: ReferencePalette.onSurface(context),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...lesson.keyTakeaways
                                  .take(4)
                                  .map(
                                    (String note) => Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.circle,
                                              size: 8,
                                              color:
                                                  ReferencePalette.accentStart,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              note,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                    color: ReferencePalette
                                                        .mutedText,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              const SizedBox(height: 4),
                              Text(
                                output,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: ReferencePalette.onMuted(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ReferenceSecondaryButton(
                                label: completed
                                    ? 'Read Again'
                                    : 'Mark as Read',
                                onPressed: () async {
                                  final bool wasCompleted = completed;
                                  if (!completed) {
                                    await ref
                                        .read(
                                          appStateControllerProvider.notifier,
                                        )
                                        .markLessonComplete(lesson.id);
                                  }

                                  if (!context.mounted) {
                                    return;
                                  }

                                  if (!wasCompleted) {
                                    final updatedState = ref.read(
                                      appStateControllerProvider,
                                    );
                                    final bool updatedQuizPassed =
                                        !quizRequired ||
                                        updatedState.passedQuizzes.contains(
                                          lesson.id,
                                        );
                                    final bool updatedCanGoNext =
                                        next != null &&
                                        isLessonMastered(
                                          lesson: lesson,
                                          state: updatedState,
                                        );

                                    await _showLessonFinishedOptions(
                                      nextLesson: next,
                                      canGoNext: updatedCanGoNext,
                                      quizRequired: quizRequired,
                                      quizPassed: updatedQuizPassed,
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ReferencePrimaryButton(
                                label: quizRequired && !quizPassed
                                    ? 'Take Quiz'
                                    : 'Next Lesson',
                                onPressed: quizRequired && !quizPassed
                                    ? () => context.push(
                                        '/lesson/${lesson.id}/quiz',
                                      )
                                    : canGoNext
                                    ? () => context.push('/lesson/${next.id}')
                                    : () {
                                        final String message;
                                        if (next == null) {
                                          message = 'No next lesson yet.';
                                        } else {
                                          message =
                                              'Finish this lesson first before opening next.';
                                        }
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text(message)),
                                        );
                                      },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SafeArea(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ReferenceCard(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Icon(
                                Icons.lock_outline_rounded,
                                size: 42,
                                color: ReferencePalette.accentStart,
                              ),
                              SizedBox(height: 10),
                              Text('Lesson is locked right now.'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
