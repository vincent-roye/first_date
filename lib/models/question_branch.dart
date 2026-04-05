enum QuestionBranch {
  romantic('💜', 'Romantic'),
  spicy('🌶️', 'Spicy'),
  deep('🔮', 'Deep');

  final String emoji;
  final String label;
  const QuestionBranch(this.emoji, this.label);
}

enum QuestionType {
  standard,
  mirror,    // "What do you think the other will answer?"
  actionFirst, // "Do this action before answering"
  silent,    // "Look at each other for 15s"
}

class QuestionOption {
  final String text;
  final int weight; // 1-5, higher = more spicy

  const QuestionOption(this.text, {required this.weight});
}

class GameQuestion {
  final QuestionBranch branch;
  final int level; // 1-5
  final String text;
  final List<QuestionOption> options;
  final QuestionType type;
  final String? instruction; // For action-first or silent types

  const GameQuestion({
    required this.branch,
    required this.level,
    required this.text,
    required this.options,
    this.type = QuestionType.standard,
    this.instruction,
  });
}
