import 'package:jay2xcoder/data/models/practice_set.dart';

PracticeSet _practice({
  required String lessonId,
  required String reorderPrompt,
  required List<String> reorder,
  required String bugPrompt,
  required List<String> bugChoices,
  required int bugAnswer,
  required String bugExplanation,
  required List<ConceptMatch> matches,
}) {
  return PracticeSet(
    lessonId: lessonId,
    reorderPrompt: reorderPrompt,
    reorderCorrectLines: reorder,
    bugPrompt: bugPrompt,
    bugChoices: bugChoices,
    bugAnswerIndex: bugAnswer,
    bugExplanation: bugExplanation,
    matches: matches,
  );
}

final Map<String, PracticeSet> mockPracticeSetsByLevel = <String, PracticeSet>{
  'lv1': _practice(
    lessonId: 'lv1',
    reorderPrompt:
        'Arrange algorithm steps for checking if number is positive.',
    reorder: <String>[
      'Read number n',
      'If n > 0 print Positive',
      'Else print Not Positive',
    ],
    bugPrompt: 'Find the bug: if (age => 18) { print("Adult"); }',
    bugChoices: <String>[
      'Use >= instead of =>',
      'Need a loop',
      'Use table tag',
      'Missing CSS',
    ],
    bugAnswer: 0,
    bugExplanation: 'Correct comparison operator is >=.',
    matches: <ConceptMatch>[
      ConceptMatch(
        concept: 'Algorithm',
        definitions: <String>[
          'Ordered steps for a task',
          'UI color palette',
          'A hardware part',
        ],
        correctDefinition: 'Ordered steps for a task',
      ),
      ConceptMatch(
        concept: 'Condition',
        definitions: <String>[
          'A true/false check',
          'A layout system',
          'A storage device',
        ],
        correctDefinition: 'A true/false check',
      ),
    ],
  ),
  'lv2': _practice(
    lessonId: 'lv2',
    reorderPrompt: 'Arrange HTML skeleton order.',
    reorder: <String>[
      '<!DOCTYPE html>',
      '<html>',
      '<head></head>',
      '<body></body>',
      '</html>',
    ],
    bugPrompt: 'Find the issue: <img src="a.png">',
    bugChoices: <String>[
      'Missing alt attribute',
      'Wrong because image needs </img>',
      'Needs CSS file',
      'Must use table',
    ],
    bugAnswer: 0,
    bugExplanation: 'Add alt text for accessibility.',
    matches: <ConceptMatch>[
      ConceptMatch(
        concept: '<a>',
        definitions: <String>[
          'Creates a link',
          'Creates form input',
          'Creates list',
        ],
        correctDefinition: 'Creates a link',
      ),
      ConceptMatch(
        concept: '<form>',
        definitions: <String>[
          'Collects user input',
          'Styles text',
          'Connects APIs',
        ],
        correctDefinition: 'Collects user input',
      ),
    ],
  ),
  'lv3': _practice(
    lessonId: 'lv3',
    reorderPrompt: 'Arrange CSS declaration order.',
    reorder: <String>['selector', '{', 'property: value;', '}'],
    bugPrompt: 'Find the issue: .card { padding 12px; }',
    bugChoices: <String>[
      'Missing colon after padding',
      'Class selectors cannot use dot',
      'Padding must be quoted',
      'Needs DOM',
    ],
    bugAnswer: 0,
    bugExplanation: 'Declaration should be property: value.',
    matches: <ConceptMatch>[
      ConceptMatch(
        concept: 'Flexbox',
        definitions: <String>[
          'Layout and alignment model',
          'Data format',
          'Version tool',
        ],
        correctDefinition: 'Layout and alignment model',
      ),
      ConceptMatch(
        concept: 'Margin',
        definitions: <String>['Outer spacing', 'Text color', 'Animation type'],
        correctDefinition: 'Outer spacing',
      ),
    ],
  ),
  'lv4': _practice(
    lessonId: 'lv4',
    reorderPrompt: 'Arrange a function declaration correctly.',
    reorder: <String>['function greet(name) {', '  return "Hi " + name;', '}'],
    bugPrompt: 'Find the issue: for (let i = 0; i < 3; i--) { ... }',
    bugChoices: <String>[
      'Use i++ to increment',
      'Cannot use let in loops',
      'Must use while only',
      'Missing HTML',
    ],
    bugAnswer: 0,
    bugExplanation: 'i-- moves away from loop exit condition.',
    matches: <ConceptMatch>[
      ConceptMatch(
        concept: 'Array',
        definitions: <String>[
          'Ordered list of items',
          'Branching statement',
          'Database server',
        ],
        correctDefinition: 'Ordered list of items',
      ),
      ConceptMatch(
        concept: 'Object',
        definitions: <String>[
          'Key-value data structure',
          'Animation event',
          'Compiler option',
        ],
        correctDefinition: 'Key-value data structure',
      ),
    ],
  ),
  'lv5': _practice(
    lessonId: 'lv5',
    reorderPrompt: 'Arrange framework app building steps in order.',
    reorder: <String>[
      'Set up base layout/components',
      'Bind data to UI',
      'Handle user events',
      'Refactor into reusable modules',
    ],
    bugPrompt:
        'Find the issue: <div class="row"><div class="col-6">A</div></div> (no container)',
    bugChoices: <String>[
      'Grid should normally be wrapped inside a container',
      'col-6 is invalid',
      'row should be button',
      'HTML must have only span tags',
    ],
    bugAnswer: 0,
    bugExplanation:
        'Bootstrap grid behaves best inside container or container-fluid.',
    matches: <ConceptMatch>[
      ConceptMatch(
        concept: 'Component',
        definitions: <String>[
          'Reusable UI unit',
          'Database query tool',
          'UI animation package',
        ],
        correctDefinition: 'Reusable UI unit',
      ),
      ConceptMatch(
        concept: 'Data Binding',
        definitions: <String>[
          'Syncing data values with the displayed UI',
          'Deploying to app stores',
          'Selecting app theme colors',
        ],
        correctDefinition: 'Syncing data values with the displayed UI',
      ),
    ],
  ),
  'lv6': _practice(
    lessonId: 'lv6',
    reorderPrompt: 'Arrange steps for handling button click events.',
    reorder: <String>[
      'Select element',
      'Attach click listener',
      'Run callback logic',
    ],
    bugPrompt: 'Find the issue: localStorage.setItem(name, "Jay")',
    bugChoices: <String>[
      'Key should be string: "name"',
      'Cannot store strings',
      'setItem needs 3 params',
      'localStorage only stores images',
    ],
    bugAnswer: 0,
    bugExplanation: 'Use string key names for local storage.',
    matches: <ConceptMatch>[
      ConceptMatch(
        concept: 'DOM Event',
        definitions: <String>[
          'Triggered action from user/system',
          'A CSS unit',
          'A database table',
        ],
        correctDefinition: 'Triggered action from user/system',
      ),
      ConceptMatch(
        concept: 'Validation',
        definitions: <String>[
          'Input quality check',
          'Image compression step',
          'Routing URL pattern',
        ],
        correctDefinition: 'Input quality check',
      ),
    ],
  ),
  'lv7': _practice(
    lessonId: 'lv7',
    reorderPrompt: 'Arrange API data flow.',
    reorder: <String>[
      'Send request',
      'Receive JSON response',
      'Parse response data',
      'Render data in UI',
    ],
    bugPrompt: 'Find the issue: { name: "Jay" course: "IT" }',
    bugChoices: <String>[
      'Missing comma between fields',
      'Curly braces not allowed',
      'JSON cannot contain strings',
      'Need CSS selector',
    ],
    bugAnswer: 0,
    bugExplanation: 'JSON fields must be separated with commas.',
    matches: <ConceptMatch>[
      ConceptMatch(
        concept: 'Component',
        definitions: <String>[
          'Reusable UI/function block',
          'A network cable',
          'A SQL command',
        ],
        correctDefinition: 'Reusable UI/function block',
      ),
      ConceptMatch(
        concept: 'API',
        definitions: <String>[
          'Interface for app communication',
          'A font family',
          'A CSS property',
        ],
        correctDefinition: 'Interface for app communication',
      ),
    ],
  ),
  'lv8': _practice(
    lessonId: 'lv8',
    reorderPrompt: 'Arrange portfolio case-study sections.',
    reorder: <String>[
      'Define problem',
      'Explain solution',
      'Show stack and features',
      'Share result and lessons',
    ],
    bugPrompt: 'Find the issue in plan: "Build everything first, test later."',
    bugChoices: <String>[
      'Testing should be continuous',
      'No issue, that is best',
      'Should avoid milestones',
      'Need less planning',
    ],
    bugAnswer: 0,
    bugExplanation: 'Continuous testing catches issues early.',
    matches: <ConceptMatch>[
      ConceptMatch(
        concept: 'Optimization',
        definitions: <String>[
          'Improve efficiency and performance',
          'Add random features',
          'Rename the app only',
        ],
        correctDefinition: 'Improve efficiency and performance',
      ),
      ConceptMatch(
        concept: 'Portfolio',
        definitions: <String>[
          'Collection of project proof',
          'Browser cache folder',
          'A server room',
        ],
        correctDefinition: 'Collection of project proof',
      ),
    ],
  ),
};
