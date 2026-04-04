class GameAction {
  final String text;
  final int level;
  bool completed;
  bool passed;

  GameAction(this.text, this.level)
      : completed = false,
        passed = false;
}
