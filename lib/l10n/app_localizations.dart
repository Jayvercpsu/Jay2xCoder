import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ceb.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fil.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ceb'),
    Locale('en'),
    Locale('fil'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Jay2xCoder'**
  String get appName;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Programming Step by Step'**
  String get appSubtitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navRoadmap.
  ///
  /// In en, this message translates to:
  /// **'Roadmap'**
  String get navRoadmap;

  /// No description provided for @navIde.
  ///
  /// In en, this message translates to:
  /// **'IDE'**
  String get navIde;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get commonReset;

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String homeWelcome(Object name);

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep climbing your coding journey.'**
  String get homeSubtitle;

  /// No description provided for @homeCurrentLevel.
  ///
  /// In en, this message translates to:
  /// **'Current Level'**
  String get homeCurrentLevel;

  /// No description provided for @homeLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Level {level}: {title}'**
  String homeLevelTitle(int level, Object title);

  /// No description provided for @homeOverallProgress.
  ///
  /// In en, this message translates to:
  /// **'Overall progress {percent}%'**
  String homeOverallProgress(int percent);

  /// No description provided for @homeViewRoadmap.
  ///
  /// In en, this message translates to:
  /// **'View Roadmap'**
  String get homeViewRoadmap;

  /// No description provided for @homeContinueLearning.
  ///
  /// In en, this message translates to:
  /// **'Continue Learning'**
  String get homeContinueLearning;

  /// No description provided for @homeRoadmapPreview.
  ///
  /// In en, this message translates to:
  /// **'Roadmap Preview'**
  String get homeRoadmapPreview;

  /// No description provided for @homeDailyMotivation.
  ///
  /// In en, this message translates to:
  /// **'Daily Motivation'**
  String get homeDailyMotivation;

  /// No description provided for @homeRecentBadge.
  ///
  /// In en, this message translates to:
  /// **'Recent Badge'**
  String get homeRecentBadge;

  /// No description provided for @homeNoBadgeYet.
  ///
  /// In en, this message translates to:
  /// **'Complete your first lesson to earn a badge.'**
  String get homeNoBadgeYet;

  /// No description provided for @homeBookmarkedLessons.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked Lessons'**
  String get homeBookmarkedLessons;

  /// No description provided for @homeBookmarkedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} saved lesson(s)'**
  String homeBookmarkedCount(int count);

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Jay2xCoder'**
  String get onboardingTitle1;

  /// No description provided for @onboardingMessage1.
  ///
  /// In en, this message translates to:
  /// **'A guided coding journey built for incoming IT freshmen.'**
  String get onboardingMessage1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Learn Step by Step'**
  String get onboardingTitle2;

  /// No description provided for @onboardingMessage2.
  ///
  /// In en, this message translates to:
  /// **'Start from basics, pass quizzes, and unlock higher levels gradually.'**
  String get onboardingMessage2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Practice the Essentials'**
  String get onboardingTitle3;

  /// No description provided for @onboardingMessage3.
  ///
  /// In en, this message translates to:
  /// **'Use lightweight activities: arrange code, find bugs, and match concepts.'**
  String get onboardingMessage3;

  /// No description provided for @onboardingTitle4.
  ///
  /// In en, this message translates to:
  /// **'Stay Focused'**
  String get onboardingTitle4;

  /// No description provided for @onboardingMessage4.
  ///
  /// In en, this message translates to:
  /// **'Track XP, badges, and progress with an offline-friendly learning dashboard.'**
  String get onboardingMessage4;

  /// No description provided for @onboardingStartLearning.
  ///
  /// In en, this message translates to:
  /// **'Start Learning'**
  String get onboardingStartLearning;

  /// No description provided for @roadmapTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning Roadmap'**
  String get roadmapTitle;

  /// No description provided for @roadmapSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock each level step by step until expert path.'**
  String get roadmapSubtitle;

  /// No description provided for @roadmapSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search lessons or levels'**
  String get roadmapSearchHint;

  /// No description provided for @roadmapFavoritesOnly.
  ///
  /// In en, this message translates to:
  /// **'Favorites only'**
  String get roadmapFavoritesOnly;

  /// No description provided for @roadmapNoResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No matching lessons'**
  String get roadmapNoResultsTitle;

  /// No description provided for @roadmapNoResultsMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a different keyword or clear filters.'**
  String get roadmapNoResultsMessage;

  /// No description provided for @roadmapLockedSnack.
  ///
  /// In en, this message translates to:
  /// **'Complete current lesson and quiz first.'**
  String get roadmapLockedSnack;

  /// No description provided for @lessonTitle.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get lessonTitle;

  /// No description provided for @lessonAppBar.
  ///
  /// In en, this message translates to:
  /// **'Level {level} Lesson {lesson}'**
  String lessonAppBar(int level, int lesson);

  /// No description provided for @lessonMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Lesson Missing'**
  String get lessonMissingTitle;

  /// No description provided for @lessonMissingMessage.
  ///
  /// In en, this message translates to:
  /// **'This lesson could not be found in local mock data.'**
  String get lessonMissingMessage;

  /// No description provided for @lessonLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Lesson Locked'**
  String get lessonLockedTitle;

  /// No description provided for @lessonLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete the previous lesson and pass its quiz first.'**
  String get lessonLockedMessage;

  /// No description provided for @lessonExplanation.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get lessonExplanation;

  /// No description provided for @lessonSimpleExample.
  ///
  /// In en, this message translates to:
  /// **'Simple Example'**
  String get lessonSimpleExample;

  /// No description provided for @lessonKeyTakeaways.
  ///
  /// In en, this message translates to:
  /// **'Key Takeaways'**
  String get lessonKeyTakeaways;

  /// No description provided for @lessonMiniActivity.
  ///
  /// In en, this message translates to:
  /// **'Mini Activity'**
  String get lessonMiniActivity;

  /// No description provided for @lessonCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Lesson completed. Great job!'**
  String get lessonCompletedMessage;

  /// No description provided for @lessonMarkAsComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as Complete'**
  String get lessonMarkAsComplete;

  /// No description provided for @lessonQuizPassed.
  ///
  /// In en, this message translates to:
  /// **'Quiz Passed'**
  String get lessonQuizPassed;

  /// No description provided for @lessonTakeQuiz.
  ///
  /// In en, this message translates to:
  /// **'Take Quiz'**
  String get lessonTakeQuiz;

  /// No description provided for @lessonQuizSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Checkpoint'**
  String get lessonQuizSectionTitle;

  /// No description provided for @lessonQuizSectionHint.
  ///
  /// In en, this message translates to:
  /// **'After practice, take this simple quiz to check your understanding.'**
  String get lessonQuizSectionHint;

  /// No description provided for @lessonPracticeActivity.
  ///
  /// In en, this message translates to:
  /// **'Practice Activity'**
  String get lessonPracticeActivity;

  /// No description provided for @lessonBookmarkAdded.
  ///
  /// In en, this message translates to:
  /// **'Lesson added to bookmarks.'**
  String get lessonBookmarkAdded;

  /// No description provided for @lessonBookmarkRemoved.
  ///
  /// In en, this message translates to:
  /// **'Lesson removed from bookmarks.'**
  String get lessonBookmarkRemoved;

  /// No description provided for @quizTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quizTitle;

  /// No description provided for @quizLessonTitle.
  ///
  /// In en, this message translates to:
  /// **'Lesson Quiz'**
  String get quizLessonTitle;

  /// No description provided for @quizNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Not Found'**
  String get quizNotFoundTitle;

  /// No description provided for @quizNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'No local quiz data is available for this lesson.'**
  String get quizNotFoundMessage;

  /// No description provided for @quizPassedBanner.
  ///
  /// In en, this message translates to:
  /// **'Passed! Score: {score}%. Next lesson unlocked.'**
  String quizPassedBanner(int score);

  /// No description provided for @quizFailedBanner.
  ///
  /// In en, this message translates to:
  /// **'Score: {score}%. Need {required}% to pass.'**
  String quizFailedBanner(int score, int required);

  /// No description provided for @quizQuestionTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Q{number} · {type}'**
  String quizQuestionTypeLabel(int number, Object type);

  /// No description provided for @quizExplanationPrefix.
  ///
  /// In en, this message translates to:
  /// **'Explanation: {text}'**
  String quizExplanationPrefix(Object text);

  /// No description provided for @quizBackToLesson.
  ///
  /// In en, this message translates to:
  /// **'Back to Lesson'**
  String get quizBackToLesson;

  /// No description provided for @quizRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry Quiz'**
  String get quizRetry;

  /// No description provided for @quizSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Quiz'**
  String get quizSubmit;

  /// No description provided for @quizSubmitAnswer.
  ///
  /// In en, this message translates to:
  /// **'Submit Answer'**
  String get quizSubmitAnswer;

  /// No description provided for @quizShowAnswer.
  ///
  /// In en, this message translates to:
  /// **'Show Answer'**
  String get quizShowAnswer;

  /// No description provided for @quizNext.
  ///
  /// In en, this message translates to:
  /// **'Next Question'**
  String get quizNext;

  /// No description provided for @quizFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish Quiz'**
  String get quizFinish;

  /// No description provided for @quizNextLesson.
  ///
  /// In en, this message translates to:
  /// **'Next Lesson'**
  String get quizNextLesson;

  /// No description provided for @quizCorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct answer'**
  String get quizCorrectLabel;

  /// No description provided for @quizIncorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Not quite right'**
  String get quizIncorrectLabel;

  /// No description provided for @quizQuestionProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String quizQuestionProgress(int current, int total);

  /// No description provided for @quizScoreSummary.
  ///
  /// In en, this message translates to:
  /// **'Final Score: {score}%'**
  String quizScoreSummary(int score);

  /// No description provided for @quizCorrectAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct answer: {answer}'**
  String quizCorrectAnswerLabel(Object answer);

  /// No description provided for @quizSelectAnswerSnack.
  ///
  /// In en, this message translates to:
  /// **'Please select an answer first.'**
  String get quizSelectAnswerSnack;

  /// No description provided for @quizAnswerAllSnack.
  ///
  /// In en, this message translates to:
  /// **'Please answer all questions first.'**
  String get quizAnswerAllSnack;

  /// No description provided for @quizTypeMultipleChoice.
  ///
  /// In en, this message translates to:
  /// **'Multiple Choice'**
  String get quizTypeMultipleChoice;

  /// No description provided for @quizTypeTrueFalse.
  ///
  /// In en, this message translates to:
  /// **'True or False'**
  String get quizTypeTrueFalse;

  /// No description provided for @quizTypePredictOutput.
  ///
  /// In en, this message translates to:
  /// **'Predict Output'**
  String get quizTypePredictOutput;

  /// No description provided for @quizTypeIdentification.
  ///
  /// In en, this message translates to:
  /// **'Identification'**
  String get quizTypeIdentification;

  /// No description provided for @quizTypeCodeMeaning.
  ///
  /// In en, this message translates to:
  /// **'Code Meaning'**
  String get quizTypeCodeMeaning;

  /// No description provided for @practiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practiceTitle;

  /// No description provided for @practiceActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice Activity'**
  String get practiceActivityTitle;

  /// No description provided for @practiceMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice Missing'**
  String get practiceMissingTitle;

  /// No description provided for @practiceMissingLessonMessage.
  ///
  /// In en, this message translates to:
  /// **'This lesson does not have practice data.'**
  String get practiceMissingLessonMessage;

  /// No description provided for @practiceMissingLevelMessage.
  ///
  /// In en, this message translates to:
  /// **'No practice set found for this level.'**
  String get practiceMissingLevelMessage;

  /// No description provided for @practicePassedMessage.
  ///
  /// In en, this message translates to:
  /// **'Great work. Practice cleared ({score}/3).'**
  String practicePassedMessage(int score);

  /// No description provided for @practiceFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Practice score: {score}/3. Review and try again.'**
  String practiceFailedMessage(int score);

  /// No description provided for @practiceArrangeCode.
  ///
  /// In en, this message translates to:
  /// **'1) Arrange Code Order'**
  String get practiceArrangeCode;

  /// No description provided for @practiceFindBug.
  ///
  /// In en, this message translates to:
  /// **'2) Find the Bug'**
  String get practiceFindBug;

  /// No description provided for @practiceMatchConcept.
  ///
  /// In en, this message translates to:
  /// **'3) Match Concept and Definition'**
  String get practiceMatchConcept;

  /// No description provided for @practiceRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry Practice'**
  String get practiceRetry;

  /// No description provided for @practiceSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Practice'**
  String get practiceSubmit;

  /// No description provided for @ideTitle.
  ///
  /// In en, this message translates to:
  /// **'Code IDE'**
  String get ideTitle;

  /// No description provided for @ideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Jump straight into coding practice templates.'**
  String get ideSubtitle;

  /// No description provided for @ideHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a template, edit code, then run output instantly.'**
  String get ideHint;

  /// No description provided for @ideOpenButton.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get ideOpenButton;

  /// No description provided for @ideNoTemplatesTitle.
  ///
  /// In en, this message translates to:
  /// **'No IDE templates yet'**
  String get ideNoTemplatesTitle;

  /// No description provided for @ideNoTemplatesMessage.
  ///
  /// In en, this message translates to:
  /// **'Add practice templates to start coding here.'**
  String get ideNoTemplatesMessage;

  /// No description provided for @ideHtmlStarterTitle.
  ///
  /// In en, this message translates to:
  /// **'HTML Starter'**
  String get ideHtmlStarterTitle;

  /// No description provided for @ideHtmlStarterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Basic page structure and semantic tags.'**
  String get ideHtmlStarterSubtitle;

  /// No description provided for @ideCssStarterTitle.
  ///
  /// In en, this message translates to:
  /// **'CSS Starter'**
  String get ideCssStarterTitle;

  /// No description provided for @ideCssStarterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Style, spacing, and clean visual layout.'**
  String get ideCssStarterSubtitle;

  /// No description provided for @ideJsStarterTitle.
  ///
  /// In en, this message translates to:
  /// **'JavaScript Starter'**
  String get ideJsStarterTitle;

  /// No description provided for @ideJsStarterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Variables, functions, and interaction.'**
  String get ideJsStarterSubtitle;

  /// No description provided for @ideFrameworkStarterTitle.
  ///
  /// In en, this message translates to:
  /// **'Framework Layout'**
  String get ideFrameworkStarterTitle;

  /// No description provided for @ideFrameworkStarterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bootstrap-like grid and reusable layout.'**
  String get ideFrameworkStarterSubtitle;

  /// No description provided for @ideReactStarterTitle.
  ///
  /// In en, this message translates to:
  /// **'React-style Components'**
  String get ideReactStarterTitle;

  /// No description provided for @ideReactStarterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Build reusable component patterns.'**
  String get ideReactStarterSubtitle;

  /// No description provided for @ideProjectStarterTitle.
  ///
  /// In en, this message translates to:
  /// **'Framework Project Flow'**
  String get ideProjectStarterTitle;

  /// No description provided for @ideProjectStarterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Binding, events, and modular mindset.'**
  String get ideProjectStarterSubtitle;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning Progress'**
  String get progressTitle;

  /// No description provided for @progressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track mastery, XP, quizzes, and consistency.'**
  String get progressSubtitle;

  /// No description provided for @progressMastery.
  ///
  /// In en, this message translates to:
  /// **'Mastery'**
  String get progressMastery;

  /// No description provided for @progressCurrentLevel.
  ///
  /// In en, this message translates to:
  /// **'Current Level'**
  String get progressCurrentLevel;

  /// No description provided for @progressXp.
  ///
  /// In en, this message translates to:
  /// **'XP'**
  String get progressXp;

  /// No description provided for @progressStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get progressStreak;

  /// No description provided for @progressDays.
  ///
  /// In en, this message translates to:
  /// **'{count} day(s)'**
  String progressDays(int count);

  /// No description provided for @progressLessonsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Lessons Completed'**
  String get progressLessonsCompleted;

  /// No description provided for @progressQuizzesPassed.
  ///
  /// In en, this message translates to:
  /// **'Quizzes Passed'**
  String get progressQuizzesPassed;

  /// No description provided for @progressPracticeCleared.
  ///
  /// In en, this message translates to:
  /// **'Practice Cleared'**
  String get progressPracticeCleared;

  /// No description provided for @progressAchievementBadges.
  ///
  /// In en, this message translates to:
  /// **'Achievement Badges'**
  String get progressAchievementBadges;

  /// No description provided for @progressNoBadgesTitle.
  ///
  /// In en, this message translates to:
  /// **'No badges yet'**
  String get progressNoBadgesTitle;

  /// No description provided for @progressNoBadgesMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete your first lesson and quiz to start earning badges.'**
  String get progressNoBadgesMessage;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileLearnerLine.
  ///
  /// In en, this message translates to:
  /// **'Level {level} Learner · {xp} XP'**
  String profileLearnerLine(int level, int xp);

  /// No description provided for @profileLearningSummary.
  ///
  /// In en, this message translates to:
  /// **'Learning Summary'**
  String get profileLearningSummary;

  /// No description provided for @profileCompletedLessons.
  ///
  /// In en, this message translates to:
  /// **'Completed Lessons'**
  String get profileCompletedLessons;

  /// No description provided for @profilePassedQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Passed Quizzes'**
  String get profilePassedQuizzes;

  /// No description provided for @profileCompletionPercent.
  ///
  /// In en, this message translates to:
  /// **'Profile Completion'**
  String get profileCompletionPercent;

  /// No description provided for @profileCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get profileCurrentStreak;

  /// No description provided for @profileAchievementBadges.
  ///
  /// In en, this message translates to:
  /// **'Achievement Badges'**
  String get profileAchievementBadges;

  /// No description provided for @profileNoBadgesTitle.
  ///
  /// In en, this message translates to:
  /// **'No badges yet'**
  String get profileNoBadgesTitle;

  /// No description provided for @profileNoBadgesMessage.
  ///
  /// In en, this message translates to:
  /// **'Finish lessons and quizzes to unlock badges.'**
  String get profileNoBadgesMessage;

  /// No description provided for @profileUpdateName.
  ///
  /// In en, this message translates to:
  /// **'Update Name'**
  String get profileUpdateName;

  /// No description provided for @profileNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your display name'**
  String get profileNameHint;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable a darker theme for night study.'**
  String get settingsDarkModeSubtitle;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep a simple reminder toggle (local only).'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose app language for labels and instructions.'**
  String get settingsLanguageSubtitle;

  /// No description provided for @settingsProgressControls.
  ///
  /// In en, this message translates to:
  /// **'Progress Controls'**
  String get settingsProgressControls;

  /// No description provided for @settingsProgressDescription.
  ///
  /// In en, this message translates to:
  /// **'Reset will clear lessons, quizzes, XP, streak, and badges. Theme and onboarding stay as-is.'**
  String get settingsProgressDescription;

  /// No description provided for @settingsResetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress'**
  String get settingsResetProgress;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsAboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Offline-first learning app for incoming IT freshmen. No login, no backend, just local guided progression.'**
  String get settingsAboutDescription;

  /// No description provided for @settingsResetDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress?'**
  String get settingsResetDialogTitle;

  /// No description provided for @settingsResetDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove your completed lessons, quizzes, XP, and badges.'**
  String get settingsResetDialogMessage;

  /// No description provided for @settingsResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Progress reset successfully.'**
  String get settingsResetSuccess;

  /// No description provided for @lessonCodeExampleTitle.
  ///
  /// In en, this message translates to:
  /// **'Code Example'**
  String get lessonCodeExampleTitle;

  /// No description provided for @lessonBriefExplanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Short Explanation'**
  String get lessonBriefExplanationTitle;

  /// No description provided for @lessonExpectedOutputTitle.
  ///
  /// In en, this message translates to:
  /// **'Expected Output'**
  String get lessonExpectedOutputTitle;

  /// No description provided for @lessonProgressStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete This Step'**
  String get lessonProgressStepTitle;

  /// No description provided for @lessonPracticeButton.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get lessonPracticeButton;

  /// No description provided for @lessonNextLessonButton.
  ///
  /// In en, this message translates to:
  /// **'Next Lesson'**
  String get lessonNextLessonButton;

  /// No description provided for @lessonFinishPathButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Roadmap'**
  String get lessonFinishPathButton;

  /// No description provided for @lessonNextLocked.
  ///
  /// In en, this message translates to:
  /// **'Pass the quiz first to unlock the next lesson.'**
  String get lessonNextLocked;

  /// No description provided for @playgroundTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice: {lessonTitle}'**
  String playgroundTitle(Object lessonTitle);

  /// No description provided for @playgroundIntro.
  ///
  /// In en, this message translates to:
  /// **'Edit the starter code, then run it to see output instantly.'**
  String get playgroundIntro;

  /// No description provided for @playgroundStarterHint.
  ///
  /// In en, this message translates to:
  /// **'Tip: Start small. Change one line, run, then observe output.'**
  String get playgroundStarterHint;

  /// No description provided for @playgroundOutputPreview.
  ///
  /// In en, this message translates to:
  /// **'Output Preview'**
  String get playgroundOutputPreview;

  /// No description provided for @playgroundRun.
  ///
  /// In en, this message translates to:
  /// **'Run'**
  String get playgroundRun;

  /// No description provided for @playgroundReload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get playgroundReload;

  /// No description provided for @playgroundRestart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get playgroundRestart;

  /// No description provided for @playgroundHtmlTab.
  ///
  /// In en, this message translates to:
  /// **'HTML'**
  String get playgroundHtmlTab;

  /// No description provided for @playgroundCssTab.
  ///
  /// In en, this message translates to:
  /// **'CSS'**
  String get playgroundCssTab;

  /// No description provided for @playgroundJsTab.
  ///
  /// In en, this message translates to:
  /// **'JavaScript'**
  String get playgroundJsTab;

  /// No description provided for @lessonL11Title.
  ///
  /// In en, this message translates to:
  /// **'What Is Programming?'**
  String get lessonL11Title;

  /// No description provided for @lessonL11Intro.
  ///
  /// In en, this message translates to:
  /// **'Programming gives instructions to computers.'**
  String get lessonL11Intro;

  /// No description provided for @lessonL11Output.
  ///
  /// In en, this message translates to:
  /// **'A clear set of ordered steps to solve one simple task.'**
  String get lessonL11Output;

  /// No description provided for @lessonL12Title.
  ///
  /// In en, this message translates to:
  /// **'Logic and Algorithms'**
  String get lessonL12Title;

  /// No description provided for @lessonL12Intro.
  ///
  /// In en, this message translates to:
  /// **'Algorithms are ordered problem-solving steps.'**
  String get lessonL12Intro;

  /// No description provided for @lessonL12Output.
  ///
  /// In en, this message translates to:
  /// **'A flow where input is checked and output is predictable.'**
  String get lessonL12Output;

  /// No description provided for @lessonL21Title.
  ///
  /// In en, this message translates to:
  /// **'HTML Structure and Tags'**
  String get lessonL21Title;

  /// No description provided for @lessonL21Intro.
  ///
  /// In en, this message translates to:
  /// **'HTML defines the structure of a web page.'**
  String get lessonL21Intro;

  /// No description provided for @lessonL21Output.
  ///
  /// In en, this message translates to:
  /// **'A page showing a heading and paragraph in correct structure.'**
  String get lessonL21Output;

  /// No description provided for @lessonL22Title.
  ///
  /// In en, this message translates to:
  /// **'Links, Images, Lists, Forms'**
  String get lessonL22Title;

  /// No description provided for @lessonL22Intro.
  ///
  /// In en, this message translates to:
  /// **'Core HTML elements make pages useful.'**
  String get lessonL22Intro;

  /// No description provided for @lessonL22Output.
  ///
  /// In en, this message translates to:
  /// **'A page with links, list items, and basic user input form elements.'**
  String get lessonL22Output;

  /// No description provided for @lessonL31Title.
  ///
  /// In en, this message translates to:
  /// **'CSS Syntax and Selectors'**
  String get lessonL31Title;

  /// No description provided for @lessonL31Intro.
  ///
  /// In en, this message translates to:
  /// **'CSS controls visual style and appearance.'**
  String get lessonL31Intro;

  /// No description provided for @lessonL31Output.
  ///
  /// In en, this message translates to:
  /// **'The same HTML appears with custom colors, spacing, and style.'**
  String get lessonL31Output;

  /// No description provided for @lessonL32Title.
  ///
  /// In en, this message translates to:
  /// **'Flexbox and Responsive Basics'**
  String get lessonL32Title;

  /// No description provided for @lessonL32Intro.
  ///
  /// In en, this message translates to:
  /// **'Layouts should adapt to different screens.'**
  String get lessonL32Intro;

  /// No description provided for @lessonL32Output.
  ///
  /// In en, this message translates to:
  /// **'Elements align in rows/columns and adjust better on small screens.'**
  String get lessonL32Output;

  /// No description provided for @lessonL41Title.
  ///
  /// In en, this message translates to:
  /// **'Variables, Conditions, and Loops'**
  String get lessonL41Title;

  /// No description provided for @lessonL41Intro.
  ///
  /// In en, this message translates to:
  /// **'JavaScript adds logic and behavior to pages.'**
  String get lessonL41Intro;

  /// No description provided for @lessonL41Output.
  ///
  /// In en, this message translates to:
  /// **'Interactive output that changes when conditions or loops run.'**
  String get lessonL41Output;

  /// No description provided for @lessonL42Title.
  ///
  /// In en, this message translates to:
  /// **'Functions, Arrays, and Objects'**
  String get lessonL42Title;

  /// No description provided for @lessonL42Intro.
  ///
  /// In en, this message translates to:
  /// **'Organize logic and data with reusable patterns.'**
  String get lessonL42Intro;

  /// No description provided for @lessonL42Output.
  ///
  /// In en, this message translates to:
  /// **'Structured output generated from arrays, objects, and function calls.'**
  String get lessonL42Output;

  /// No description provided for @lessonL51Title.
  ///
  /// In en, this message translates to:
  /// **'Bootstrap Layout Basics'**
  String get lessonL51Title;

  /// No description provided for @lessonL51Intro.
  ///
  /// In en, this message translates to:
  /// **'Use framework classes for faster responsive layout.'**
  String get lessonL51Intro;

  /// No description provided for @lessonL51Output.
  ///
  /// In en, this message translates to:
  /// **'A simple grid-based page with reusable layout sections.'**
  String get lessonL51Output;

  /// No description provided for @lessonL52Title.
  ///
  /// In en, this message translates to:
  /// **'React Component Basics'**
  String get lessonL52Title;

  /// No description provided for @lessonL52Intro.
  ///
  /// In en, this message translates to:
  /// **'Split UI into reusable components and pass data.'**
  String get lessonL52Intro;

  /// No description provided for @lessonL52Output.
  ///
  /// In en, this message translates to:
  /// **'Reusable component-style cards rendered from one function.'**
  String get lessonL52Output;

  /// No description provided for @lessonL53Title.
  ///
  /// In en, this message translates to:
  /// **'Vue and Angular Core Patterns'**
  String get lessonL53Title;

  /// No description provided for @lessonL53Intro.
  ///
  /// In en, this message translates to:
  /// **'Learn binding, components, and module-based structure.'**
  String get lessonL53Intro;

  /// No description provided for @lessonL53Output.
  ///
  /// In en, this message translates to:
  /// **'Live UI output that updates from input and event logic.'**
  String get lessonL53Output;

  /// No description provided for @lessonL71Title.
  ///
  /// In en, this message translates to:
  /// **'Clean Code and Reusability'**
  String get lessonL71Title;

  /// No description provided for @lessonL71Intro.
  ///
  /// In en, this message translates to:
  /// **'Readable code scales better over time.'**
  String get lessonL71Intro;

  /// No description provided for @lessonL71Output.
  ///
  /// In en, this message translates to:
  /// **'A reusable component-style section rendered from reusable logic.'**
  String get lessonL71Output;

  /// No description provided for @lessonL72Title.
  ///
  /// In en, this message translates to:
  /// **'API Intro and JSON Basics'**
  String get lessonL72Title;

  /// No description provided for @lessonL72Intro.
  ///
  /// In en, this message translates to:
  /// **'Apps exchange structured data through APIs.'**
  String get lessonL72Intro;

  /// No description provided for @lessonL72Output.
  ///
  /// In en, this message translates to:
  /// **'Formatted JSON-like data shown in readable structure.'**
  String get lessonL72Output;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageBisaya.
  ///
  /// In en, this message translates to:
  /// **'Bisaya'**
  String get languageBisaya;

  /// No description provided for @languageFilipino.
  ///
  /// In en, this message translates to:
  /// **'Filipino'**
  String get languageFilipino;

  /// No description provided for @quote0.
  ///
  /// In en, this message translates to:
  /// **'Every expert once started with one line of code.'**
  String get quote0;

  /// No description provided for @quote1.
  ///
  /// In en, this message translates to:
  /// **'Small progress daily beats rare giant efforts.'**
  String get quote1;

  /// No description provided for @quote2.
  ///
  /// In en, this message translates to:
  /// **'Debugging sharpens your developer mindset.'**
  String get quote2;

  /// No description provided for @quote3.
  ///
  /// In en, this message translates to:
  /// **'Clarity first, cleverness later.'**
  String get quote3;

  /// No description provided for @quote4.
  ///
  /// In en, this message translates to:
  /// **'Build small, finish strong, then level up.'**
  String get quote4;

  /// No description provided for @quote5.
  ///
  /// In en, this message translates to:
  /// **'Consistency turns beginners into builders.'**
  String get quote5;

  /// No description provided for @quote6.
  ///
  /// In en, this message translates to:
  /// **'Your next lesson is your next breakthrough.'**
  String get quote6;

  /// No description provided for @badgeFirstStep.
  ///
  /// In en, this message translates to:
  /// **'First Step'**
  String get badgeFirstStep;

  /// No description provided for @badgeQuizStarter.
  ///
  /// In en, this message translates to:
  /// **'Quiz Starter'**
  String get badgeQuizStarter;

  /// No description provided for @badgePracticeExplorer.
  ///
  /// In en, this message translates to:
  /// **'Practice Explorer'**
  String get badgePracticeExplorer;

  /// No description provided for @badgeMomentumCoder.
  ///
  /// In en, this message translates to:
  /// **'Momentum Coder'**
  String get badgeMomentumCoder;

  /// No description provided for @badgeLevelCleared.
  ///
  /// In en, this message translates to:
  /// **'Level {level} Cleared'**
  String badgeLevelCleared(int level);

  /// No description provided for @badgeExpertTrailblazer.
  ///
  /// In en, this message translates to:
  /// **'Expert Trailblazer'**
  String get badgeExpertTrailblazer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ceb', 'en', 'fil'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ceb':
      return AppLocalizationsCeb();
    case 'en':
      return AppLocalizationsEn();
    case 'fil':
      return AppLocalizationsFil();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
