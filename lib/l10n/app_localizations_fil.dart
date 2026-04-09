// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appName => 'Jay2xCoder';

  @override
  String get appSubtitle => 'Matutong Mag-Programming Step by Step';

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
  String get commonContinue => 'Magpatuloy';

  @override
  String get commonSkip => 'Laktawan';

  @override
  String get commonCancel => 'Kanselahin';

  @override
  String get commonSave => 'I-save';

  @override
  String get commonReset => 'I-reset';

  @override
  String get commonSearch => 'Maghanap';

  @override
  String homeWelcome(Object name) {
    return 'Welcome, $name';
  }

  @override
  String get homeSubtitle => 'Ipagpatuloy ang iyong coding journey.';

  @override
  String get homeCurrentLevel => 'Kasalukuyang Level';

  @override
  String homeLevelTitle(int level, Object title) {
    return 'Level $level: $title';
  }

  @override
  String homeOverallProgress(int percent) {
    return 'Kabuuang progress $percent%';
  }

  @override
  String get homeViewRoadmap => 'Tingnan ang Roadmap';

  @override
  String get homeContinueLearning => 'Magpatuloy sa Pag-aaral';

  @override
  String get homeRoadmapPreview => 'Roadmap Preview';

  @override
  String get homeDailyMotivation => 'Araw-araw na Motivation';

  @override
  String get homeRecentBadge => 'Pinakabagong Badge';

  @override
  String get homeNoBadgeYet =>
      'Tapusin ang iyong unang lesson para makakuha ng badge.';

  @override
  String get homeBookmarkedLessons => 'Naka-bookmark na Lessons';

  @override
  String homeBookmarkedCount(int count) {
    return '$count lesson(s) ang naka-save';
  }

  @override
  String get onboardingTitle1 => 'Welcome sa Jay2xCoder';

  @override
  String get onboardingMessage1 =>
      'Isang guided coding journey para sa incoming IT freshmen.';

  @override
  String get onboardingTitle2 => 'Matuto Step by Step';

  @override
  String get onboardingMessage2 =>
      'Magsimula sa basics, pumasa sa quizzes, at mag-unlock ng mas mataas na levels.';

  @override
  String get onboardingTitle3 => 'I-practice ang Essentials';

  @override
  String get onboardingMessage3 =>
      'Lightweight activities: ayusin ang code, hanapin ang bug, at i-match ang concepts.';

  @override
  String get onboardingTitle4 => 'Manatiling Focused';

  @override
  String get onboardingMessage4 =>
      'I-track ang XP, badges, at progress gamit ang offline-friendly dashboard.';

  @override
  String get onboardingStartLearning => 'Simulan ang Pag-aaral';

  @override
  String get roadmapTitle => 'Learning Roadmap';

  @override
  String get roadmapSubtitle =>
      'I-unlock ang bawat level step by step hanggang expert path.';

  @override
  String get roadmapSearchHint => 'Maghanap ng lesson o level';

  @override
  String get roadmapFavoritesOnly => 'Favorites lang';

  @override
  String get roadmapNoResultsTitle => 'Walang tugmang lessons';

  @override
  String get roadmapNoResultsMessage =>
      'Subukan ang ibang keyword o i-clear ang filters.';

  @override
  String get roadmapLockedSnack => 'Tapusin muna ang current lesson at quiz.';

  @override
  String get lessonTitle => 'Lesson';

  @override
  String lessonAppBar(int level, int lesson) {
    return 'Level $level Lesson $lesson';
  }

  @override
  String get lessonMissingTitle => 'Walang Lesson';

  @override
  String get lessonMissingMessage =>
      'Hindi makita ang lesson sa local mock data.';

  @override
  String get lessonLockedTitle => 'Naka-lock ang Lesson';

  @override
  String get lessonLockedMessage =>
      'Tapusin muna ang previous lesson at pumasa sa quiz.';

  @override
  String get lessonExplanation => 'Paliwanag';

  @override
  String get lessonSimpleExample => 'Simpleng Halimbawa';

  @override
  String get lessonKeyTakeaways => 'Mahahalagang Takeaways';

  @override
  String get lessonMiniActivity => 'Mini Activity';

  @override
  String get lessonCompletedMessage => 'Tapos na ang lesson. Good job!';

  @override
  String get lessonMarkAsComplete => 'Markahan bilang Complete';

  @override
  String get lessonQuizPassed => 'Quiz Passed';

  @override
  String get lessonTakeQuiz => 'Take Quiz';

  @override
  String get lessonQuizSectionTitle => 'Quiz Checkpoint';

  @override
  String get lessonQuizSectionHint =>
      'Pagkatapos ng practice, sagutan ang simpleng quiz na ito para ma-check ang pag-unawa mo.';

  @override
  String get lessonPracticeActivity => 'Practice Activity';

  @override
  String get lessonBookmarkAdded => 'Naidagdag ang lesson sa bookmarks.';

  @override
  String get lessonBookmarkRemoved => 'Inalis ang lesson sa bookmarks.';

  @override
  String get quizTitle => 'Quiz';

  @override
  String get quizLessonTitle => 'Lesson Quiz';

  @override
  String get quizNotFoundTitle => 'Walang Quiz';

  @override
  String get quizNotFoundMessage =>
      'Walang local quiz data para sa lesson na ito.';

  @override
  String quizPassedBanner(int score) {
    return 'Passed! Score: $score%. Na-unlock na ang susunod na lesson.';
  }

  @override
  String quizFailedBanner(int score, int required) {
    return 'Score: $score%. Kailangan ng $required% para pumasa.';
  }

  @override
  String quizQuestionTypeLabel(int number, Object type) {
    return 'Q$number · $type';
  }

  @override
  String quizExplanationPrefix(Object text) {
    return 'Paliwanag: $text';
  }

  @override
  String get quizBackToLesson => 'Balik sa Lesson';

  @override
  String get quizRetry => 'Subukan Muli ang Quiz';

  @override
  String get quizSubmit => 'I-submit ang Quiz';

  @override
  String get quizSubmitAnswer => 'I-submit ang Sagot';

  @override
  String get quizShowAnswer => 'Ipakita ang Sagot';

  @override
  String get quizNext => 'Susunod na Tanong';

  @override
  String get quizFinish => 'Tapusin ang Quiz';

  @override
  String get quizNextLesson => 'Susunod na Lesson';

  @override
  String get quizCorrectLabel => 'Tamang sagot';

  @override
  String get quizIncorrectLabel => 'Hindi pa tama';

  @override
  String quizQuestionProgress(int current, int total) {
    return 'Tanong $current sa $total';
  }

  @override
  String quizScoreSummary(int score) {
    return 'Final Score: $score%';
  }

  @override
  String quizCorrectAnswerLabel(Object answer) {
    return 'Tamang sagot: $answer';
  }

  @override
  String get quizSelectAnswerSnack => 'Pumili muna ng sagot.';

  @override
  String get quizAnswerAllSnack => 'Sagutan muna ang lahat ng tanong.';

  @override
  String get quizTypeMultipleChoice => 'Multiple Choice';

  @override
  String get quizTypeTrueFalse => 'True or False';

  @override
  String get quizTypePredictOutput => 'Hulaan ang Output';

  @override
  String get quizTypeIdentification => 'Identification';

  @override
  String get quizTypeCodeMeaning => 'Kahulugan ng Code';

  @override
  String get practiceTitle => 'Practice';

  @override
  String get practiceActivityTitle => 'Practice Activity';

  @override
  String get practiceMissingTitle => 'Walang Practice';

  @override
  String get practiceMissingLessonMessage =>
      'Ang lesson na ito ay walang practice data.';

  @override
  String get practiceMissingLevelMessage =>
      'Walang practice set para sa level na ito.';

  @override
  String practicePassedMessage(int score) {
    return 'Magaling! Tapos ang practice ($score/3).';
  }

  @override
  String practiceFailedMessage(int score) {
    return 'Practice score: $score/3. I-review at subukan muli.';
  }

  @override
  String get practiceArrangeCode => '1) Ayusin ang Code Order';

  @override
  String get practiceFindBug => '2) Hanapin ang Bug';

  @override
  String get practiceMatchConcept => '3) I-match ang Concept at Definition';

  @override
  String get practiceRetry => 'Subukan Muli ang Practice';

  @override
  String get practiceSubmit => 'I-submit ang Practice';

  @override
  String get ideTitle => 'Code IDE';

  @override
  String get ideSubtitle => 'Diretsong coding practice gamit ang templates.';

  @override
  String get ideHint => 'Pumili ng template, i-edit ang code, at i-run agad.';

  @override
  String get ideOpenButton => 'Buksan';

  @override
  String get ideNoTemplatesTitle => 'Wala pang IDE templates';

  @override
  String get ideNoTemplatesMessage =>
      'Magdagdag ng templates para makapag-code dito.';

  @override
  String get ideHtmlStarterTitle => 'HTML Starter';

  @override
  String get ideHtmlStarterSubtitle => 'Basic page structure at semantic tags.';

  @override
  String get ideCssStarterTitle => 'CSS Starter';

  @override
  String get ideCssStarterSubtitle => 'Style, spacing, at malinis na layout.';

  @override
  String get ideJsStarterTitle => 'JavaScript Starter';

  @override
  String get ideJsStarterSubtitle => 'Variables, functions, at interaction.';

  @override
  String get ideFrameworkStarterTitle => 'Framework Layout';

  @override
  String get ideFrameworkStarterSubtitle =>
      'Bootstrap-style grid at reusable layout.';

  @override
  String get ideReactStarterTitle => 'React-style Components';

  @override
  String get ideReactStarterSubtitle =>
      'Gumawa ng reusable component patterns.';

  @override
  String get ideProjectStarterTitle => 'Framework Project Flow';

  @override
  String get ideProjectStarterSubtitle =>
      'Binding, events, at modular mindset.';

  @override
  String get progressTitle => 'Learning Progress';

  @override
  String get progressSubtitle =>
      'I-track ang mastery, XP, quizzes, at consistency.';

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
    return '$count araw';
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
  String get progressNoBadgesTitle => 'Wala pang badges';

  @override
  String get progressNoBadgesMessage =>
      'Tapusin ang iyong unang lesson at quiz para makakuha ng badges.';

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
  String get profileNoBadgesTitle => 'Wala pang badges';

  @override
  String get profileNoBadgesMessage =>
      'Tapusin ang lessons at quizzes para ma-unlock ang badges.';

  @override
  String get profileUpdateName => 'I-update ang Pangalan';

  @override
  String get profileNameHint => 'Ilagay ang iyong display name';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeSubtitle =>
      'I-enable ang dark theme para sa gabiang pag-aaral.';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Simpleng reminder toggle (local lang).';

  @override
  String get settingsLanguage => 'Wika';

  @override
  String get settingsLanguageSubtitle =>
      'Piliin ang wika ng app labels at instructions.';

  @override
  String get settingsProgressControls => 'Progress Controls';

  @override
  String get settingsProgressDescription =>
      'Ang reset ay maglilinis ng lessons, quizzes, XP, streak, at badges. Mananatili ang theme at onboarding.';

  @override
  String get settingsResetProgress => 'Reset Progress';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAboutDescription =>
      'Offline-first learning app para sa incoming IT freshmen. Walang login at backend, local guided progression lang.';

  @override
  String get settingsResetDialogTitle => 'I-reset ang Progress?';

  @override
  String get settingsResetDialogMessage =>
      'Mawawala ang iyong completed lessons, quizzes, XP, at badges.';

  @override
  String get settingsResetSuccess => 'Matagumpay na na-reset ang progress.';

  @override
  String get lessonCodeExampleTitle => 'Code Example';

  @override
  String get lessonBriefExplanationTitle => 'Maikling Paliwanag';

  @override
  String get lessonExpectedOutputTitle => 'Expected Output';

  @override
  String get lessonProgressStepTitle => 'Tapusin ang Step na Ito';

  @override
  String get lessonPracticeButton => 'Practice';

  @override
  String get lessonNextLessonButton => 'Susunod na Lesson';

  @override
  String get lessonFinishPathButton => 'Balik sa Roadmap';

  @override
  String get lessonNextLocked =>
      'Kailangan munang pumasa sa quiz para ma-unlock ang susunod na lesson.';

  @override
  String playgroundTitle(Object lessonTitle) {
    return 'Practice: $lessonTitle';
  }

  @override
  String get playgroundIntro =>
      'I-edit ang starter code at i-run agad para makita ang output.';

  @override
  String get playgroundStarterHint =>
      'Tip: Isang maliit na pagbabago bawat run para mas madaling matuto.';

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
  String get lessonL11Title => 'Ano ang Programming?';

  @override
  String get lessonL11Intro =>
      'Ang programming ay pagbibigay ng instructions sa computer.';

  @override
  String get lessonL11Output =>
      'Malinaw na sunod-sunod na steps para sa isang simpleng task.';

  @override
  String get lessonL12Title => 'Logic at Algorithms';

  @override
  String get lessonL12Intro =>
      'Ang algorithm ay nakaayos na steps sa pag-solve ng problema.';

  @override
  String get lessonL12Output =>
      'Isang flow na may malinaw na input, check, at output.';

  @override
  String get lessonL21Title => 'HTML Structure at Tags';

  @override
  String get lessonL21Intro =>
      'Ang HTML ang naglalagay ng structure ng web page.';

  @override
  String get lessonL21Output =>
      'Page na may heading at paragraph sa tamang structure.';

  @override
  String get lessonL22Title => 'Links, Images, Lists, Forms';

  @override
  String get lessonL22Intro =>
      'Ang core HTML elements ang nagpapagana at nagpapalinaw ng page.';

  @override
  String get lessonL22Output =>
      'Page na may link, list, at basic form elements.';

  @override
  String get lessonL31Title => 'CSS Syntax at Selectors';

  @override
  String get lessonL31Intro =>
      'Ang CSS ang nagkokontrol ng visual style ng page.';

  @override
  String get lessonL31Output =>
      'Parehong HTML pero may customized colors at spacing.';

  @override
  String get lessonL32Title => 'Flexbox at Responsive Basics';

  @override
  String get lessonL32Intro =>
      'Dapat umaangkop ang layout sa iba\'t ibang screen sizes.';

  @override
  String get lessonL32Output =>
      'Mas maayos na alignment at responsive behavior ng elements.';

  @override
  String get lessonL41Title => 'Variables, Conditions, at Loops';

  @override
  String get lessonL41Intro =>
      'Ang JavaScript ang nagdadagdag ng logic at behavior sa page.';

  @override
  String get lessonL41Output =>
      'Interactive output na nagbabago ayon sa code logic.';

  @override
  String get lessonL42Title => 'Functions, Arrays, at Objects';

  @override
  String get lessonL42Intro =>
      'I-organize ang logic at data gamit reusable patterns.';

  @override
  String get lessonL42Output =>
      'Structured output mula sa arrays, objects, at functions.';

  @override
  String get lessonL51Title => 'Bootstrap Layout Basics';

  @override
  String get lessonL51Intro =>
      'Gamitin ang framework classes para mas mabilis na layout.';

  @override
  String get lessonL51Output =>
      'Isang simpleng grid page na may reusable sections.';

  @override
  String get lessonL52Title => 'React Component Basics';

  @override
  String get lessonL52Intro =>
      'Hatiin ang UI sa reusable components at data passing.';

  @override
  String get lessonL52Output =>
      'Reusable component cards na ginawa mula sa isang function.';

  @override
  String get lessonL53Title => 'Vue at Angular Core Patterns';

  @override
  String get lessonL53Intro =>
      'Matutunan ang binding, components, at module structure.';

  @override
  String get lessonL53Output =>
      'Live output na nag-a-update mula sa input at event logic.';

  @override
  String get lessonL71Title => 'Clean Code at Reusability';

  @override
  String get lessonL71Intro =>
      'Mas madaling i-maintain ang code kapag malinaw at reusable ito.';

  @override
  String get lessonL71Output =>
      'Reusable component-style section mula sa reusable logic.';

  @override
  String get lessonL72Title => 'API Intro at JSON Basics';

  @override
  String get lessonL72Intro =>
      'Nagpapalitan ng structured data ang apps gamit ang APIs.';

  @override
  String get lessonL72Output =>
      'JSON-like data na malinaw at madaling basahin.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageBisaya => 'Bisaya';

  @override
  String get languageFilipino => 'Filipino';

  @override
  String get quote0 => 'Ang bawat expert ay nagsimula sa isang linya ng code.';

  @override
  String get quote1 =>
      'Mas mahusay ang maliit na progreso araw-araw kaysa sa bihirang malaking effort.';

  @override
  String get quote2 => 'Pinapatalas ng debugging ang mindset ng developer.';

  @override
  String get quote3 => 'Linaw muna bago cleverness.';

  @override
  String get quote4 =>
      'Gumawa ng maliit, tapusin nang maayos, saka mag-level up.';

  @override
  String get quote5 =>
      'Ang consistency ang gumagawa sa beginners na maging builders.';

  @override
  String get quote6 => 'Ang susunod mong lesson ay susunod mong breakthrough.';

  @override
  String get badgeFirstStep => 'Unang Hakbang';

  @override
  String get badgeQuizStarter => 'Quiz Starter';

  @override
  String get badgePracticeExplorer => 'Practice Explorer';

  @override
  String get badgeMomentumCoder => 'Momentum Coder';

  @override
  String badgeLevelCleared(int level) {
    return 'Tapos na ang Level $level';
  }

  @override
  String get badgeExpertTrailblazer => 'Expert Trailblazer';
}
