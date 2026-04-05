import '../models/question_branch.dart';
import '../models/game_question.dart';

// ─── ROMANTIC BRANCH ───────────────────────────────────────────────────────

final List<GameQuestion> romanticQuestions = [
  // Level 1
  GameQuestion(branch: QuestionBranch.romantic, level: 1, text: "What made you want to come tonight?", options: [
    QuestionOption("Curiosity about you", weight: 1),
    QuestionOption("I needed a good night out", weight: 1),
    QuestionOption("Something about you caught my attention", weight: 2),
    QuestionOption("Honestly? Instinct", weight: 2),
  ]),
  GameQuestion(branch: QuestionBranch.romantic, level: 1, text: "What's your idea of a perfect evening together?", options: [
    QuestionOption("Quiet night in, just talking", weight: 1),
    QuestionOption("Exploring somewhere new", weight: 2),
    QuestionOption("Something spontaneous", weight: 2),
    QuestionOption("Just being around you", weight: 3),
  ]),
  // Mirror question
  GameQuestion(branch: QuestionBranch.romantic, level: 1, text: "What do you think I noticed first about you?", type: QuestionType.mirror, options: [
    QuestionOption("My eyes", weight: 1),
    QuestionOption("My smile", weight: 2),
    QuestionOption("My energy", weight: 2),
    QuestionOption("Something unexpected", weight: 3),
  ]),

  // Level 2
  GameQuestion(branch: QuestionBranch.romantic, level: 2, text: "When do you feel most connected to someone?", options: [
    QuestionOption("When we're laughing at the same thing", weight: 2),
    QuestionOption("When we're comfortable in silence", weight: 2),
    QuestionOption("When we share something vulnerable", weight: 3),
    QuestionOption("When there's physical touch", weight: 3),
  ]),
  GameQuestion(branch: QuestionBranch.romantic, level: 2, text: "What's something small I do that you like?", options: [
    QuestionOption("The way you listen", weight: 2),
    QuestionOption("Your laugh", weight: 2),
    QuestionOption("How you look at me", weight: 3),
    QuestionOption("I'll tell you later", weight: 3),
  ]),

  // Level 3
  GameQuestion(branch: QuestionBranch.romantic, level: 3, text: "What's a memory of us that you love?", options: [
    QuestionOption("Our first conversation", weight: 2),
    QuestionOption("That time we got lost together", weight: 3),
    QuestionOption("A quiet moment nobody saw", weight: 3),
    QuestionOption("Tonight, so far", weight: 4),
  ]),
  // Action-first question
  GameQuestion(branch: QuestionBranch.romantic, level: 3, text: "Take their hand. Now: what does this touch make you feel?", type: QuestionType.actionFirst, instruction: "Take their hand and hold it for 10 seconds.", options: [
    QuestionOption("Safe", weight: 2),
    QuestionOption("Excited", weight: 3),
    QuestionOption("Like I never want to let go", weight: 4),
    QuestionOption("Everything", weight: 4),
  ]),

  // Level 4
  GameQuestion(branch: QuestionBranch.romantic, level: 4, text: "What's something you want us to do together soon?", options: [
    QuestionOption("A weekend trip", weight: 3),
    QuestionOption("Just more nights like this", weight: 3),
    QuestionOption("Something we've never done before", weight: 4),
    QuestionOption("Wake up next to each other", weight: 5),
  ]),

  // Level 5
  GameQuestion(branch: QuestionBranch.romantic, level: 5, text: "What's the most romantic thing you can imagine us doing?", options: [
    QuestionOption("Dancing in the kitchen", weight: 3),
    QuestionOption("Watching the sunrise together", weight: 4),
    QuestionOption("Getting lost in a city we don't know", weight: 4),
    QuestionOption("Whatever we're doing right now, forever", weight: 5),
  ]),
];

// ─── SPICY BRANCH ──────────────────────────────────────────────────────────

final List<GameQuestion> spicyQuestions = [
  // Level 1
  GameQuestion(branch: QuestionBranch.spicy, level: 1, text: "What's the first thing you noticed about me physically?", options: [
    QuestionOption("Your eyes", weight: 2),
    QuestionOption("Your smile", weight: 2),
    QuestionOption("Your body", weight: 3),
    QuestionOption("The way you move", weight: 3),
  ]),
  GameQuestion(branch: QuestionBranch.spicy, level: 1, text: "What kind of outfit drives you crazy?", options: [
    QuestionOption("Something simple but fitted", weight: 2),
    QuestionOption("Something that shows confidence", weight: 3),
    QuestionOption("Less is more", weight: 4),
    QuestionOption("I'll show you later", weight: 4),
  ]),

  // Level 2
  GameQuestion(branch: QuestionBranch.spicy, level: 2, text: "What's your favorite place to be kissed?", options: [
    QuestionOption("The neck", weight: 3),
    QuestionOption("The lips, obviously", weight: 2),
    QuestionOption("Somewhere unexpected", weight: 4),
    QuestionOption("I'll let you guess", weight: 4),
  ]),
  // Mirror question
  GameQuestion(branch: QuestionBranch.spicy, level: 2, text: "What do you think I'm imagining right now?", type: QuestionType.mirror, options: [
    QuestionOption("Something innocent", weight: 2),
    QuestionOption("Kissing me", weight: 4),
    QuestionOption("Something we shouldn't say out loud", weight: 5),
    QuestionOption("The same thing I am", weight: 4),
  ]),

  // Level 3
  GameQuestion(branch: QuestionBranch.spicy, level: 3, text: "What's something you've wanted to do to me since we met?", options: [
    QuestionOption("Kiss you", weight: 4),
    QuestionOption("Touch you", weight: 4),
    QuestionOption("Something I can't say here", weight: 5),
    QuestionOption("Everything", weight: 5),
  ]),
  // Silent question
  GameQuestion(branch: QuestionBranch.spicy, level: 3, text: "Look at their lips. Don't say anything for 10 seconds.", type: QuestionType.silent, instruction: "Look at their lips. Don't say anything for 10 seconds.", options: [
    QuestionOption("I'm thinking about kissing them", weight: 4),
    QuestionOption("I'm wondering what they taste like", weight: 5),
    QuestionOption("I'm waiting for them to make the first move", weight: 4),
    QuestionOption("I'm already imagining it", weight: 5),
  ]),

  // Level 4
  GameQuestion(branch: QuestionBranch.spicy, level: 4, text: "What's your biggest turn-on?", options: [
    QuestionOption("Confidence", weight: 3),
    QuestionOption("Touch", weight: 4),
    QuestionOption("Being wanted", weight: 5),
    QuestionOption("You", weight: 5),
  ]),

  // Level 5
  GameQuestion(branch: QuestionBranch.spicy, level: 5, text: "If we were alone right now, what would you do?", options: [
    QuestionOption("Kiss you immediately", weight: 5),
    QuestionOption("Take my time", weight: 5),
    QuestionOption("Let you take control", weight: 5),
    QuestionOption("I already have a plan", weight: 5),
  ]),
];

// ─── DEEP BRANCH ───────────────────────────────────────────────────────────

final List<GameQuestion> deepQuestions = [
  // Level 1
  GameQuestion(branch: QuestionBranch.deep, level: 1, text: "What's something most people don't know about you?", options: [
    QuestionOption("I'm more sensitive than I look", weight: 2),
    QuestionOption("I think about the future more than the present", weight: 2),
    QuestionOption("I'm afraid of being vulnerable", weight: 3),
    QuestionOption("I want more than I let on", weight: 3),
  ]),
  GameQuestion(branch: QuestionBranch.deep, level: 1, text: "What's the best compliment you've ever received?", options: [
    QuestionOption("That I'm kind", weight: 1),
    QuestionOption("That I'm intense", weight: 2),
    QuestionOption("That I make people feel seen", weight: 3),
    QuestionOption("That I'm unforgettable", weight: 3),
  ]),

  // Level 2
  GameQuestion(branch: QuestionBranch.deep, level: 2, text: "What's something you're afraid to want?", options: [
    QuestionOption("To be truly known", weight: 3),
    QuestionOption("To want someone this much", weight: 4),
    QuestionOption("To be happy", weight: 3),
    QuestionOption("To ask for what I really need", weight: 4),
  ]),
  // Mirror question
  GameQuestion(branch: QuestionBranch.deep, level: 2, text: "What do you think is my biggest fear?", type: QuestionType.mirror, options: [
    QuestionOption("Being alone", weight: 2),
    QuestionOption("Not being enough", weight: 3),
    QuestionOption("Getting hurt", weight: 3),
    QuestionOption("Never finding what we have right now", weight: 4),
  ]),

  // Level 3
  GameQuestion(branch: QuestionBranch.deep, level: 3, text: "What does love mean to you?", options: [
    QuestionOption("Being there, always", weight: 2),
    QuestionOption("Choosing each other every day", weight: 3),
    QuestionOption("Feeling safe enough to be real", weight: 4),
    QuestionOption("Everything we're building right now", weight: 4),
  ]),
  // Action-first
  GameQuestion(branch: QuestionBranch.deep, level: 3, text: "Look into their eyes. Say one thing you appreciate about them.", type: QuestionType.actionFirst, instruction: "Look into their eyes. Say one thing you appreciate about them.", options: [
    QuestionOption("Their honesty", weight: 2),
    QuestionOption("Their presence", weight: 3),
    QuestionOption("How they make me feel", weight: 4),
    QuestionOption("Everything", weight: 4),
  ]),

  // Level 4
  GameQuestion(branch: QuestionBranch.deep, level: 4, text: "What's something you've never told anyone?", options: [
    QuestionOption("A secret I keep", weight: 3),
    QuestionOption("A regret", weight: 4),
    QuestionOption("A dream I'm afraid to say out loud", weight: 4),
    QuestionOption("How much this means to me", weight: 5),
  ]),

  // Level 5
  GameQuestion(branch: QuestionBranch.deep, level: 5, text: "If you could guarantee one thing about our future, what would it be?", options: [
    QuestionOption("That we keep talking like this", weight: 4),
    QuestionOption("That we stay curious about each other", weight: 4),
    QuestionOption("That we never stop choosing each other", weight: 5),
    QuestionOption("That tonight is just the beginning", weight: 5),
  ]),
];

// ─── COMBINED LIST (for easy access) ───────────────────────────────────────

List<GameQuestion> getQuestionsForBranch(QuestionBranch branch) {
  switch (branch) {
    case QuestionBranch.romantic:
      return romanticQuestions;
    case QuestionBranch.spicy:
      return spicyQuestions;
    case QuestionBranch.deep:
      return deepQuestions;
  }
}
