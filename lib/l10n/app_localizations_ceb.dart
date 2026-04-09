// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Cebuano (`ceb`).
class AppLocalizationsCeb extends AppLocalizations {
  AppLocalizationsCeb([String locale = 'ceb']) : super(locale);

  @override
  String get appName => 'Jay2xCoder';

  @override
  String get appSubtitle => 'Kat-ona ang Programming Hinay-hinay';

  @override
  String get navHome => 'Balay';

  @override
  String get navRoadmap => 'Roadmap';

  @override
  String get navIde => 'IDE';

  @override
  String get navProgress => 'Progreso';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String get commonContinue => 'Padayon';

  @override
  String get commonSkip => 'Laktawi';

  @override
  String get commonCancel => 'Kansela';

  @override
  String get commonSave => 'I-save';

  @override
  String get commonReset => 'I-reset';

  @override
  String get commonSearch => 'Pangita';

  @override
  String homeWelcome(Object name) {
    return 'Maayong pag-abot, $name';
  }

  @override
  String get homeSubtitle => 'Padayon sa imong coding journey.';

  @override
  String get homeCurrentLevel => 'Karon nga Level';

  @override
  String homeLevelTitle(int level, Object title) {
    return 'Level $level: $title';
  }

  @override
  String homeOverallProgress(int percent) {
    return 'Kinatibuk-ang progreso $percent%';
  }

  @override
  String get homeViewRoadmap => 'Tan-awa ang Roadmap';

  @override
  String get homeContinueLearning => 'Padayon sa Pagkat-on';

  @override
  String get homeRoadmapPreview => 'Roadmap Preview';

  @override
  String get homeDailyMotivation => 'Adlaw-adlaw nga Inspirasyon';

  @override
  String get homeRecentBadge => 'Pinakabag-ong Badge';

  @override
  String get homeNoBadgeYet =>
      'Humana ang imong unang lesson aron makakuha og badge.';

  @override
  String get homeBookmarkedLessons => 'Mga Na-save nga Lesson';

  @override
  String homeBookmarkedCount(int count) {
    return '$count ka lesson ang na-save';
  }

  @override
  String get onboardingTitle1 => 'Welcome sa Jay2xCoder';

  @override
  String get onboardingMessage1 =>
      'Giya nga coding journey para sa incoming IT freshmen.';

  @override
  String get onboardingTitle2 => 'Hinay-hinay nga Pagkat-on';

  @override
  String get onboardingMessage2 =>
      'Sugdi sa basics, pasar sa quizzes, ug i-unlock ang mas taas nga level.';

  @override
  String get onboardingTitle3 => 'Praktis sa Essentials';

  @override
  String get onboardingMessage3 =>
      'Lightweight nga activities: arrange code, pangitaa ang bug, ug match concepts.';

  @override
  String get onboardingTitle4 => 'Pabiling Focused';

  @override
  String get onboardingMessage4 =>
      'Subaya ang XP, badges, ug progreso pinaagi sa offline-friendly dashboard.';

  @override
  String get onboardingStartLearning => 'Sugdi ang Pagkat-on';

  @override
  String get roadmapTitle => 'Learning Roadmap';

  @override
  String get roadmapSubtitle =>
      'I-unlock ang kada level hangtod sa expert path.';

  @override
  String get roadmapSearchHint => 'Pangita og lesson o level';

  @override
  String get roadmapFavoritesOnly => 'Paborito ra';

  @override
  String get roadmapNoResultsTitle => 'Walay tugma nga lessons';

  @override
  String get roadmapNoResultsMessage =>
      'Sulayi ug lain nga keyword o tangtanga ang filters.';

  @override
  String get roadmapLockedSnack => 'Humana una ang current lesson ug quiz.';

  @override
  String get lessonTitle => 'Lesson';

  @override
  String lessonAppBar(int level, int lesson) {
    return 'Level $level Lesson $lesson';
  }

  @override
  String get lessonMissingTitle => 'Wala Makita ang Lesson';

  @override
  String get lessonMissingMessage =>
      'Wala makita ang lesson sa local mock data.';

  @override
  String get lessonLockedTitle => 'Locked ang Lesson';

  @override
  String get lessonLockedMessage =>
      'Humana ang previous lesson ug pasar sa quiz una.';

  @override
  String get lessonExplanation => 'Pagpasabot';

  @override
  String get lessonSimpleExample => 'Yano nga Pananglitan';

  @override
  String get lessonKeyTakeaways => 'Importanteng Takeaways';

  @override
  String get lessonMiniActivity => 'Mini Activity';

  @override
  String get lessonCompletedMessage => 'Nahuman ang lesson. Maayo kaayo!';

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
      'Human sa practice, tubaga kining yano nga quiz aron ma-check ang imong pagsabot.';

  @override
  String get lessonPracticeActivity => 'Practice Activity';

  @override
  String get lessonBookmarkAdded => 'Na-add ang lesson sa bookmarks.';

  @override
  String get lessonBookmarkRemoved => 'Natangtang ang lesson sa bookmarks.';

  @override
  String get quizTitle => 'Quiz';

  @override
  String get quizLessonTitle => 'Lesson Quiz';

  @override
  String get quizNotFoundTitle => 'Wala Makita ang Quiz';

  @override
  String get quizNotFoundMessage =>
      'Walay local quiz data para ani nga lesson.';

  @override
  String quizPassedBanner(int score) {
    return 'Passed! Score: $score%. Na-unlock na ang sunod nga lesson.';
  }

  @override
  String quizFailedBanner(int score, int required) {
    return 'Score: $score%. Kinahanglan $required% aron makapasar.';
  }

  @override
  String quizQuestionTypeLabel(int number, Object type) {
    return 'Q$number · $type';
  }

  @override
  String quizExplanationPrefix(Object text) {
    return 'Pagpasabot: $text';
  }

  @override
  String get quizBackToLesson => 'Balik sa Lesson';

  @override
  String get quizRetry => 'Balika ang Quiz';

  @override
  String get quizSubmit => 'I-submit ang Quiz';

  @override
  String get quizSubmitAnswer => 'I-submit ang Tubag';

  @override
  String get quizShowAnswer => 'Ipakita ang Tubag';

  @override
  String get quizNext => 'Sunod nga Pangutana';

  @override
  String get quizFinish => 'Tapusa ang Quiz';

  @override
  String get quizNextLesson => 'Sunod nga Lesson';

  @override
  String get quizCorrectLabel => 'Sakto nga tubag';

  @override
  String get quizIncorrectLabel => 'Dili pa sakto';

  @override
  String quizQuestionProgress(int current, int total) {
    return 'Pangutana $current sa $total';
  }

  @override
  String quizScoreSummary(int score) {
    return 'Katapusan nga Score: $score%';
  }

  @override
  String quizCorrectAnswerLabel(Object answer) {
    return 'Sakto nga tubag: $answer';
  }

  @override
  String get quizSelectAnswerSnack => 'Pili una og tubag.';

  @override
  String get quizAnswerAllSnack => 'Tubaga una ang tanang pangutana.';

  @override
  String get quizTypeMultipleChoice => 'Multiple Choice';

  @override
  String get quizTypeTrueFalse => 'True o False';

  @override
  String get quizTypePredictOutput => 'Tag-ana ang Output';

  @override
  String get quizTypeIdentification => 'Identification';

  @override
  String get quizTypeCodeMeaning => 'Kahulugan sa Code';

  @override
  String get practiceTitle => 'Praktis';

  @override
  String get practiceActivityTitle => 'Practice Activity';

  @override
  String get practiceMissingTitle => 'Wala ang Praktis';

  @override
  String get practiceMissingLessonMessage =>
      'Kini nga lesson walay practice data.';

  @override
  String get practiceMissingLevelMessage =>
      'Walay practice set para ani nga level.';

  @override
  String practicePassedMessage(int score) {
    return 'Maayo! Nahuman ang practice ($score/3).';
  }

  @override
  String practiceFailedMessage(int score) {
    return 'Score sa practice: $score/3. Reviewhi ug sulayi pag-usab.';
  }

  @override
  String get practiceArrangeCode => '1) Arrange Code Order';

  @override
  String get practiceFindBug => '2) Pangitaa ang Bug';

  @override
  String get practiceMatchConcept => '3) I-match ang Concept ug Kahulugan';

  @override
  String get practiceRetry => 'Balika ang Praktis';

  @override
  String get practiceSubmit => 'I-submit ang Praktis';

  @override
  String get ideTitle => 'Code IDE';

  @override
  String get ideSubtitle => 'Diretsong coding practice gamit templates.';

  @override
  String get ideHint => 'Pili og template, usba ang code, unya i-run dayon.';

  @override
  String get ideOpenButton => 'Ablihi';

  @override
  String get ideNoTemplatesTitle => 'Wala pay IDE templates';

  @override
  String get ideNoTemplatesMessage =>
      'Pagdugang og templates aron makasugod kag code diri.';

  @override
  String get ideHtmlStarterTitle => 'HTML Starter';

  @override
  String get ideHtmlStarterSubtitle => 'Basic page structure ug semantic tags.';

  @override
  String get ideCssStarterTitle => 'CSS Starter';

  @override
  String get ideCssStarterSubtitle => 'Style, spacing, ug limpyo nga layout.';

  @override
  String get ideJsStarterTitle => 'JavaScript Starter';

  @override
  String get ideJsStarterSubtitle => 'Variables, functions, ug interaction.';

  @override
  String get ideFrameworkStarterTitle => 'Framework Layout';

  @override
  String get ideFrameworkStarterSubtitle =>
      'Bootstrap-style grid ug reusable layout.';

  @override
  String get ideReactStarterTitle => 'React-style Components';

  @override
  String get ideReactStarterSubtitle =>
      'Himoa ang reusable component patterns.';

  @override
  String get ideProjectStarterTitle => 'Framework Project Flow';

  @override
  String get ideProjectStarterSubtitle =>
      'Binding, events, ug modular mindset.';

  @override
  String get progressTitle => 'Learning Progress';

  @override
  String get progressSubtitle =>
      'Subaya ang mastery, XP, quizzes, ug consistency.';

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
    return '$count ka adlaw';
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
  String get progressNoBadgesTitle => 'Wala pay badges';

  @override
  String get progressNoBadgesMessage =>
      'Humana ang imong unang lesson ug quiz aron makasugod og badges.';

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
  String get profileNoBadgesTitle => 'Wala pay badges';

  @override
  String get profileNoBadgesMessage =>
      'Humana ang lessons ug quizzes aron ma-unlock ang badges.';

  @override
  String get profileUpdateName => 'Usba ang Ngalan';

  @override
  String get profileNameHint => 'Ibutang imong display name';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeSubtitle =>
      'I-enable ang dark theme para sa gabii nga pagtuon.';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Simple reminder toggle (local ra).';

  @override
  String get settingsLanguage => 'Pinulongan';

  @override
  String get settingsLanguageSubtitle =>
      'Pilia ang pinulongan sa app labels ug instructions.';

  @override
  String get settingsProgressControls => 'Progress Controls';

  @override
  String get settingsProgressDescription =>
      'Ang reset mag-clear sa lessons, quizzes, XP, streak, ug badges. Mahabilin ang theme ug onboarding.';

  @override
  String get settingsResetProgress => 'Reset Progress';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAboutDescription =>
      'Offline-first nga learning app para sa incoming IT freshmen. Walay login ug backend, local guided progression ra.';

  @override
  String get settingsResetDialogTitle => 'I-reset ang Progress?';

  @override
  String get settingsResetDialogMessage =>
      'Mawagtang ang imong completed lessons, quizzes, XP, ug badges.';

  @override
  String get settingsResetSuccess => 'Na-reset na ang progress.';

  @override
  String get lessonCodeExampleTitle => 'Code Example';

  @override
  String get lessonBriefExplanationTitle => 'Mubo nga Pagpasabot';

  @override
  String get lessonExpectedOutputTitle => 'Expected Output';

  @override
  String get lessonProgressStepTitle => 'Humanon Kini nga Step';

  @override
  String get lessonPracticeButton => 'Practice';

  @override
  String get lessonNextLessonButton => 'Sunod nga Lesson';

  @override
  String get lessonFinishPathButton => 'Balik sa Roadmap';

  @override
  String get lessonNextLocked =>
      'Kinahanglan una makapasar sa quiz aron ma-unlock ang sunod nga lesson.';

  @override
  String playgroundTitle(Object lessonTitle) {
    return 'Practice: $lessonTitle';
  }

  @override
  String get playgroundIntro =>
      'Usba ang starter code ug i-run dayon para makita ang output.';

  @override
  String get playgroundStarterHint =>
      'Tip: Usa ka linya sa matag higayon. Run ug tan-awa ang epekto.';

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
  String get lessonL11Title => 'Unsa ang Programming?';

  @override
  String get lessonL11Intro =>
      'Ang programming naghatag ug instruksyon sa computer.';

  @override
  String get lessonL11Output =>
      'Tin-aw nga sunod-sunod nga steps aron masulbad ang usa ka buluhaton.';

  @override
  String get lessonL12Title => 'Logic ug Algorithms';

  @override
  String get lessonL12Intro =>
      'Ang algorithm kay han-ay nga steps sa pagsulbad sa problema.';

  @override
  String get lessonL12Output =>
      'Usa ka flow nga naay klaro nga input-check-output.';

  @override
  String get lessonL21Title => 'HTML Structure ug Tags';

  @override
  String get lessonL21Intro => 'Ang HTML nagtakda sa istruktura sa web page.';

  @override
  String get lessonL21Output =>
      'Page nga naay heading ug paragraph sa sakto nga structure.';

  @override
  String get lessonL22Title => 'Links, Images, Lists, Forms';

  @override
  String get lessonL22Intro =>
      'Ang core HTML elements naghimo sa page nga mas mapuslanon.';

  @override
  String get lessonL22Output =>
      'Page nga naay link, list, ug basic form elements.';

  @override
  String get lessonL31Title => 'CSS Syntax ug Selectors';

  @override
  String get lessonL31Intro =>
      'Ang CSS nagkontrol sa visual nga porma sa page.';

  @override
  String get lessonL31Output =>
      'Parehong HTML pero naay customized colors ug spacing.';

  @override
  String get lessonL32Title => 'Flexbox ug Responsive Basics';

  @override
  String get lessonL32Intro =>
      'Ang layout dapat mo-angay sa lain-laing screen size.';

  @override
  String get lessonL32Output =>
      'Maayo nga alignment sa elements ug mas responsive nga layout.';

  @override
  String get lessonL41Title => 'Variables, Conditions, ug Loops';

  @override
  String get lessonL41Intro =>
      'Ang JavaScript nagdugang ug logic ug behavior sa page.';

  @override
  String get lessonL41Output =>
      'Interactive output nga mausab base sa code logic.';

  @override
  String get lessonL42Title => 'Functions, Arrays, ug Objects';

  @override
  String get lessonL42Intro =>
      'I-organize ang logic ug data gamit reusable patterns.';

  @override
  String get lessonL42Output =>
      'Structured output gikan sa arrays, objects, ug functions.';

  @override
  String get lessonL51Title => 'Bootstrap Layout Basics';

  @override
  String get lessonL51Intro =>
      'Gamita ang framework classes para paspas nga layout.';

  @override
  String get lessonL51Output =>
      'Usa ka yano nga grid page nga naay reusable sections.';

  @override
  String get lessonL52Title => 'React Component Basics';

  @override
  String get lessonL52Intro =>
      'Bahina ang UI sa reusable components ug data passing.';

  @override
  String get lessonL52Output =>
      'Reusable component cards nga gi-render gikan sa usa ka function.';

  @override
  String get lessonL53Title => 'Vue ug Angular Core Patterns';

  @override
  String get lessonL53Intro =>
      'Kat-oni ang binding, components, ug module structure.';

  @override
  String get lessonL53Output =>
      'Live output nga mausab base sa input ug event logic.';

  @override
  String get lessonL71Title => 'Clean Code ug Reusability';

  @override
  String get lessonL71Intro =>
      'Mas dali i-scale ang code kung klaro ug limpyo kini.';

  @override
  String get lessonL71Output =>
      'Reusable component-style section nga gihimo sa reusable logic.';

  @override
  String get lessonL72Title => 'API Intro ug JSON Basics';

  @override
  String get lessonL72Intro =>
      'Ang apps nagbaylo ug structured data pinaagi sa APIs.';

  @override
  String get lessonL72Output =>
      'JSON-like data nga gipakita sa masabtan nga porma.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageBisaya => 'Bisaya';

  @override
  String get languageFilipino => 'Filipino';

  @override
  String get quote0 => 'Ang matag expert nagsugod sa usa ka linya sa code.';

  @override
  String get quote1 =>
      'Ang gamay nga progress adlaw-adlaw mas maayo kaysa panagsa nga dako.';

  @override
  String get quote2 => 'Ang debugging makaligon sa mindset sa developer.';

  @override
  String get quote3 => 'Klaro una, cleverness sunod.';

  @override
  String get quote4 => 'Build gamay, humani ug tarong, dayon level up.';

  @override
  String get quote5 =>
      'Ang consistency mohimo og beginners nga mahimong builders.';

  @override
  String get quote6 =>
      'Ang sunod nimong lesson mao ang sunod nimong breakthrough.';

  @override
  String get badgeFirstStep => 'Unang Lakang';

  @override
  String get badgeQuizStarter => 'Quiz Starter';

  @override
  String get badgePracticeExplorer => 'Practice Explorer';

  @override
  String get badgeMomentumCoder => 'Momentum Coder';

  @override
  String badgeLevelCleared(int level) {
    return 'Nahuman ang Level $level';
  }

  @override
  String get badgeExpertTrailblazer => 'Expert Trailblazer';
}
