import 'package:jay2xcoder/data/models/lesson_quiz.dart';
import 'package:jay2xcoder/data/models/localized_text.dart';
import 'package:jay2xcoder/data/models/quiz_question.dart';

LessonQuiz _quiz(String lessonId, List<QuizQuestion> questions) {
  return LessonQuiz(lessonId: lessonId, passScore: 70, questions: questions);
}

LocalizedText _t(String en, {String? ceb, String? fil}) {
  return LocalizedText(en: en, ceb: ceb, fil: fil);
}

QuizQuestion _q({
  required String id,
  required QuizQuestionType type,
  required LocalizedText question,
  required List<LocalizedText> options,
  required int answer,
  required LocalizedText explanation,
  String? codeLine,
}) {
  return QuizQuestion(
    id: id,
    type: type,
    question: question,
    options: options,
    correctIndex: answer,
    explanation: explanation,
    codeLine: codeLine,
  );
}

List<LocalizedText> _tf() {
  return <LocalizedText>[
    _t('True', ceb: 'Tinuod', fil: 'Totoo'),
    _t('False', ceb: 'Dili tinuod', fil: 'Mali'),
  ];
}

Map<String, LessonQuiz> _buildGenericLessonQuizzes() {
  const Map<String, ({String en, String ceb, String fil})> topics =
      <String, ({String en, String ceb, String fil})>{
        'l1_1': (
          en: 'programming basics',
          ceb: 'basics sa programming',
          fil: 'basics ng programming',
        ),
        'l3_1': (
          en: 'CSS selectors',
          ceb: 'CSS selectors',
          fil: 'CSS selectors',
        ),
        'l3_2': (
          en: 'responsive layout',
          ceb: 'responsive layout',
          fil: 'responsive layout',
        ),
        'l4_1': (
          en: 'JavaScript logic',
          ceb: 'JavaScript logic',
          fil: 'JavaScript logic',
        ),
        'l4_2': (
          en: 'functions and objects',
          ceb: 'functions ug objects',
          fil: 'functions at objects',
        ),
        'l5_1': (
          en: 'Bootstrap layout',
          ceb: 'Bootstrap layout',
          fil: 'Bootstrap layout',
        ),
        'l5_2': (
          en: 'React components',
          ceb: 'React components',
          fil: 'React components',
        ),
        'l5_3': (
          en: 'framework patterns',
          ceb: 'framework patterns',
          fil: 'framework patterns',
        ),
        'l6_1': (en: 'DOM events', ceb: 'DOM events', fil: 'DOM events'),
        'l6_2': (
          en: 'validation and storage',
          ceb: 'validation ug storage',
          fil: 'validation at storage',
        ),
        'l7_1': (en: 'clean code', ceb: 'clean code', fil: 'clean code'),
        'l7_2': (en: 'JSON basics', ceb: 'JSON basics', fil: 'JSON basics'),
        'l8_1': (
          en: 'project planning',
          ceb: 'project planning',
          fil: 'project planning',
        ),
        'l8_2': (en: 'optimization', ceb: 'optimization', fil: 'optimization'),
        'l9_1': (en: 'PHP basics', ceb: 'PHP basics', fil: 'PHP basics'),
        'l9_2': (
          en: 'PHP forms and input',
          ceb: 'PHP forms ug input',
          fil: 'PHP forms at input',
        ),
      };

  final Map<String, LessonQuiz> result = <String, LessonQuiz>{};

  for (final MapEntry<String, ({String en, String ceb, String fil})> entry
      in topics.entries) {
    final String lessonId = entry.key;
    final topic = entry.value;

    result[lessonId] = _quiz(lessonId, <QuizQuestion>[
      _q(
        id: 'q_${lessonId}_1',
        type: QuizQuestionType.multipleChoice,
        question: _t(
          'This lesson is mainly about ${topic.en}.',
          ceb: 'Kini nga lesson kasagarang bahin sa ${topic.ceb}.',
          fil: 'Ang lesson na ito ay pangunahing tungkol sa ${topic.fil}.',
        ),
        options: _tf(),
        answer: 0,
        explanation: _t(
          'Correct. Keep focus on the main lesson idea before writing code.',
          ceb:
              'Sakto. I-focus ang main idea sa lesson sa dili pa magsulat og code.',
          fil:
              'Tama. I-focus muna ang main idea ng lesson bago magsulat ng code.',
        ),
      ),
      _q(
        id: 'q_${lessonId}_2',
        type: QuizQuestionType.identification,
        question: _t(
          'Best beginner step after reading this lesson?',
          ceb:
              'Pinakamaayong beginner nga sunod lakang human basahon ang lesson?',
          fil:
              'Pinakamagandang beginner na susunod na hakbang pagkatapos basahin ang lesson?',
        ),
        options: <LocalizedText>[
          _t(
            'Try the practice section and observe output',
            ceb: 'Sulayi ang practice section ug tan-awa ang output',
            fil: 'Subukan ang practice section at obserbahan ang output',
          ),
          _t(
            'Skip practice and jump to random code',
            ceb: 'Laktawan ang practice ug dretso sa random nga code',
            fil: 'Laktawan ang practice at dumiretso sa random na code',
          ),
          _t(
            'Memorize only without testing',
            ceb: 'Memorize ra nga walay testing',
            fil: 'Mag-memorize lang nang walang testing',
          ),
          _t(
            'Ignore examples',
            ceb: 'Pasagdi ang examples',
            fil: 'Balewalain ang examples',
          ),
        ],
        answer: 0,
        explanation: _t(
          'Practice + output checking helps beginners understand code meaning faster.',
          ceb:
              'Ang practice ug output checking makatabang sa beginners nga masabtan dayon ang kahulugan sa code.',
          fil:
              'Ang practice at output checking ay tumutulong sa beginners na mas mabilis maintindihan ang kahulugan ng code.',
        ),
      ),
    ]);
  }

  return result;
}

final Map<String, LessonQuiz> mockQuizzes = <String, LessonQuiz>{
  ..._buildGenericLessonQuizzes(),
  'l1_1': _quiz('l1_1', <QuizQuestion>[
    _q(
      id: 'q111',
      type: QuizQuestionType.identification,
      question: _t(
        'What is programming?',
        ceb: 'Unsa ang programming?',
        fil: 'Ano ang programming?',
      ),
      options: <LocalizedText>[
        _t(
          'Writing clear instructions for a computer',
          ceb: 'Pagsulat og klaro nga instructions para sa computer',
          fil: 'Pagsulat ng malinaw na instructions para sa computer',
        ),
        _t(
          'Only designing app colors',
          ceb: 'Pag-design ra sa app colors',
          fil: 'Pag-design lang ng app colors',
        ),
        _t(
          'Buying a laptop',
          ceb: 'Pagpalit og laptop',
          fil: 'Pagbili ng laptop',
        ),
        _t(
          'Typing without logic',
          ceb: 'Pag-type nga walay logic',
          fil: 'Pagta-type na walang logic',
        ),
      ],
      answer: 0,
      explanation: _t(
        'Programming means solving problems by giving exact step-by-step instructions.',
        ceb:
            'Ang programming mao ang pagsulbad sa problema pinaagi sa exact step-by-step instructions.',
        fil:
            'Ang programming ay paglutas ng problema gamit ang eksaktong step-by-step instructions.',
      ),
    ),
    _q(
      id: 'q112',
      type: QuizQuestionType.multipleChoice,
      question: _t(
        'Which line declares an HTML5 document?',
        ceb: 'Unsa nga line ang nag-declare og HTML5 document?',
        fil: 'Aling line ang nagde-declare ng HTML5 document?',
      ),
      options: <LocalizedText>[
        _t('<!DOCTYPE html>'),
        _t('<document html>'),
        _t('<html5>'),
        _t('<meta html5>'),
      ],
      answer: 0,
      explanation: _t(
        'Always begin with <!DOCTYPE html> so the browser uses modern HTML rules.',
      ),
    ),
    _q(
      id: 'q113',
      type: QuizQuestionType.multipleChoice,
      question: _t(
        'Where should metadata and page title usually be placed?',
        ceb: 'Asa ibutang ang metadata ug page title?',
        fil: 'Saan inilalagay ang metadata at page title?',
      ),
      options: <LocalizedText>[
        _t('<head>'),
        _t('<body>'),
        _t('<footer>'),
        _t('<section>'),
      ],
      answer: 0,
      explanation: _t(
        '<head> keeps document info like title, meta, and links to CSS.',
      ),
    ),
    _q(
      id: 'q114',
      type: QuizQuestionType.multipleChoice,
      question: _t(
        'Which section contains visible web page content?',
        ceb: 'Asa nga section naa ang makita nga content sa webpage?',
        fil: 'Aling section ang may nakikitang content ng webpage?',
      ),
      options: <LocalizedText>[
        _t('<body>'),
        _t('<head>'),
        _t('<meta>'),
        _t('<script setup>'),
      ],
      answer: 0,
      explanation: _t(
        'Headings, paragraphs, links, lists, forms, and images are normally inside <body>.',
      ),
    ),
    _q(
      id: 'q115',
      type: QuizQuestionType.trueFalse,
      question: _t(
        'Closing tags are important to keep HTML structure valid.',
        ceb: 'Importante ang closing tags aron valid ang HTML structure.',
        fil: 'Mahalaga ang closing tags para valid ang HTML structure.',
      ),
      options: _tf(),
      answer: 0,
      explanation: _t(
        'Most paired tags should be closed (for example: <body> ... </body>).',
      ),
    ),
    _q(
      id: 'q116',
      type: QuizQuestionType.codeMeaning,
      codeLine: '<html> ... </html>',
      question: _t('What does this pair do?'),
      options: <LocalizedText>[
        _t('Wraps the entire HTML document'),
        _t('Styles the page'),
        _t('Runs JavaScript'),
        _t('Shows browser notifications'),
      ],
      answer: 0,
      explanation: _t('The <html> root element encloses head and body.'),
    ),
    _q(
      id: 'q117',
      type: QuizQuestionType.codeMeaning,
      codeLine: '<body> ... </body>',
      question: _t('What is inside this section?'),
      options: <LocalizedText>[
        _t('Content users can see on screen'),
        _t('Only app settings'),
        _t('Only comments'),
        _t('Only file names'),
      ],
      answer: 0,
      explanation: _t('Visual content for users belongs in <body>.'),
    ),
  ]),
  'l2_1': _quiz('l2_1', <QuizQuestion>[
    _q(
      id: 'q211',
      type: QuizQuestionType.identification,
      question: _t(
        'What is <!DOCTYPE html>?',
        ceb: 'Unsa ang <!DOCTYPE html>?',
        fil: 'Ano ang <!DOCTYPE html>?',
      ),
      options: <LocalizedText>[
        _t(
          'It tells the browser this file is HTML5',
          ceb: 'Nagasulti kini sa browser nga HTML5 kini nga file',
          fil: 'Sinasabi nito sa browser na HTML5 ang file na ito',
        ),
        _t(
          'It creates a paragraph',
          ceb: 'Naghimo kini og paragraph',
          fil: 'Gumagawa ito ng paragraph',
        ),
        _t(
          'It creates a link',
          ceb: 'Naghimo kini og link',
          fil: 'Gumagawa ito ng link',
        ),
        _t(
          'It inserts an image',
          ceb: 'Nagbutang kini og image',
          fil: 'Naglalagay ito ng image',
        ),
      ],
      answer: 0,
      explanation: _t(
        'DOCTYPE tells the browser to read the page as HTML5.',
        ceb:
            'Ang DOCTYPE nagasulti sa browser nga basahon ang page isip HTML5.',
        fil: 'Sinasabi ng DOCTYPE sa browser na basahin ang page bilang HTML5.',
      ),
    ),
    _q(
      id: 'q212',
      type: QuizQuestionType.multipleChoice,
      question: _t(
        'Which tag wraps the whole webpage?',
        ceb: 'Asang tag nagkupot sa tibuok webpage?',
        fil: 'Aling tag ang bumabalot sa buong webpage?',
      ),
      options: <LocalizedText>[
        _t('<head>', ceb: '<head>', fil: '<head>'),
        _t('<body>', ceb: '<body>', fil: '<body>'),
        _t('<html>', ceb: '<html>', fil: '<html>'),
        _t('<title>', ceb: '<title>', fil: '<title>'),
      ],
      answer: 2,
      explanation: _t(
        '<html> is the root tag of the page.',
        ceb: 'Ang <html> mao ang root tag sa page.',
        fil: 'Ang <html> ang root tag ng page.',
      ),
    ),
    _q(
      id: 'q213',
      type: QuizQuestionType.identification,
      question: _t(
        'What is the purpose of <head>?',
        ceb: 'Unsa ang gamit sa <head>?',
        fil: 'Ano ang gamit ng <head>?',
      ),
      options: <LocalizedText>[
        _t(
          'Contains page info like title and metadata',
          ceb: 'Naglangkob sa page info sama sa title ug metadata',
          fil: 'Naglalaman ng page info tulad ng title at metadata',
        ),
        _t(
          'Contains all visible content',
          ceb: 'Naglangkob sa tanang makita nga content',
          fil: 'Naglalaman ng lahat ng nakikitang content',
        ),
        _t(
          'Creates headings',
          ceb: 'Naghimo og headings',
          fil: 'Gumagawa ng headings',
        ),
        _t('Creates forms', ceb: 'Naghimo og forms', fil: 'Gumagawa ng forms'),
      ],
      answer: 0,
      explanation: _t(
        'The <head> stores background page details, not visible text blocks.',
        ceb:
            'Ang <head> para sa impormasyon sa page, dili para sa makita nga text blocks.',
        fil:
            'Ang <head> ay para sa impormasyon ng page, hindi sa nakikitang text blocks.',
      ),
    ),
    _q(
      id: 'q214',
      type: QuizQuestionType.codeMeaning,
      codeLine: '<title>My First Page</title>',
      question: _t(
        'Where is "My First Page" usually shown?',
        ceb: 'Asa kasagarang makita ang "My First Page"?',
        fil: 'Saan karaniwang nakikita ang "My First Page"?',
      ),
      options: <LocalizedText>[
        _t('Browser tab', ceb: 'Browser tab', fil: 'Browser tab'),
        _t('Inside <h1>', ceb: 'Sulod sa <h1>', fil: 'Sa loob ng <h1>'),
        _t('Inside image', ceb: 'Sulod sa image', fil: 'Sa loob ng image'),
        _t('Inside footer', ceb: 'Sulod sa footer', fil: 'Sa loob ng footer'),
      ],
      answer: 0,
      explanation: _t(
        '<title> controls the text shown in the browser tab.',
        ceb: 'Ang <title> nagkontrol sa text nga makita sa browser tab.',
        fil: 'Ang <title> ang kumokontrol sa text na nakikita sa browser tab.',
      ),
    ),
    _q(
      id: 'q215',
      type: QuizQuestionType.identification,
      question: _t(
        'What is the purpose of <body>?',
        ceb: 'Unsa ang gamit sa <body>?',
        fil: 'Ano ang gamit ng <body>?',
      ),
      options: <LocalizedText>[
        _t(
          'Contains visible webpage content',
          ceb: 'Naglangkob sa makita nga content sa webpage',
          fil: 'Naglalaman ng nakikitang content ng webpage',
        ),
        _t(
          'Stores metadata only',
          ceb: 'Metadata lang ang gisudlan',
          fil: 'Metadata lang ang nilalaman',
        ),
        _t(
          'Changes browser zoom',
          ceb: 'Nag-usab sa browser zoom',
          fil: 'Binabago ang browser zoom',
        ),
        _t(
          'Creates source map',
          ceb: 'Naghimo og source map',
          fil: 'Gumagawa ng source map',
        ),
      ],
      answer: 0,
      explanation: _t(
        'Headings, paragraphs, links, and images are placed in <body>.',
        ceb:
            'Ang headings, paragraphs, links, ug images ibutang sulod sa <body>.',
        fil:
            'Ang headings, paragraphs, links, at images ay inilalagay sa <body>.',
      ),
    ),
    _q(
      id: 'q216',
      type: QuizQuestionType.identification,
      question: _t(
        'What is <h1>?',
        ceb: 'Unsa ang <h1>?',
        fil: 'Ano ang <h1>?',
      ),
      options: <LocalizedText>[
        _t(
          'Main heading tag',
          ceb: 'Main heading nga tag',
          fil: 'Main heading na tag',
        ),
        _t('Paragraph tag', ceb: 'Paragraph nga tag', fil: 'Paragraph na tag'),
        _t('Image tag', ceb: 'Image nga tag', fil: 'Image na tag'),
        _t('List tag', ceb: 'List nga tag', fil: 'List na tag'),
      ],
      answer: 0,
      explanation: _t(
        '<h1> is used for the biggest heading on the page.',
        ceb: 'Ang <h1> gigamit para sa pinakadako nga heading sa page.',
        fil: 'Ang <h1> ay ginagamit para sa pinakamalaking heading sa page.',
      ),
    ),
    _q(
      id: 'q217',
      type: QuizQuestionType.multipleChoice,
      question: _t(
        'Which tag is a heading but smaller than <h1>?',
        ceb: 'Asang tag heading gihapon pero mas gamay sa <h1>?',
        fil: 'Aling tag ang heading pa rin pero mas maliit sa <h1>?',
      ),
      options: <LocalizedText>[
        _t('<h2>', ceb: '<h2>', fil: '<h2>'),
        _t('<p>', ceb: '<p>', fil: '<p>'),
        _t('<body>', ceb: '<body>', fil: '<body>'),
        _t('<img>', ceb: '<img>', fil: '<img>'),
      ],
      answer: 0,
      explanation: _t(
        '<h2> is the next heading level after <h1>.',
        ceb: 'Ang <h2> mao ang sunod nga heading level human sa <h1>.',
        fil: 'Ang <h2> ay kasunod na heading level pagkatapos ng <h1>.',
      ),
    ),
    _q(
      id: 'q218',
      type: QuizQuestionType.identification,
      question: _t(
        'Which tag is used for a paragraph?',
        ceb: 'Asang tag gigamit para sa paragraph?',
        fil: 'Aling tag ang ginagamit para sa paragraph?',
      ),
      options: <LocalizedText>[
        _t('<p>', ceb: '<p>', fil: '<p>'),
        _t('<h1>', ceb: '<h1>', fil: '<h1>'),
        _t('<title>', ceb: '<title>', fil: '<title>'),
        _t('<form>', ceb: '<form>', fil: '<form>'),
      ],
      answer: 0,
      explanation: _t(
        '<p> creates regular paragraph text.',
        ceb: 'Ang <p> naghimo sa ordinaryo nga paragraph text.',
        fil: 'Ang <p> ay gumagawa ng ordinaryong paragraph text.',
      ),
    ),
  ]),
  'l2_2': _quiz('l2_2', <QuizQuestion>[
    _q(
      id: 'q221',
      type: QuizQuestionType.identification,
      question: _t(
        'What is the <a> tag used for?',
        ceb: 'Para unsa ang <a> tag?',
        fil: 'Para saan ang <a> tag?',
      ),
      options: <LocalizedText>[
        _t('Creating links', ceb: 'Paghimo og links', fil: 'Paglikha ng links'),
        _t(
          'Creating headings',
          ceb: 'Paghimo og headings',
          fil: 'Paglikha ng headings',
        ),
        _t(
          'Creating tables',
          ceb: 'Paghimo og tables',
          fil: 'Paglikha ng tables',
        ),
        _t(
          'Creating CSS rules',
          ceb: 'Paghimo og CSS rules',
          fil: 'Paglikha ng CSS rules',
        ),
      ],
      answer: 0,
      explanation: _t(
        '<a> creates a clickable hyperlink.',
        ceb: 'Ang <a> naghimo og ma-click nga hyperlink.',
        fil: 'Ang <a> ay gumagawa ng clickable hyperlink.',
      ),
    ),
    _q(
      id: 'q222',
      type: QuizQuestionType.codeMeaning,
      codeLine: '<a href="https://example.com">Visit</a>',
      question: _t(
        'What does href do?',
        ceb: 'Unsa ang buhat sa href?',
        fil: 'Ano ang ginagawa ng href?',
      ),
      options: <LocalizedText>[
        _t(
          'Sets the link destination',
          ceb: 'Nag-set sa adtoan sa link',
          fil: 'Nagse-set ng pupuntahan ng link',
        ),
        _t(
          'Changes font size',
          ceb: 'Nag-usab sa font size',
          fil: 'Binabago ang font size',
        ),
        _t(
          'Creates image alt text',
          ceb: 'Naghimo og image alt text',
          fil: 'Gumagawa ng image alt text',
        ),
        _t(
          'Creates list bullets',
          ceb: 'Naghimo og list bullets',
          fil: 'Gumagawa ng list bullets',
        ),
      ],
      answer: 0,
      explanation: _t(
        'href points to the URL where the user will go.',
        ceb: 'Ang href nagtudlo sa URL nga adtoan sa user.',
        fil: 'Ang href ay tumutukoy sa URL na pupuntahan ng user.',
      ),
    ),
    _q(
      id: 'q223',
      type: QuizQuestionType.multipleChoice,
      question: _t(
        'Which tag is used to display an image?',
        ceb: 'Asang tag gigamit para magpakita og image?',
        fil: 'Aling tag ang ginagamit para magpakita ng image?',
      ),
      options: <LocalizedText>[
        _t('<img>', ceb: '<img>', fil: '<img>'),
        _t('<a>', ceb: '<a>', fil: '<a>'),
        _t('<ul>', ceb: '<ul>', fil: '<ul>'),
        _t('<li>', ceb: '<li>', fil: '<li>'),
      ],
      answer: 0,
      explanation: _t(
        '<img> places an image in the webpage.',
        ceb: 'Ang <img> nagbutang og image sa webpage.',
        fil: 'Ang <img> ay naglalagay ng image sa webpage.',
      ),
    ),
    _q(
      id: 'q224',
      type: QuizQuestionType.trueFalse,
      question: _t(
        'Alt text helps users understand an image when it does not load.',
        ceb:
            'Ang alt text makatabang sa pagsabot sa image kung dili kini mag-load.',
        fil:
            'Nakakatulong ang alt text para maintindihan ang image kapag hindi ito nag-load.',
      ),
      options: _tf(),
      answer: 0,
      explanation: _t(
        'Alt text improves accessibility and gives backup description.',
        ceb:
            'Ang alt text nagpalambo sa accessibility ug naghatag og backup nga hulagway.',
        fil:
            'Pinapabuti ng alt text ang accessibility at nagbibigay ng backup na paglalarawan.',
      ),
    ),
    _q(
      id: 'q225',
      type: QuizQuestionType.identification,
      question: _t(
        'What does <ul> do?',
        ceb: 'Unsa ang buhat sa <ul>?',
        fil: 'Ano ang ginagawa ng <ul>?',
      ),
      options: <LocalizedText>[
        _t(
          'Creates a bulleted list',
          ceb: 'Naghimo og bulleted list',
          fil: 'Gumagawa ng bulleted list',
        ),
        _t(
          'Creates a paragraph',
          ceb: 'Naghimo og paragraph',
          fil: 'Gumagawa ng paragraph',
        ),
        _t(
          'Creates a title',
          ceb: 'Naghimo og title',
          fil: 'Gumagawa ng title',
        ),
        _t(
          'Creates a button',
          ceb: 'Naghimo og button',
          fil: 'Gumagawa ng button',
        ),
      ],
      answer: 0,
      explanation: _t(
        '<ul> starts an unordered list (bullets).',
        ceb: 'Ang <ul> mao ang pagsugod sa unordered list (bullets).',
        fil: 'Ang <ul> ang panimula ng unordered list (bullets).',
      ),
    ),
    _q(
      id: 'q226',
      type: QuizQuestionType.multipleChoice,
      question: _t(
        'Which tag is used for each item inside a list?',
        ceb: 'Asang tag gigamit sa matag item sulod sa list?',
        fil: 'Aling tag ang ginagamit sa bawat item sa loob ng list?',
      ),
      options: <LocalizedText>[
        _t('<li>', ceb: '<li>', fil: '<li>'),
        _t('<head>', ceb: '<head>', fil: '<head>'),
        _t('<body>', ceb: '<body>', fil: '<body>'),
        _t('<h1>', ceb: '<h1>', fil: '<h1>'),
      ],
      answer: 0,
      explanation: _t(
        '<li> defines one list item.',
        ceb: 'Ang <li> nag-define sa usa ka list item.',
        fil: 'Ang <li> ay nagde-define ng isang list item.',
      ),
    ),
    _q(
      id: 'q227',
      type: QuizQuestionType.identification,
      question: _t(
        'What is the purpose of <form>?',
        ceb: 'Unsa ang gamit sa <form>?',
        fil: 'Ano ang gamit ng <form>?',
      ),
      options: <LocalizedText>[
        _t(
          'Collect user input',
          ceb: 'Mangolekta og user input',
          fil: 'Mangolekta ng user input',
        ),
        _t(
          'Set page title',
          ceb: 'Mag-set sa page title',
          fil: 'Mag-set ng page title',
        ),
        _t(
          'Display image',
          ceb: 'Magpakita og image',
          fil: 'Magpakita ng image',
        ),
        _t(
          'Create heading levels',
          ceb: 'Maghimo og heading levels',
          fil: 'Gumawa ng heading levels',
        ),
      ],
      answer: 0,
      explanation: _t(
        '<form> groups input fields and submit actions.',
        ceb: 'Ang <form> nag-group sa input fields ug submit actions.',
        fil: 'Ang <form> ay naggugrupo ng input fields at submit actions.',
      ),
    ),
  ]),
};
