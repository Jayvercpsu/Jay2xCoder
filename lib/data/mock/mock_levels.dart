import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';

LessonItem _lesson({
  required String id,
  required String levelId,
  required int order,
  required String title,
  required String shortExplanation,
  required String detailedExplanation,
  required String example,
  required List<String> keyTakeaways,
  required String miniActivity,
  required String techIconAsset,
  required String techLabel,
}) {
  return LessonItem(
    id: id,
    levelId: levelId,
    order: order,
    title: title,
    shortExplanation: shortExplanation,
    detailedExplanation: detailedExplanation,
    example: example,
    keyTakeaways: keyTakeaways,
    miniActivity: miniActivity,
    techIconAsset: techIconAsset,
    techLabel: techLabel,
  );
}

const List<String> motivationQuotes = <String>[
  'Every expert once started with one line of code.',
  'Small progress daily beats rare giant efforts.',
  'Debugging sharpens your developer mindset.',
  'Clarity first, cleverness later.',
  'Build small, finish strong, then level up.',
  'Consistency turns beginners into builders.',
  'Your next lesson is your next breakthrough.',
];

final List<LearningLevel> mockLevels = <LearningLevel>[
  LearningLevel(
    id: 'lv1',
    order: 1,
    title: 'Programming Basics',
    subtitle: 'Start from zero',
    description: 'Understand software, logic, and algorithms.',
    iconAsset: 'assets/tech/flutter.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l1_1',
        levelId: 'lv1',
        order: 1,
        title: 'What Is Programming?',
        shortExplanation:
            'Programming gives clear instructions that computers follow exactly.',
        detailedExplanation:
            'Programming is problem solving using precise steps. In web development, we also organize files clearly: `<!DOCTYPE html>` declares HTML5, `<html>` wraps the whole page, `<head>` stores metadata and links, and `<body>` contains visible content.',
        example:
            '<!DOCTYPE html>\\n<html>\\n  <head><title>My Page</title></head>\\n  <body><h1>Hello</h1></body>\\n</html>',
        keyTakeaways: <String>[
          'Computers need exact and organized instructions.',
          'Always understand structure before styling or scripting.',
          'Know opening and closing tags like <body> ... </body>.',
        ],
        miniActivity:
            'Explain what doctype, html, head, and body do in one sentence each.',
        techIconAsset: 'assets/tech/flutter.svg',
        techLabel: 'Programming',
      ),
      _lesson(
        id: 'l1_2',
        levelId: 'lv1',
        order: 2,
        title: 'Logic and Algorithms',
        shortExplanation: 'Algorithms are ordered problem-solving steps.',
        detailedExplanation:
            'Flow thinking uses conditions and sequence so your code behaves predictably.',
        example: 'If score >= 75 print Passed else print Try again.',
        keyTakeaways: <String>[
          'Algorithms are step-by-step.',
          'Conditions create decisions.',
          'Plan before coding.',
        ],
        miniActivity: 'Create an algorithm for logging into a school portal.',
        techIconAsset: 'assets/tech/git.svg',
        techLabel: 'Logic',
      ),
    ],
  ),
  LearningLevel(
    id: 'lv2',
    order: 2,
    title: 'HTML Fundamentals',
    subtitle: 'Build structure',
    description: 'Use HTML tags, content blocks, forms, and tables.',
    iconAsset: 'assets/tech/html5.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l2_1',
        levelId: 'lv2',
        order: 1,
        title: 'HTML Structure and Tags',
        shortExplanation: 'HTML defines structure of a web page.',
        detailedExplanation:
            'A complete page starts with doctype, then html, head, and body. Common tags include headings (`h1-h6`), paragraph (`p`), link (`a`), image (`img`), list (`ul`/`ol`/`li`), division (`div`), section (`section`), and form tags.',
        example:
            '<h1>Hello</h1>\\n<p>Welcome to coding.</p>\\n<a href="#">Open</a>\\n<ul><li>Item</li></ul>',
        keyTakeaways: <String>[
          'Structure comes first before CSS and JS.',
          'Use semantic tags for readability and accessibility.',
          'Close paired tags correctly.',
        ],
        miniActivity: 'Create a mini profile page with title and paragraph.',
        techIconAsset: 'assets/tech/html5.svg',
        techLabel: 'HTML',
      ),
      _lesson(
        id: 'l2_2',
        levelId: 'lv2',
        order: 2,
        title: 'Links, Images, Lists, Forms',
        shortExplanation: 'Core HTML elements make pages useful.',
        detailedExplanation:
            'Links connect pages, forms collect input, and lists/tables organize information clearly.',
        example: '<a href="https://example.com">Visit</a>',
        keyTakeaways: <String>[
          'Use alt text for images.',
          'Forms need labels.',
          'Use tables only for tabular data.',
        ],
        miniActivity: 'Build a basic contact form with name and email.',
        techIconAsset: 'assets/tech/html5.svg',
        techLabel: 'HTML',
      ),
    ],
  ),
  LearningLevel(
    id: 'lv3',
    order: 3,
    title: 'CSS Fundamentals',
    subtitle: 'Style clearly',
    description: 'Style UI with spacing, colors, and layout basics.',
    iconAsset: 'assets/tech/css3.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l3_1',
        levelId: 'lv3',
        order: 1,
        title: 'CSS Syntax and Selectors',
        shortExplanation: 'CSS controls presentation and appearance.',
        detailedExplanation:
            'Selectors choose elements, then property-value pairs apply style like color, spacing, and borders.',
        example: 'h1 { color: #0f766e; margin-bottom: 12px; }',
        keyTakeaways: <String>[
          'Selector targets element.',
          'Properties change visuals.',
          'Consistent spacing improves UX.',
        ],
        miniActivity: 'Style a card with padding and rounded corners.',
        techIconAsset: 'assets/tech/css3.svg',
        techLabel: 'CSS',
      ),
      _lesson(
        id: 'l3_2',
        levelId: 'lv3',
        order: 2,
        title: 'Flexbox and Responsive Basics',
        shortExplanation: 'Layout should adapt to different screens.',
        detailedExplanation:
            'Flexbox helps alignment and spacing. Responsive design keeps UI usable across device sizes.',
        example: '.row { display: flex; gap: 12px; }',
        keyTakeaways: <String>[
          'Flexbox is practical for rows/columns.',
          'Use relative spacing.',
          'Always test on phone size.',
        ],
        miniActivity: 'Build a two-column layout that stacks on mobile.',
        techIconAsset: 'assets/tech/css3.svg',
        techLabel: 'CSS',
      ),
    ],
  ),
  LearningLevel(
    id: 'lv4',
    order: 4,
    title: 'JavaScript Basics',
    subtitle: 'Add behavior',
    description: 'Learn variables, loops, functions, arrays, and objects.',
    iconAsset: 'assets/tech/javascript.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l4_1',
        levelId: 'lv4',
        order: 1,
        title: 'Variables, Conditions, and Loops',
        shortExplanation: 'JavaScript adds logic to pages.',
        detailedExplanation:
            'Use variables for data, conditions for decisions, and loops for repeated actions.',
        example: 'for (let i = 1; i <= 3; i++) { console.log(i); }',
        keyTakeaways: <String>[
          'Variables hold values.',
          'Conditions branch logic.',
          'Loops avoid repetition.',
        ],
        miniActivity: 'Write a loop that prints 1 to 5.',
        techIconAsset: 'assets/tech/javascript.svg',
        techLabel: 'JavaScript',
      ),
      _lesson(
        id: 'l4_2',
        levelId: 'lv4',
        order: 2,
        title: 'Functions, Arrays, and Objects',
        shortExplanation: 'Organize code and data better.',
        detailedExplanation:
            'Functions package logic, arrays store ordered items, objects store key-value information.',
        example: 'const student = { name: "Ana", year: 1 };',
        keyTakeaways: <String>[
          'Functions improve reuse.',
          'Arrays are ordered collections.',
          'Objects model real entities.',
        ],
        miniActivity: 'Create a function that returns sum of two numbers.',
        techIconAsset: 'assets/tech/javascript.svg',
        techLabel: 'JavaScript',
      ),
    ],
  ),
  LearningLevel(
    id: 'lv5',
    order: 5,
    title: 'Frameworks Development Path',
    subtitle: 'From basics to project mindset',
    description: 'Build faster using framework patterns and reusable code.',
    iconAsset: 'assets/tech/api.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l5_1',
        levelId: 'lv5',
        order: 1,
        title: 'Bootstrap Layout Basics',
        shortExplanation: 'Framework classes speed up page layout work.',
        detailedExplanation:
            'W3Schools introduces Bootstrap as a popular CSS framework. Start by using container, row, and column classes before customizing.',
        example:
            '<div class="container"><div class="row"><div class="col">Card A</div></div></div>',
        keyTakeaways: <String>[
          'Framework classes reduce repetitive CSS.',
          'Grid classes organize responsive layouts.',
          'Start with structure, then style details.',
        ],
        miniActivity: 'Build a 2-column layout with a simple hero section.',
        techIconAsset: 'assets/tech/css3.svg',
        techLabel: 'Bootstrap',
      ),
      _lesson(
        id: 'l5_2',
        levelId: 'lv5',
        order: 2,
        title: 'React Component Basics',
        shortExplanation: 'React focuses on reusable UI components.',
        detailedExplanation:
            'W3Schools React tutorials start with component thinking. Break UI into small pieces and pass data to those pieces.',
        example:
            'function Welcome(props) { return <h1>Hello {props.name}</h1>; }',
        keyTakeaways: <String>[
          'Components are reusable blocks.',
          'Props pass data into components.',
          'State updates dynamic UI.',
        ],
        miniActivity: 'Create a reusable card function with title + content.',
        techIconAsset: 'assets/tech/javascript.svg',
        techLabel: 'React',
      ),
      _lesson(
        id: 'l5_3',
        levelId: 'lv5',
        order: 3,
        title: 'Vue and Angular Core Patterns',
        shortExplanation: 'Learn binding, components, and project structure.',
        detailedExplanation:
            'W3Schools presents Vue and Angular as frameworks for building client apps. Focus on data binding, reusable components, and module structure.',
        example: 'Vue: <p>{{ message }}</p> | Angular: <p>{{ message }}</p>',
        keyTakeaways: <String>[
          'Data binding links code and UI.',
          'Component structure keeps code organized.',
          'Framework choice depends on project needs.',
        ],
        miniActivity: 'Bind one input value and display it live on screen.',
        techIconAsset: 'assets/tech/api.svg',
        techLabel: 'Vue/Angular',
      ),
    ],
  ),
  LearningLevel(
    id: 'lv6',
    order: 6,
    title: 'Intermediate Development',
    subtitle: 'Interactive pages',
    description: 'Handle DOM events, validation, and local storage.',
    iconAsset: 'assets/tech/api.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l6_1',
        levelId: 'lv6',
        order: 1,
        title: 'DOM and Events',
        shortExplanation: 'DOM lets JS update page content dynamically.',
        detailedExplanation:
            'Select elements, listen to events, and update UI from user interactions.',
        example:
            'button.addEventListener("click", () => title.textContent = "Done");',
        keyTakeaways: <String>[
          'DOM represents page objects.',
          'Events trigger behavior.',
          'Keep handlers focused.',
        ],
        miniActivity: 'Attach click event to change a paragraph text.',
        techIconAsset: 'assets/tech/api.svg',
        techLabel: 'DOM',
      ),
      _lesson(
        id: 'l6_2',
        levelId: 'lv6',
        order: 2,
        title: 'Form Validation and Local Storage',
        shortExplanation: 'Validate input and persist small local data.',
        detailedExplanation:
            'Validation protects data quality. Local storage saves simple key-value values.',
        example: 'localStorage.setItem("name", "Jay");',
        keyTakeaways: <String>[
          'Validate before submit.',
          'Store simple data locally.',
          'Use clear keys.',
        ],
        miniActivity: 'Require password length of at least 8.',
        techIconAsset: 'assets/tech/api.svg',
        techLabel: 'Storage',
      ),
    ],
  ),
  LearningLevel(
    id: 'lv7',
    order: 7,
    title: 'Advanced Beginner to Developer Path',
    subtitle: 'Write maintainable apps',
    description: 'Learn clean code, reusable parts, APIs, and JSON.',
    iconAsset: 'assets/tech/json.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l7_1',
        levelId: 'lv7',
        order: 1,
        title: 'Clean Code and Reusability',
        shortExplanation: 'Readable code scales better over time.',
        detailedExplanation:
            'Use clear names, small focused functions, and reusable components to avoid duplication.',
        example:
            'function formatName(first, last) { return `\${first} \${last}`; }',
        keyTakeaways: <String>[
          'Naming matters.',
          'Small functions are easier to test.',
          'Reuse saves effort.',
        ],
        miniActivity: 'Refactor one long function into two smaller ones.',
        techIconAsset: 'assets/tech/flutter.svg',
        techLabel: 'Clean Code',
      ),
      _lesson(
        id: 'l7_2',
        levelId: 'lv7',
        order: 2,
        title: 'API Intro and JSON Basics',
        shortExplanation: 'Apps exchange data through APIs, often in JSON.',
        detailedExplanation:
            'JSON is key-value data and common for API responses. Organized project structure helps teams.',
        example: '{ "name": "Jay", "course": "IT" }',
        keyTakeaways: <String>[
          'JSON is structured text data.',
          'APIs connect systems.',
          'Folders should stay organized.',
        ],
        miniActivity: 'Read JSON and display the value of name.',
        techIconAsset: 'assets/tech/json.svg',
        techLabel: 'JSON/API',
      ),
    ],
  ),
  LearningLevel(
    id: 'lv8',
    order: 8,
    title: 'Expert Path Introduction',
    subtitle: 'Prepare for real projects',
    description: 'Adopt project mindset, optimization, and portfolio guidance.',
    iconAsset: 'assets/tech/firebase.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l8_1',
        levelId: 'lv8',
        order: 1,
        title: 'Real-World Project Thinking',
        shortExplanation:
            'Good projects start with clear goals and milestones.',
        detailedExplanation:
            'Define user needs, break work into phases, and validate each milestone before scaling.',
        example:
            'Milestone 1 design -> Milestone 2 core features -> Milestone 3 testing',
        keyTakeaways: <String>[
          'Start with clear requirements.',
          'Deliver in milestones.',
          'Feedback improves quality.',
        ],
        miniActivity: 'List 3 features for a simple student app.',
        techIconAsset: 'assets/tech/firebase.svg',
        techLabel: 'Project Mindset',
      ),
      _lesson(
        id: 'l8_2',
        levelId: 'lv8',
        order: 2,
        title: 'Optimization and Portfolio Growth',
        shortExplanation: 'Measure, improve, and present your work.',
        detailedExplanation:
            'Optimization begins with measurement. Portfolio projects should explain problem, solution, and lessons learned.',
        example:
            'Case study: Problem -> Solution -> Stack -> Result -> Lessons',
        keyTakeaways: <String>[
          'Measure before optimizing.',
          'Debugging is continuous.',
          'Portfolio shows your growth.',
        ],
        miniActivity: 'Draft one portfolio entry in four short sentences.',
        techIconAsset: 'assets/tech/firebase.svg',
        techLabel: 'Portfolio',
      ),
    ],
  ),
];
