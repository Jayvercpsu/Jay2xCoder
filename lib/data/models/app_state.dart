import 'package:jay2xcoder/core/localization/localization_helpers.dart';

class AppState {
  static const Object _noValue = Object();

  const AppState({
    required this.onboardingSeen,
    required this.darkMode,
    required this.notificationsEnabled,
    required this.localeCode,
    required this.learnerName,
    required this.completedLessons,
    required this.passedQuizzes,
    required this.completedPractices,
    required this.bookmarkedLessons,
    required this.xp,
    required this.streak,
    required this.badges,
    required this.lastBadge,
    required this.lastLearningDate,
  });

  factory AppState.initial() {
    return const AppState(
      onboardingSeen: false,
      darkMode: false,
      notificationsEnabled: true,
      localeCode: 'en',
      learnerName: 'Future Developer',
      completedLessons: <String>{},
      passedQuizzes: <String>{},
      completedPractices: <String>{},
      bookmarkedLessons: <String>{},
      xp: 0,
      streak: 0,
      badges: <String>[],
      lastBadge: null,
      lastLearningDate: null,
    );
  }

  factory AppState.fromMap(Map<dynamic, dynamic> map) {
    final lastDate = map['lastLearningDate'] as String?;
    return AppState(
      onboardingSeen: map['onboardingSeen'] as bool? ?? false,
      darkMode: map['darkMode'] as bool? ?? false,
      notificationsEnabled: map['notificationsEnabled'] as bool? ?? true,
      localeCode: normalizeLocaleCode(map['localeCode'] as String?),
      learnerName: map['learnerName'] as String? ?? 'Future Developer',
      completedLessons:
          ((map['completedLessons'] as List?) ?? const <dynamic>[])
              .map((dynamic item) => item.toString())
              .toSet(),
      passedQuizzes: ((map['passedQuizzes'] as List?) ?? const <dynamic>[])
          .map((dynamic item) => item.toString())
          .toSet(),
      completedPractices:
          ((map['completedPractices'] as List?) ?? const <dynamic>[])
              .map((dynamic item) => item.toString())
              .toSet(),
      bookmarkedLessons:
          ((map['bookmarkedLessons'] as List?) ?? const <dynamic>[])
              .map((dynamic item) => item.toString())
              .toSet(),
      xp: map['xp'] as int? ?? 0,
      streak: map['streak'] as int? ?? 0,
      badges: ((map['badges'] as List?) ?? const <dynamic>[])
          .map((dynamic item) => item.toString())
          .toList(growable: false),
      lastBadge: map['lastBadge'] as String?,
      lastLearningDate: lastDate == null ? null : DateTime.tryParse(lastDate),
    );
  }

  final bool onboardingSeen;
  final bool darkMode;
  final bool notificationsEnabled;
  final String localeCode;
  final String learnerName;
  final Set<String> completedLessons;
  final Set<String> passedQuizzes;
  final Set<String> completedPractices;
  final Set<String> bookmarkedLessons;
  final int xp;
  final int streak;
  final List<String> badges;
  final String? lastBadge;
  final DateTime? lastLearningDate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'onboardingSeen': onboardingSeen,
      'darkMode': darkMode,
      'notificationsEnabled': notificationsEnabled,
      'localeCode': localeCode,
      'learnerName': learnerName,
      'completedLessons': completedLessons.toList(growable: false),
      'passedQuizzes': passedQuizzes.toList(growable: false),
      'completedPractices': completedPractices.toList(growable: false),
      'bookmarkedLessons': bookmarkedLessons.toList(growable: false),
      'xp': xp,
      'streak': streak,
      'badges': badges,
      'lastBadge': lastBadge,
      'lastLearningDate': lastLearningDate?.toIso8601String(),
    };
  }

  AppState copyWith({
    bool? onboardingSeen,
    bool? darkMode,
    bool? notificationsEnabled,
    String? localeCode,
    String? learnerName,
    Set<String>? completedLessons,
    Set<String>? passedQuizzes,
    Set<String>? completedPractices,
    Set<String>? bookmarkedLessons,
    int? xp,
    int? streak,
    List<String>? badges,
    Object? lastBadge = _noValue,
    DateTime? lastLearningDate,
  }) {
    return AppState(
      onboardingSeen: onboardingSeen ?? this.onboardingSeen,
      darkMode: darkMode ?? this.darkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      localeCode: localeCode ?? this.localeCode,
      learnerName: learnerName ?? this.learnerName,
      completedLessons: completedLessons ?? this.completedLessons,
      passedQuizzes: passedQuizzes ?? this.passedQuizzes,
      completedPractices: completedPractices ?? this.completedPractices,
      bookmarkedLessons: bookmarkedLessons ?? this.bookmarkedLessons,
      xp: xp ?? this.xp,
      streak: streak ?? this.streak,
      badges: badges ?? this.badges,
      lastBadge: identical(lastBadge, _noValue)
          ? this.lastBadge
          : lastBadge as String?,
      lastLearningDate: lastLearningDate ?? this.lastLearningDate,
    );
  }
}
