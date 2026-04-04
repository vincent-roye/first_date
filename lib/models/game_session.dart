import 'game_action.dart';

class GameSession {
  int spiceScore = 0;       // accumulates based on choices
  int questionCount = 0;
  int currentLevel = 1;     // 1-5, controls which questions appear
  List<GameAction> actionsDone = [];
  List<GameAction> actionsPassed = [];

  void addQuestionScore(int weight) {
    spiceScore += weight;
    questionCount++;
    _updateLevel();
  }

  void goSpicier() {
    spiceScore += 3;
    _updateLevel();
  }

  void goMilder() {
    if (spiceScore > 2) spiceScore -= 2;
    _updateLevel();
  }

  void _updateLevel() {
    if (spiceScore >= 25) currentLevel = 5;
    else if (spiceScore >= 18) currentLevel = 4;
    else if (spiceScore >= 12) currentLevel = 3;
    else if (spiceScore >= 6)  currentLevel = 2;
    else                       currentLevel = 1;
  }

  void actionCompleted(GameAction action) {
    action.completed = true;
    actionsDone.add(action);
    spiceScore += 4; // bold move = big boost
    _updateLevel();
  }

  void actionPassed(GameAction action) {
    action.passed = true;
    actionsPassed.add(action);
    if (spiceScore > 1) spiceScore -= 1;
    _updateLevel();
  }

  bool get shouldTriggerAction =>
      questionCount > 0 && questionCount % 4 == 0;
}
