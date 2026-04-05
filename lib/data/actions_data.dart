import '../models/game_action.dart';

/// Progressive actions that build intensity
class ActionLibrary {
  /// Get a progressive sequence of actions for a given level
  static List<GameAction> getActionsForLevel(int level) {
    switch (level) {
      case 1:
        return [
          GameAction(text: "Look them in the eyes for 5 seconds without saying anything", level: 1, intensity: ActionIntensity.soft),
          GameAction(text: "Tell them the first thing you noticed about them tonight", level: 1, intensity: ActionIntensity.soft),
          GameAction(text: "Give them one compliment — the one you've been holding back", level: 1, intensity: ActionIntensity.soft),
        ];
      case 2:
        return [
          GameAction(text: "Move your chair a little closer — without explanation", level: 2, intensity: ActionIntensity.soft),
          GameAction(text: "Tell them something you find attractive about them right now", level: 2, intensity: ActionIntensity.intimate),
          GameAction(text: "Touch their hand for a moment while you're talking", level: 2, intensity: ActionIntensity.intimate, isProgressive: true),
        ];
      case 3:
        return [
          GameAction(text: "Take their hand. Hold it. Don't let go for 10 seconds.", level: 3, intensity: ActionIntensity.intimate, isProgressive: true),
          GameAction(text: "Whisper something in their ear — something you wouldn't say out loud", level: 3, intensity: ActionIntensity.intimate),
          GameAction(text: "Put your hand on their arm. Feel the warmth.", level: 3, intensity: ActionIntensity.intimate, isProgressive: true),
        ];
      case 4:
        return [
          GameAction(text: "Move close enough that you're almost touching and stay there", level: 4, intensity: ActionIntensity.bold, isProgressive: true),
          GameAction(text: "Tell them you'd like to kiss them — and see what happens", level: 4, intensity: ActionIntensity.bold),
          GameAction(text: "Put your hand on their cheek. Look at their lips.", level: 4, intensity: ActionIntensity.bold, isProgressive: true),
        ];
      case 5:
        return [
          GameAction(text: "Close the distance. Kiss them.", level: 5, intensity: ActionIntensity.bold, isProgressive: true),
          GameAction(text: "Whisper what you want to happen next.", level: 5, intensity: ActionIntensity.bold),
          GameAction(text: "Stop talking. You both know what this is.", level: 5, intensity: ActionIntensity.bold),
        ];
      default:
        return [];
    }
  }

  /// Get a random action for the current score/level
  static GameAction getRandomAction(int level) {
    final actions = getActionsForLevel(level);
    actions.shuffle();
    return actions.first;
  }
}
