class ConceptMatch {
  const ConceptMatch({
    required this.concept,
    required this.definitions,
    required this.correctDefinition,
  });

  final String concept;
  final List<String> definitions;
  final String correctDefinition;
}

class PracticeSet {
  const PracticeSet({
    required this.lessonId,
    required this.reorderPrompt,
    required this.reorderCorrectLines,
    required this.bugPrompt,
    required this.bugChoices,
    required this.bugAnswerIndex,
    required this.bugExplanation,
    required this.matches,
  });

  final String lessonId;
  final String reorderPrompt;
  final List<String> reorderCorrectLines;
  final String bugPrompt;
  final List<String> bugChoices;
  final int bugAnswerIndex;
  final String bugExplanation;
  final List<ConceptMatch> matches;
}
