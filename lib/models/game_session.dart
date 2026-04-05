import 'game_action.dart';
import 'question_branch.dart';

class GameSession {
  int spiceScore = 0;
  int questionCount = 0;
  int currentLevel = 1;
  int streak = 0; // Consecutive spicy answers
  int streakMultiplier = 1;
  
  QuestionBranch currentBranch = QuestionBranch.romantic;
  Map<QuestionBranch, int> branchLevels = {
    QuestionBranch.romantic: 1,
    QuestionBranch.spicy: 1,
    QuestionBranch.deep: 1,
  };

  List<GameAction> actionsDone = [];
  List<GameAction> actionsPassed = [];
  List<Map<String, dynamic>> history = []; // For replay/stats

  bool isPremium = false; // Will be set by RevenueCat

  void addQuestionScore(int weight, QuestionBranch branch) {
    // Streak logic: if weight >= 4, increase streak
    if (weight >= 4) {
      streak++;
      if (streak >= 3) streakMultiplier = 2;
    } else {
      streak = 0;
      streakMultiplier = 1;
    }

    spiceScore += weight * streakMultiplier;
    questionCount++;
    _updateLevel(branch);
    
    // Save to history for replay
    history.add({
      'type': 'question',
      'score': weight,
      'branch': branch.name,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void goSpicier() {
    spiceScore += 3;
    streak++;
    _updateLevel(currentBranch);
  }

  void goMilder() {
    if (spiceScore > 2) spiceScore -= 2;
    streak = 0;
    streakMultiplier = 1;
    _updateLevel(currentBranch);
  }

  void _updateLevel(QuestionBranch branch) {
    int level;
    if (spiceScore >= 25) level = 5;
    else if (spiceScore >= 18) level = 4;
    else if (spiceScore >= 12) level = 3;
    else if (spiceScore >= 6)  level = 2;
    else                       level = 1;
    
    branchLevels[branch] = level;
    if (branch == currentBranch) {
      currentLevel = level;
    }
  }

  void switchBranch(QuestionBranch newBranch) {
    currentBranch = newBranch;
    currentLevel = branchLevels[newBranch] ?? 1;
  }

  void actionCompleted(GameAction action) {
    action.completed = true;
    actionsDone.add(action);
    spiceScore += 4;
    streak++;
    _updateLevel(currentBranch);
    
    history.add({
      'type': 'action_completed',
      'text': action.text,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void actionPassed(GameAction action) {
    action.passed = true;
    actionsPassed.add(action);
    if (spiceScore > 1) spiceScore -= 1;
    streak = 0;
    streakMultiplier = 1;
    _updateLevel(currentBranch);
    
    history.add({
      'type': 'action_passed',
      'text': action.text,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  bool get shouldTriggerAction =>
      questionCount > 0 && questionCount % 4 == 0;

  Map<String, dynamic> get stats {
    return {
      'totalScore': spiceScore,
      'questionsAnswered': questionCount,
      'actionsCompleted': actionsDone.length,
      'actionsPassed': actionsPassed.length,
      'maxStreak': streak,
      'branch': currentBranch.name,
      'history': history,
    };
  }
}
