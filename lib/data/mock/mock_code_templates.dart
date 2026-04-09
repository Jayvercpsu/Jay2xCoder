import 'package:jay2xcoder/data/models/code_practice_template.dart';

final Map<String, CodePracticeTemplate>
mockCodePracticeTemplates = <String, CodePracticeTemplate>{
  'l2_1': const CodePracticeTemplate(
    lessonId: 'l2_1',
    language: PracticeLanguage.html,
    sampleCode:
        '<!DOCTYPE html>\n<html>\n<head>\n  <title>My First Page</title>\n</head>\n<body>\n  <h1>Hello World</h1>\n  <p>This is my first HTML page.</p>\n</body>\n</html>',
    starterHtml: '<h1>Hello World</h1>\n<p>This is my first HTML page.</p>',
    starterCss: '',
    starterJs: '',
    expectedOutputFallback:
        'A page with a heading "Hello World" and a short paragraph.',
  ),
  'l2_2': const CodePracticeTemplate(
    lessonId: 'l2_2',
    language: PracticeLanguage.html,
    sampleCode:
        '<a href="https://example.com">Visit Example</a>\n<img src="https://via.placeholder.com/120" alt="sample">\n<ul>\n  <li>HTML</li>\n  <li>CSS</li>\n</ul>',
    starterHtml:
        '<a href="https://example.com">Visit Example</a>\n<ul>\n  <li>Item One</li>\n  <li>Item Two</li>\n</ul>',
    starterCss: '',
    starterJs: '',
    expectedOutputFallback:
        'A clickable link and a simple list rendered on the page.',
  ),
  'l3_1': const CodePracticeTemplate(
    lessonId: 'l3_1',
    language: PracticeLanguage.css,
    sampleCode:
        '<h1>Styled Title</h1>\n<p>Practice CSS basics.</p>\n\n/* CSS */\nh1 { color: #0f766e; }\np { background: #ecfeff; padding: 8px; border-radius: 8px; }',
    starterHtml: '<h1>Styled Title</h1>\n<p>Practice CSS basics.</p>',
    starterCss:
        'h1 { color: #0f766e; }\np { background: #ecfeff; padding: 8px; border-radius: 8px; }',
    starterJs: '',
    expectedOutputFallback:
        'Styled heading and paragraph with colors, spacing, and rounded corners.',
    enableCssTab: true,
  ),
  'l3_2': const CodePracticeTemplate(
    lessonId: 'l3_2',
    language: PracticeLanguage.css,
    sampleCode:
        '<div class="row">\n  <div class="box">A</div>\n  <div class="box">B</div>\n</div>\n\n/* CSS */\n.row { display: flex; gap: 12px; }\n.box { flex: 1; padding: 16px; background: #e2e8f0; text-align: center; }',
    starterHtml:
        '<div class="row">\n  <div class="box">A</div>\n  <div class="box">B</div>\n</div>',
    starterCss:
        '.row { display: flex; gap: 12px; }\n.box { flex: 1; padding: 16px; background: #e2e8f0; text-align: center; }',
    starterJs: '',
    expectedOutputFallback:
        'Two boxes in a row using flexbox, with spacing and consistent style.',
    enableCssTab: true,
  ),
  'l4_1': const CodePracticeTemplate(
    lessonId: 'l4_1',
    language: PracticeLanguage.javascript,
    sampleCode:
        '<h1 id="title">Counter: 0</h1>\n<button onclick="increase()">Add</button>\n\n<script>\nlet count = 0;\nfunction increase() {\n  count++;\n  document.getElementById("title").textContent = "Counter: " + count;\n}\n</script>',
    starterHtml:
        '<h1 id="title">Counter: 0</h1>\n<button onclick="increase()">Add</button>',
    starterCss: 'button { padding: 10px 14px; border-radius: 8px; }',
    starterJs:
        'let count = 0;\nfunction increase() {\n  count++;\n  document.getElementById("title").textContent = "Counter: " + count;\n}',
    expectedOutputFallback:
        'A button that increases the counter text every click.',
    enableCssTab: true,
    enableJsTab: true,
  ),
  'l4_2': const CodePracticeTemplate(
    lessonId: 'l4_2',
    language: PracticeLanguage.javascript,
    sampleCode:
        '<div id="output"></div>\n\n<script>\nconst names = ["Ana", "Jay", "Mika"];\nconst result = names.map((name) => "Hello " + name).join("<br>");\ndocument.getElementById("output").innerHTML = result;\n</script>',
    starterHtml: '<div id="output"></div>',
    starterCss: '#output { font-size: 18px; line-height: 1.8; }',
    starterJs:
        'const names = ["Ana", "Jay", "Mika"];\nconst result = names.map((name) => "Hello " + name).join("<br>");\ndocument.getElementById("output").innerHTML = result;',
    expectedOutputFallback:
        'A list of greetings generated from array data and shown in output.',
    enableCssTab: true,
    enableJsTab: true,
  ),
  'l5_1': const CodePracticeTemplate(
    lessonId: 'l5_1',
    language: PracticeLanguage.framework,
    sampleCode:
        '<div class="container">\n  <div class="row">\n    <div class="col card">Framework Card 1</div>\n    <div class="col card">Framework Card 2</div>\n  </div>\n</div>\n\n/* CSS */\n.container { max-width: 820px; margin: 0 auto; }\n.row { display: flex; gap: 12px; }\n.col { flex: 1; }\n.card { background: #e2e8f0; padding: 16px; border-radius: 12px; text-align: center; }',
    starterHtml:
        '<div class="container">\n  <div class="row">\n    <div class="col card">Card A</div>\n    <div class="col card">Card B</div>\n  </div>\n</div>',
    starterCss:
        '.container { max-width: 820px; margin: 0 auto; }\n.row { display: flex; gap: 12px; }\n.col { flex: 1; }\n.card { background: #e2e8f0; padding: 16px; border-radius: 12px; text-align: center; }',
    starterJs: '',
    expectedOutputFallback:
        'A framework-style grid layout with two reusable cards.',
    enableCssTab: true,
  ),
  'l5_2': const CodePracticeTemplate(
    lessonId: 'l5_2',
    language: PracticeLanguage.framework,
    sampleCode:
        '<div id="app"></div>\n\n<script>\nfunction ProfileCard(name, track) {\n  return `<article class="card"><h2>\${name}</h2><p>\${track}</p></article>`;\n}\nconst cards = [\n  ProfileCard("Ana", "Frontend Track"),\n  ProfileCard("Jay", "Framework Track"),\n];\ndocument.getElementById("app").innerHTML = cards.join("");\n</script>',
    starterHtml: '<div id="app"></div>',
    starterCss:
        '.card { background: #f1f5f9; padding: 14px; border-radius: 12px; margin-bottom: 10px; }',
    starterJs:
        'function ProfileCard(name, track) {\n  return `<article class="card"><h2>\${name}</h2><p>\${track}</p></article>`;\n}\nconst cards = [\n  ProfileCard("Ana", "Frontend Track"),\n  ProfileCard("Jay", "Framework Track"),\n];\ndocument.getElementById("app").innerHTML = cards.join("");',
    expectedOutputFallback:
        'Reusable component-like cards rendered from one function.',
    enableCssTab: true,
    enableJsTab: true,
  ),
  'l5_3': const CodePracticeTemplate(
    lessonId: 'l5_3',
    language: PracticeLanguage.framework,
    sampleCode:
        '<h2>Live Binding Demo</h2>\n<input id="nameInput" placeholder="Type your name"/>\n<p id="output">Hello, Developer</p>\n\n<script>\nconst input = document.getElementById("nameInput");\nconst output = document.getElementById("output");\ninput.addEventListener("input", () => {\n  output.textContent = `Hello, \${input.value || "Developer"}`;\n});\n</script>',
    starterHtml:
        '<h2>Live Binding Demo</h2>\n<input id="nameInput" placeholder="Type your name"/>\n<p id="output">Hello, Developer</p>',
    starterCss:
        'input { padding: 10px; border-radius: 8px; border: 1px solid #94a3b8; }\n#output { margin-top: 10px; font-weight: 600; }',
    starterJs:
        'const input = document.getElementById("nameInput");\nconst output = document.getElementById("output");\ninput.addEventListener("input", () => {\n  output.textContent = `Hello, \${input.value || "Developer"}`;\n});',
    expectedOutputFallback:
        'Input text updates preview output immediately like framework binding.',
    enableCssTab: true,
    enableJsTab: true,
  ),
  'l7_1': const CodePracticeTemplate(
    lessonId: 'l7_1',
    language: PracticeLanguage.framework,
    sampleCode:
        '<div id="app"></div>\n\n<script>\nfunction Card(title, text) {\n  return `<section class="card"><h2>\${title}</h2><p>\${text}</p></section>`;\n}\ndocument.getElementById("app").innerHTML = Card("Reusable Component", "Build once, use many times.");\n</script>',
    starterHtml: '<div id="app"></div>',
    starterCss:
        '.card { padding: 16px; border-radius: 12px; background: #f1f5f9; }',
    starterJs:
        'function Card(title, text) {\n  return `<section class="card"><h2>\${title}</h2><p>\${text}</p></section>`;\n}\ndocument.getElementById("app").innerHTML = Card("Reusable Component", "Build once, use many times.");',
    expectedOutputFallback:
        'A reusable card rendered through a reusable function, similar to component thinking.',
    enableCssTab: true,
    enableJsTab: true,
  ),
};
