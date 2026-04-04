import '../models/game_action.dart';

/// Actions are purely between the two people.
/// Level 1-2: soft, conversational
/// Level 3: intimate
/// Level 4-5: bold

GameAction getActionForScore(int score) {
  final pool = _actionsForScore(score);
  pool.shuffle();
  return pool.first;
}

List<GameAction> _actionsForScore(int score) {
  if (score >= 25) return _level5.map((t) => GameAction(t, 5)).toList();
  if (score >= 18) return _level4.map((t) => GameAction(t, 4)).toList();
  if (score >= 12) return _level3.map((t) => GameAction(t, 3)).toList();
  if (score >= 6)  return _level2.map((t) => GameAction(t, 2)).toList();
  return _level1.map((t) => GameAction(t, 1)).toList();
}

const _level1 = [
  "Look them in the eyes for 5 seconds without saying anything",
  "Tell them the first thing you noticed about them tonight",
  "Give them one compliment — the one you've been holding back",
  "Tell them one true thing about yourself that you usually save for later",
];

const _level2 = [
  "Move your chair a little closer — without explanation",
  "Tell them something you find attractive about them right now",
  "Touch their hand for a moment while you're talking",
  "Look at them like you're figuring something out",
];

const _level3 = [
  "Tell them what you've been thinking about doing since the beginning of the night",
  "Put your hand on theirs and hold it for 10 seconds",
  "Whisper something in their ear — something you wouldn't say out loud",
  "Look at them for 10 seconds. No talking. Just that.",
];

const _level4 = [
  "Tell them you'd like to kiss them — and see what happens",
  "Move close enough that you're almost touching and stay there",
  "Tell them exactly what you want right now",
  "Do something you've been wanting to do all night",
];

const _level5 = [
  "Kiss them",
  "Tell them what comes next — then make it happen",
  "Close the distance. You've both been waiting.",
  "Stop talking. You both know what this is.",
];
