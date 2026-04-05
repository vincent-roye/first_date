enum ActionIntensity {
  soft,
  intimate,
  bold,
}

class GameAction {
  final String text;
  final int level;
  final ActionIntensity intensity;
  final bool isProgressive;
  bool completed;
  bool passed;

  GameAction({
    required this.text,
    required this.level,
    this.intensity = ActionIntensity.intimate,
    this.isProgressive = false,
  })  : completed = false,
        passed = false;
}
