class QuestionOption {
  final String text;
  final int weight; // 1-5, higher = more spicy

  const QuestionOption(this.text, {required this.weight});
}

class GameQuestion {
  final int level; // 1-5
  final String text;
  final List<QuestionOption> options;

  const GameQuestion(this.level, this.text, this.options);
}
