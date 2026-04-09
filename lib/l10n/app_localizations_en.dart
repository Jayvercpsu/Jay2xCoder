// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Jay2xCoder';

  @override
  String get appSubtitle => 'Learn Programming Step by Step';

  @override
  String get navHome => 'Home';

  @override
  String get navRoadmap => 'Roadmap';

  @override
  String get navIde => 'IDE';

  @override
  String get navProgress => 'Progress';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonReset => 'Reset';

  @override
  String get commonSearch => 'Search';

  @override
  String homeWelcome(Object name) {
    return 'Welcome, $name';
  }

  @override
  String get homeSubtitle => 'Keep climbing your coding journey.';

  @override
  String get homeCurrentLevel => 'Current Level';

  @override
  String homeLevelTitle(int level, Object title) {
    return 'Level $level: $title';
  }

  @override
  String homeOverallProgress(int percent) {
    return 'Overall progress $percent%';
  }

  @override
  String get homeViewRoadmap => 'View Roadmap';

  @override
  String get homeContinueLearning => 'Continue Learning';

  @override
  String get homeRoadmapPreview => 'Roadmap Preview';

  @override
  String get homeDailyMotivation => 'Daily Motivation';

  @override
  String get homeRecentBadge => 'Recent Badge';

  @override
  String get homeNoBadgeYet => 'Complete your first lesson to earn a badge.';

  @override
  String get homeBookmarkedLessons => 'Bookmarked Lessons';

  @override
  String homeBookmarkedCount(int count) {
    return '$count saved lesson(s)';
  }

  @override
  String get onboardingTitle1 => 'Welcome to Jay2xCoder';

  @override
  String get onboardingMessage1 =>
      'A guided coding journey built for incoming IT freshmen.';

  @override
  String get onboardingTitle2 => 'Learn Step by Step';

  @override
  String get onboardingMessage2 =>
      'Start from basics, pass quizzes, and unlock higher levels gradually.';

  @override
  String get onboardingTitle3 => 'Practice the Essentials';

  @override
  String get onboardingMessage3 =>
      'Use lightweight activities: arrange code, find bugs, and match concepts.';

  @override
  String get onboardingTitle4 => 'Stay Focused';

  @override
  String get onboardingMessage4 =>
      'Track XP, badges, and progress with an offline-friendly learning dashboard.';

  @override
  String get onboardingStartLearning => 'Start Learning';

  @override
  String get roadmapTitle => 'Learning Roadmap';

  @override
  String get roadmapSubtitle =>
      'Unlock each level step by step until expert path.';

  @override
  String get roadmapSearchHint => 'Search lessons or levels';

  @override
  String get roadmapFavoritesOnly => 'Favorites only';

  @override
  String get roadmapNoResultsTitle => 'No matching lessons';

  @override
  String get roadmapNoResultsMessage =>
      'Try a different keyword or clear filters.';

  @override
  String get roadmapLockedSnack => 'Complete current lesson and quiz first.';

  @override
  String get lessonTitle => 'Lesson';

  @override
  String lessonAppBar(int level, int lesson) {
    return 'Level $level Lesson $lesson';
  }

  @override
  String get lessonMissingTitle => 'Lesson Missing';

  @override
  String get lessonMissingMessage =>
      'This lesson could not be found in local mock data.';

  @override
  String get lessonLockedTitle => 'Lesson Locked';

  @override
  String get lessonLockedMessage =>
      'Complete the previous lesson and pass its quiz first.';

  @override
  String get lessonExplanation => 'Explanation';

  @override
  String get lessonSimpleExample => 'Simple Example';

  @override
  String get lessonKeyTakeaways => 'Key Takeaways';

  @override
  String get lessonMiniActivity => 'Mini Activity';

  @override
  String get lessonCompletedMessage => 'Lesson completed. Great job!';

  @override
  String get lessonMarkAsComplete => 'Mark as Complete';

  @override
  String get lessonQuizPassed => 'Quiz Passed';

  @override
  String get lessonTakeQuiz => 'Take Quiz';

  @override
  String get lessonQuizSectionTitle => 'Quiz Checkpoint';

  @override
  String get lessonQuizSectionHint =>
      'After practice, take this simple quiz to check your understanding.';

  @override
  String get lessonPracticeActivity => 'Practice Activity';

  @override
  String get lessonBookmarkAdded => 'Lesson added to bookmarks.';

  @override
  String get lessonBookmarkRemoved => 'Lesson removed from bookmarks.';

  @override
  String get quizTitle => 'Quiz';

  @override
  String get quizLessonTitle => 'Lesson Quiz';

  @override
  String get quizNotFoundTitle => 'Quiz Not Found';

  @override
  String get quizNotFoundMessage =>
      'No local quiz data is available for this lesson.';

  @override
  String quizPassedBanner(int score) {
    return 'Passed! Score: $score%. Next lesson unlocked.';
  }

  @override
  String quizFailedBanner(int score, int required) {
    return 'Score: $score%. Need $required% to pass.';
  }

  @override
  String quizQuestionTypeLabel(int number, Object type) {
    return 'Q$number · $type';
  }

  @override
  String quizExplanationPrefix(Object text) {
    return 'Explanation: $text';
  }

  @override
  String get quizBackToLesson => 'Back to Lesson';

  @override
  String get quizRetry => 'Retry Quiz';

  @override
  String get quizSubmit => 'Submit Quiz';

  @override
  String get quizSubmitAnswer => 'Submit Answer';

  @override
  String get quizShowAnswer => 'Show Answer';

  @override
  String get quizNext => 'Next Question';

  @override
  String get quizFinish => 'Finish Quiz';

  @override
  String get quizNextLesson => 'Next Lesson';

  @override
  String get quizCorrectLabel => 'Correct answer';

  @override
  String get quizIncorrectLabel => 'Not quite right';

  @override
  String quizQuestionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String quizScoreSummary(int score) {
    return 'Final Score: $score%';
  }

  @override
  String quizCorrectAnswerLabel(Object answer) {
    return 'Correct answer: $answer';
  }

  @override
  String get quizSelectAnswerSnack => 'Please select an answer first.';

  @override
  String get quizAnswerAllSnack => 'Please answer all questions first.';

  @override
  String get quizTypeMultipleChoice => 'Multiple Choice';

  @override
  String get quizTypeTrueFalse => 'True or False';

  @override
  String get quizTypePredictOutput => 'Predict Output';

  @override
  String get quizTypeIdentification => 'Identification';

  @override
  String get quizTypeCodeMeaning => 'Code Meaning';

  @override
  String get practiceTitle => 'Practice';

  @override
  String get practiceActivityTitle => 'Practice Activity';

  @override
  String get practiceMissingTitle => 'Practice Missing';

  @override
  String get practiceMissingLessonMessage =>
      'This lesson does not have practice data.';

  @override
  String get practiceMissingLevelMessage =>
      'No practice set found for this level.';

  @override
  String practicePassedMessage(int score) {
    return 'Great work. Practice cleared ($score/3).';
  }

  @override
  String practiceFailedMessage(int score) {
    return 'Practice score: $score/3. Review and try again.';
  }

  @override
  String get practiceArrangeCode => '1) Arrange Code Order';

  @override
  String get practiceFindBug => '2) Find the Bug';

  @override
  String get practiceMatchConcept => '3) Match Concept and Definition';

  @override
  String get practiceRetry => 'Retry Practice';

  @override
  String get practiceSubmit => 'Submit Practice';

  @override
  String get ideTitle => 'Code IDE';

  @override
  String get ideSubtitle => 'Jump straight into coding practice templates.';

  @override
  String get ideHint =>
      'Choose a template, edit code, then run output instantly.';

  @override
  String get ideOpenButton => 'Open';

  @override
  String get ideNoTemplatesTitle => 'No IDE templates yet';

  @override
  String get ideNoTemplatesMessage =>
      'Add practice templates to start coding here.';

  @override
  String get ideHtmlStarterTitle => 'HTML Starter';

  @override
  String get ideHtmlStarterSubtitle =>
      'Basic page structure and semantic tags.';

  @override
  String get ideCssStarterTitle => 'CSS Starter';

  @override
  String get ideCssStarterSubtitle =>
      'Style, spacing, and clean visual layout.';

  @override
  String get ideJsStarterTitle => 'JavaScript Starter';

  @override
  String get ideJsStarterSubtitle => 'Variables, functions, and interaction.';

  @override
  String get ideFrameworkStarterTitle => 'Framework Layout';

  @override
  String get ideFrameworkStarterSubtitle =>
      'Bootstrap-like grid and reusable layout.';

  @override
  String get ideReactStarterTitle => 'React-style Components';

  @override
  String get ideReactStarterSubtitle => 'Build reusable component patterns.';

  @override
  String get ideProjectStarterTitle => 'Framework Project Flow';

  @override
  String get ideProjectStarterSubtitle =>
      'Binding, events, and modular mindset.';

  @override
  String get progressTitle => 'Learning Progress';

  @override
  String get progressSubtitle => 'Track mastery, XP, quizzes, and consistency.';

  @override
  String get progressMastery => 'Mastery';

  @override
  String get progressCurrentLevel => 'Current Level';

  @override
  String get progressXp => 'XP';

  @override
  String get progressStreak => 'Streak';

  @override
  String progressDays(int count) {
    return '$count day(s)';
  }

  @override
  String get progressLessonsCompleted => 'Lessons Completed';

  @override
  String get progressQuizzesPassed => 'Quizzes Passed';

  @override
  String get progressPracticeCleared => 'Practice Cleared';

  @override
  String get progressAchievementBadges => 'Achievement Badges';

  @override
  String get progressNoBadgesTitle => 'No badges yet';

  @override
  String get progressNoBadgesMessage =>
      'Complete your first lesson and quiz to start earning badges.';

  @override
  String get profileTitle => 'Profile';

  @override
  String profileLearnerLine(int level, int xp) {
    return 'Level $level Learner · $xp XP';
  }

  @override
  String get profileLearningSummary => 'Learning Summary';

  @override
  String get profileCompletedLessons => 'Completed Lessons';

  @override
  String get profilePassedQuizzes => 'Passed Quizzes';

  @override
  String get profileCompletionPercent => 'Profile Completion';

  @override
  String get profileCurrentStreak => 'Current Streak';

  @override
  String get profileAchievementBadges => 'Achievement Badges';

  @override
  String get profileNoBadgesTitle => 'No badges yet';

  @override
  String get profileNoBadgesMessage =>
      'Finish lessons and quizzes to unlock badges.';

  @override
  String get profileUpdateName => 'Update Name';

  @override
  String get profileNameHint => 'Enter your display name';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeSubtitle =>
      'Enable a darker theme for night study.';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Keep a simple reminder toggle (local only).';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSubtitle =>
      'Choose app language for labels and instructions.';

  @override
  String get settingsProgressControls => 'Progress Controls';

  @override
  String get settingsProgressDescription =>
      'Reset will clear lessons, quizzes, XP, streak, and badges. Theme and onboarding stay as-is.';

  @override
  String get settingsResetProgress => 'Reset Progress';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAboutDescription =>
      'Offline-first learning app for incoming IT freshmen. No login, no backend, just local guided progression.';

  @override
  String get settingsResetDialogTitle => 'Reset Progress?';

  @override
  String get settingsResetDialogMessage =>
      'This will remove your completed lessons, quizzes, XP, and badges.';

  @override
  String get settingsResetSuccess => 'Progress reset successfully.';

  @override
  String get lessonCodeExampleTitle => 'Code Example';

  @override
  String get lessonBriefExplanationTitle => 'Short Explanation';

  @override
  String get lessonExpectedOutputTitle => 'Expected Output';

  @override
  String get lessonProgressStepTitle => 'Complete This Step';

  @override
  String get lessonPracticeButton => 'Practice';

  @override
  String get lessonNextLessonButton => 'Next Lesson';

  @override
  String get lessonFinishPathButton => 'Back to Roadmap';

  @override
  String get lessonNextLocked =>
      'Pass the quiz first to unlock the next lesson.';

  @override
  String playgroundTitle(Object lessonTitle) {
    return 'Practice: $lessonTitle';
  }

  @override
  String get playgroundIntro =>
      'Edit the starter code, then run it to see output instantly.';

  @override
  String get playgroundStarterHint =>
      'Tip: Start small. Change one line, run, then observe output.';

  @override
  String get playgroundOutputPreview => 'Output Preview';

  @override
  String get playgroundRun => 'Run';

  @override
  String get playgroundReload => 'Reload';

  @override
  String get playgroundRestart => 'Restart';

  @override
  String get playgroundHtmlTab => 'HTML';

  @override
  String get playgroundCssTab => 'CSS';

  @override
  String get playgroundJsTab => 'JavaScript';

  @override
  String get lessonL11Title => 'What Is Programming?';

  @override
  String get lessonL11Intro => 'Programming gives instructions to computers.';

  @override
  String get lessonL11Output =>
      'A clear set of ordered steps to solve one simple task.';

  @override
  String get lessonL12Title => 'Logic and Algorithms';

  @override
  String get lessonL12Intro => 'Algorithms are ordered problem-solving steps.';

  @override
  String get lessonL12Output =>
      'A flow where input is checked and output is predictable.';

  @override
  String get lessonL21Title => 'HTML Structure and Tags';

  @override
  String get lessonL21Intro => 'HTML defines the structure of a web page.';

  @override
  String get lessonL21Output =>
      'A page showing a heading and paragraph in correct structure.';

  @override
  String get lessonL22Title => 'Links, Images, Lists, Forms';

  @override
  String get lessonL22Intro => 'Core HTML elements make pages useful.';

  @override
  String get lessonL22Output =>
      'A page with links, list items, and basic user input form elements.';

  @override
  String get lessonL31Title => 'CSS Syntax and Selectors';

  @override
  String get lessonL31Intro => 'CSS controls visual style and appearance.';

  @override
  String get lessonL31Output =>
      'The same HTML appears with custom colors, spacing, and style.';

  @override
  String get lessonL32Title => 'Flexbox and Responsive Basics';

  @override
  String get lessonL32Intro => 'Layouts should adapt to different screens.';

  @override
  String get lessonL32Output =>
      'Elements align in rows/columns and adjust better on small screens.';

  @override
  String get lessonL41Title => 'Variables, Conditions, and Loops';

  @override
  String get lessonL41Intro => 'JavaScript adds logic and behavior to pages.';

  @override
  String get lessonL41Output =>
      'Interactive output that changes when conditions or loops run.';

  @override
  String get lessonL42Title => 'Functions, Arrays, and Objects';

  @override
  String get lessonL42Intro =>
      'Organize logic and data with reusable patterns.';

  @override
  String get lessonL42Output =>
      'Structured output generated from arrays, objects, and function calls.';

  @override
  String get lessonL51Title => 'Bootstrap Layout Basics';

  @override
  String get lessonL51Intro =>
      'Use framework classes for faster responsive layout.';

  @override
  String get lessonL51Output =>
      'A simple grid-based page with reusable layout sections.';

  @override
  String get lessonL52Title => 'React Component Basics';

  @override
  String get lessonL52Intro =>
      'Split UI into reusable components and pass data.';

  @override
  String get lessonL52Output =>
      'Reusable component-style cards rendered from one function.';

  @override
  String get lessonL53Title => 'Vue and Angular Core Patterns';

  @override
  String get lessonL53Intro =>
      'Learn binding, components, and module-based structure.';

  @override
  String get lessonL53Output =>
      'Live UI output that updates from input and event logic.';

  @override
  String get lessonL71Title => 'Clean Code and Reusability';

  @override
  String get lessonL71Intro => 'Readable code scales better over time.';

  @override
  String get lessonL71Output =>
      'A reusable component-style section rendered from reusable logic.';

  @override
  String get lessonL72Title => 'API Intro and JSON Basics';

  @override
  String get lessonL72Intro => 'Apps exchange structured data through APIs.';

  @override
  String get lessonL72Output =>
      'Formatted JSON-like data shown in readable structure.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageBisaya => 'Bisaya';

  @override
  String get languageFilipino => 'Filipino';

  @override
  String get quote0 => 'Every expert once started with one line of code.';

  @override
  String get quote1 => 'Small progress daily beats rare giant efforts.';

  @override
  String get quote2 => 'Debugging sharpens your developer mindset.';

  @override
  String get quote3 => 'Clarity first, cleverness later.';

  @override
  String get quote4 => 'Build small, finish strong, then level up.';

  @override
  String get quote5 => 'Consistency turns beginners into builders.';

  @override
  String get quote6 => 'Your next lesson is your next breakthrough.';

  @override
  String get badgeFirstStep => 'First Step';

  @override
  String get badgeQuizStarter => 'Quiz Starter';

  @override
  String get badgePracticeExplorer => 'Practice Explorer';

  @override
  String get badgeMomentumCoder => 'Momentum Coder';

  @override
  String badgeLevelCleared(int level) {
    return 'Level $level Cleared';
  }

  @override
  String get badgeExpertTrailblazer => 'Expert Trailblazer';
}
