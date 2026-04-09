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
            'Programming is writing step-by-step instructions so a computer can do useful tasks.',
        detailedExplanation:
            'Programming is problem solving with clear and exact instructions. Think of it like giving directions: if steps are complete and in order, the computer follows correctly.\n\n'
            'For web pages, structure is very important:\n'
            '1) `<!DOCTYPE html>` tells the browser to use modern HTML5 rules.\n'
            '2) `<html> ... </html>` wraps the whole page.\n'
            '3) `<head> ... </head>` contains setup info (title, metadata, CSS links).\n'
            '4) `<body> ... </body>` contains what people actually see on screen.\n\n'
            'Most HTML tags open and close, for example `<p> ... </p>` and `<h1> ... </h1>`. Learning this structure first makes CSS and JavaScript much easier.',
        example:
            '<!DOCTYPE html>\\n<html>\\n  <head>\\n    <title>My First Web Page</title>\\n  </head>\\n  <body>\\n    <h1>Welcome, Freshman Developer!</h1>\\n    <p>This is my first structured page.</p>\\n  </body>\\n</html>',
        keyTakeaways: <String>[
          'Programming is solving problems using exact, ordered steps.',
          'Start with HTML structure first, then add CSS design and JavaScript behavior.',
          'Understand opening and closing tags such as <body> ... </body> and <p> ... </p>.',
        ],
        miniActivity:
            'In your own words, explain what DOCTYPE, html, head, and body do.',
        techIconAsset: 'assets/tech/flutter.svg',
        techLabel: 'Programming',
      ),
      _lesson(
        id: 'l1_2',
        levelId: 'lv1',
        order: 2,
        title: 'What Is Programming: Logic and Algorithms',
        shortExplanation:
            'This is a continuation of What Is Programming, focused on logic and algorithms.',
        detailedExplanation:
            'This lesson continues What Is Programming and focuses on logic. Logic means your app has a clear flow: start, check conditions, do action, then finish.\n\n'
            'In simple terms:\n'
            '1) Sequence: steps happen from top to bottom.\n'
            '2) Condition: if something is true, do this; else do another action.\n'
            '3) Repetition: repeat a task while needed.\n\n'
            'When your logic is organized, your code is easier to read, debug, and improve.',
        example:
            'int score = 80;\\n'
            '\\n'
            'if (score >= 75) {\\n'
            '  print("Passed");\\n'
            '} else {\\n'
            '  print("Try again");\\n'
            '}',
        keyTakeaways: <String>[
          'Good programming starts with clear flow before writing many lines of code.',
          'Use conditions to decide what should happen next.',
          'Simple step-by-step plans reduce bugs.',
        ],
        miniActivity:
            'Write 3 to 5 steps for a simple login process in your own words.',
        techIconAsset: 'assets/tech/git.svg',
        techLabel: 'Programming',
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
        title: 'HTML Complete Tag Guide: Document Basics',
        shortExplanation:
            'Learn the complete foundation tags: doctype, html, head, body, headings, paragraphs, and text tags.',
        detailedExplanation:
            'Core HTML document tags and what they do:\n'
            '1) `<!DOCTYPE html>` = tells browser to use HTML5 standards.\n'
            '2) `<html lang="en">` = root element wrapping the whole page.\n'
            '3) `<head>` = metadata, title, and external resource links.\n'
            '4) `<meta charset="UTF-8">` = supports proper character encoding.\n'
            '5) `<meta name="viewport" content="width=device-width, initial-scale=1.0">` = mobile responsive scaling.\n'
            '6) `<title>` = tab title in browser.\n'
            '7) `<body>` = visible content shown to users.\n\n'
            'Basic content tags:\n'
            '- `<h1>` to `<h6>` = headings (largest to smallest).\n'
            '- `<p>` = paragraph.\n'
            '- `<br>` = line break.\n'
            '- `<hr>` = horizontal divider line.\n'
            '- `<strong>`, `<em>`, `<mark>`, `<small>` = text emphasis/formatting.\n\n'
            'Rule: most tags open and close (`<tag>...</tag>`). Void tags like `<br>` and `<img>` do not need closing pairs.',
        example:
            '<!DOCTYPE html>\\n'
            '<html lang="en">\\n'
            '<head>\\n'
            '  <meta charset="UTF-8" />\\n'
            '  <meta name="viewport" content="width=device-width, initial-scale=1.0" />\\n'
            '  <title>HTML Tag Guide</title>\\n'
            '</head>\\n'
            '<body>\\n'
            '  <h1>Welcome Freshman Developer</h1>\\n'
            '  <h2>Lesson: HTML Basics</h2>\\n'
            '  <p>This paragraph explains what HTML tags do.</p>\\n'
            '  <p><strong>Strong</strong>, <em>emphasis</em>, <mark>highlight</mark>, <small>small text</small></p>\\n'
            '  <hr />\\n'
            '</body>\\n'
            '</html>',
        keyTakeaways: <String>[
          '`<!DOCTYPE html>`, `<html>`, `<head>`, and `<body>` are the required core structure tags.',
          '`<h1>` to `<h6>` define heading hierarchy; use one main `<h1>` per page.',
          '`<p>`, `<br>`, `<hr>`, `<strong>`, `<em>`, `<mark>`, and `<small>` format readable text content.',
          'Correct opening and closing tags prevent broken layouts and confusion.',
        ],
        miniActivity:
            'Create one page using doctype, html, head, title, body, h1, and two paragraphs.',
        techIconAsset: 'assets/tech/html5.svg',
        techLabel: 'HTML',
      ),
      _lesson(
        id: 'l2_2',
        levelId: 'lv2',
        order: 2,
        title: 'HTML Complete Tag Guide: Content and Forms',
        shortExplanation:
            'Complete practical tags for links, media, lists, tables, forms, semantic sections, and scripts.',
        detailedExplanation:
            'Important HTML tags and why you use them:\n'
            '- Navigation/media: `<a>`, `<img>`, `<audio>`, `<video>`, `<iframe>`.\n'
            '- Grouping/layout: `<div>`, `<span>`, `<section>`, `<article>`, `<header>`, `<nav>`, `<main>`, `<footer>`.\n'
            '- Lists: `<ul>`, `<ol>`, `<li>`, plus `<dl>`, `<dt>`, `<dd>` for definition lists.\n'
            '- Tables: `<table>`, `<thead>`, `<tbody>`, `<tr>`, `<th>`, `<td>`.\n'
            '- Forms: `<form>`, `<label>`, `<input>`, `<textarea>`, `<select>`, `<option>`, `<button>`.\n'
            '- Utility: `<script>` for JS and `<link>` for CSS.\n\n'
            'Accessibility tips:\n'
            '1) Add `alt` on images.\n'
            '2) Connect `<label for="">` to input `id`.\n'
            '3) Use semantic tags (`<main>`, `<section>`, `<footer>`) for clearer structure.',
        example:
            '<section>\\n'
            '  <header><h1>My Profile</h1></header>\\n'
            '  <nav><a href="#about">About</a> | <a href="#contact">Contact</a></nav>\\n'
            '  <article id="about">\\n'
            '    <img src="profile.jpg" alt="Profile photo" />\\n'
            '    <p>Hello! I am learning web development.</p>\\n'
            '    <ul><li>HTML</li><li>CSS</li><li>JavaScript</li></ul>\\n'
            '  </article>\\n'
            '  <form id="contact">\\n'
            '    <label for="email">Email</label>\\n'
            '    <input id="email" type="email" />\\n'
            '    <button type="submit">Send</button>\\n'
            '  </form>\\n'
            '</section>',
        keyTakeaways: <String>[
          '`<a>`, `<img>`, `<audio>`, and `<video>` deliver interactive and multimedia content.',
          '`<ul>/<ol>/<li>` organize lists, while table tags should be used only for real table data.',
          '`<form>`, `<label>`, and `<input>` collect user input correctly and accessibly.',
          'Semantic tags like `<header>`, `<main>`, `<section>`, and `<footer>` make pages easier to read and maintain.',
        ],
        miniActivity:
            'Build a page with header, nav, image, list, one table row, and a contact form.',
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
        example:
            ':root {\\n'
            '  --primary: #0f766e;\\n'
            '}\\n'
            '\\n'
            'h1 {\\n'
            '  color: var(--primary);\\n'
            '  margin-bottom: 12px;\\n'
            '}\\n'
            '\\n'
            '.card {\\n'
            '  padding: 16px;\\n'
            '  border-radius: 12px;\\n'
            '}',
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
        example:
            '.row {\\n'
            '  display: flex;\\n'
            '  gap: 12px;\\n'
            '}\\n'
            '\\n'
            '@media (max-width: 640px) {\\n'
            '  .row {\\n'
            '    flex-direction: column;\\n'
            '  }\\n'
            '}',
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
        example:
            'for (let i = 1; i <= 5; i++) {\\n'
            '  if (i % 2 === 0) {\\n'
            '    console.log(`\${i} is even`);\\n'
            '  } else {\\n'
            '    console.log(`\${i} is odd`);\\n'
            '  }\\n'
            '}',
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
        example:
            'const student = {\\n'
            '  name: "Ana",\\n'
            '  year: 1,\\n'
            '  skills: ["HTML", "CSS", "JS"]\\n'
            '};\\n'
            '\\n'
            'function getGreeting(user) {\\n'
            '  return `Hello, \${user.name}!`;\\n'
            '}\\n'
            '\\n'
            'console.log(getGreeting(student));',
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
            '<div class="container py-4">\\n'
            '  <div class="row g-3">\\n'
            '    <div class="col-md-6">\\n'
            '      <div class="card p-3">Card A</div>\\n'
            '    </div>\\n'
            '    <div class="col-md-6">\\n'
            '      <div class="card p-3">Card B</div>\\n'
            '    </div>\\n'
            '  </div>\\n'
            '</div>',
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
            'function Welcome(props) {\\n'
            '  return <h1>Hello {props.name}</h1>;\\n'
            '}\\n'
            '\\n'
            'export default function App() {\\n'
            '  return (\\n'
            '    <main>\\n'
            '      <Welcome name="Jay" />\\n'
            '    </main>\\n'
            '  );\\n'
            '}',
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
        example:
            '// Vue template\\n'
            '<template>\\n'
            '  <p>{{ message }}</p>\\n'
            '</template>\\n'
            '\\n'
            '// Angular template\\n'
            '<p>{{ message }}</p>',
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
            'const button = document.querySelector("#saveBtn");\\n'
            'const title = document.querySelector("#title");\\n'
            '\\n'
            'button.addEventListener("click", () => {\\n'
            '  title.textContent = "Saved successfully";\\n'
            '});',
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
        example:
            'const name = document.querySelector("#name").value.trim();\\n'
            '\\n'
            'if (name.length < 2) {\\n'
            '  alert("Name is too short.");\\n'
            '} else {\\n'
            '  localStorage.setItem("name", name);\\n'
            '  alert("Saved!");\\n'
            '}',
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
            'function formatName(first, last) {\\n'
            '  return `\${first} \${last}`;\\n'
            '}\\n'
            '\\n'
            'function toTitleCase(text) {\\n'
            '  return text[0].toUpperCase() + text.slice(1).toLowerCase();\\n'
            '}',
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
        example:
            '{\\n'
            '  "name": "Jay",\\n'
            '  "course": "IT",\\n'
            '  "year": 1,\\n'
            '  "skills": ["HTML", "CSS", "JavaScript"]\\n'
            '}',
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
            'const milestones = [\\n'
            '  "Design",\\n'
            '  "Core Features",\\n'
            '  "Testing"\\n'
            '];\\n'
            '\\n'
            'milestones.forEach((step, index) => {\\n'
            '  console.log(`\${index + 1}. \${step}`);\\n'
            '});',
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
            'const caseStudy = {\\n'
            '  problem: "Students struggle with schedules",\\n'
            '  solution: "Built a task reminder app",\\n'
            '  stack: ["HTML", "CSS", "JavaScript"],\\n'
            '  result: "Improved daily task completion",\\n'
            '  lessons: "Plan first, ship in small milestones"\\n'
            '};',
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
  LearningLevel(
    id: 'lv9',
    order: 9,
    title: 'PHP Essentials',
    subtitle: 'Server-side fundamentals',
    description: 'Learn PHP syntax, variables, forms, and backend basics.',
    iconAsset: 'assets/tech/php.svg',
    lessons: <LessonItem>[
      _lesson(
        id: 'l9_1',
        levelId: 'lv9',
        order: 1,
        title: 'PHP Syntax and Variables',
        shortExplanation:
            'PHP runs on the server and generates dynamic output for websites.',
        detailedExplanation:
            'PHP is a server-side language often used with HTML forms and databases.\n'
            'You write PHP code inside `<?php ... ?>` tags.\n\n'
            'Basics:\n'
            '1) `echo` prints output.\n'
            '2) Variables start with `\$` like `\$name`.\n'
            '3) Use `if`, `else`, and loops for logic.\n'
            '4) Arrays store grouped values.\n'
            '5) Functions help reuse code.\n\n'
            'PHP executes on the server first, then returns plain HTML to the browser.',
        example:
            '<?php\\n'
            '\$name = "Jay";\\n'
            '\$year = 1;\\n'
            'echo "<h1>Hello, \$name!</h1>";\\n'
            'if (\$year == 1) {\\n'
            '  echo "<p>Welcome, freshman developer.</p>";\\n'
            '}\\n'
            '?>',
        keyTakeaways: <String>[
          'PHP code lives inside `<?php ... ?>` tags.',
          'Variables use `\$` and can store strings, numbers, and arrays.',
          '`echo` prints dynamic text into HTML output.',
          'Server-side logic allows personalized pages and form handling.',
        ],
        miniActivity:
            'Create a PHP script that prints your name and your course year.',
        techIconAsset: 'assets/tech/php.svg',
        techLabel: 'PHP',
      ),
      _lesson(
        id: 'l9_2',
        levelId: 'lv9',
        order: 2,
        title: 'PHP Forms and Superglobals',
        shortExplanation:
            'Use PHP to read submitted form data using superglobal variables.',
        detailedExplanation:
            'Superglobals are built-in PHP arrays available everywhere.\n'
            'Common ones for beginners:\n'
            '- `\$_GET` = reads URL query values.\n'
            '- `\$_POST` = reads form body values.\n'
            '- `\$_SERVER` = request/server information.\n\n'
            'Typical flow:\n'
            '1) Build an HTML form.\n'
            '2) Submit with `method="post"`.\n'
            '3) Read and validate input in PHP.\n'
            '4) Return success or error message safely.',
        example:
            '<form method="post">\\n'
            '  <label>Name</label>\\n'
            '  <input name="student_name" />\\n'
            '  <button type="submit">Submit</button>\\n'
            '</form>\\n'
            '<?php\\n'
            'if (isset(\$_POST["student_name"])) {\\n'
            '  \$name = trim(\$_POST["student_name"]);\\n'
            '  echo "Hello, " . htmlspecialchars(\$name);\\n'
            '}\\n'
            '?>',
        keyTakeaways: <String>[
          '`\$_POST` and `\$_GET` are the standard way to read form data.',
          'Always validate and sanitize user input before displaying it.',
          '`htmlspecialchars()` helps prevent unsafe output rendering.',
          'Form + PHP processing is a core backend workflow.',
        ],
        miniActivity:
            'Create one form that accepts name and outputs a safe greeting.',
        techIconAsset: 'assets/tech/php.svg',
        techLabel: 'PHP',
      ),
    ],
  ),
];
