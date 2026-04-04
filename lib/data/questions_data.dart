import '../models/game_question.dart';

/// Intensity levels 1-5
/// 1-2 = connection/getting to know (the natural path toward hot)
/// 3   = personal/intimate
/// 4   = hot
/// 5   = very hot

final List<GameQuestion> allQuestions = [

  // ─── LEVEL 1 — Connection starters ───────────────────────────────────────
  GameQuestion(1, "What made you want to come tonight?", [
    QuestionOption("Curiosity about you", weight: 1),
    QuestionOption("I needed a good night out", weight: 1),
    QuestionOption("Something about you caught my attention", weight: 2),
    QuestionOption("Honestly? Instinct", weight: 2),
  ]),
  GameQuestion(1, "What's the first thing you noticed about me?", [
    QuestionOption("Your energy when you walked in", weight: 2),
    QuestionOption("Something physical", weight: 3),
    QuestionOption("The way you smiled", weight: 2),
    QuestionOption("I'll tell you later", weight: 3),
  ]),
  GameQuestion(1, "What kind of night were you hoping for?", [
    QuestionOption("Good conversation", weight: 1),
    QuestionOption("Something unexpected", weight: 2),
    QuestionOption("A connection — real one", weight: 2),
    QuestionOption("Whatever happens, happens", weight: 3),
  ]),
  GameQuestion(1, "What's something most people don't know about you right away?", [
    QuestionOption("How intense I can be", weight: 2),
    QuestionOption("How much I observe people", weight: 1),
    QuestionOption("That I take time to open up", weight: 1),
    QuestionOption("How much I want when I want something", weight: 3),
  ]),
  GameQuestion(1, "What do you think makes a first date actually good?", [
    QuestionOption("Real conversation, no small talk", weight: 1),
    QuestionOption("Tension — the good kind", weight: 3),
    QuestionOption("When you forget what time it is", weight: 2),
    QuestionOption("Feeling like yourself and more at the same time", weight: 2),
  ]),
  GameQuestion(1, "How do you know when you're actually attracted to someone?", [
    QuestionOption("I pay attention to everything they do", weight: 2),
    QuestionOption("I want to be near them without a reason", weight: 2),
    QuestionOption("My body responds before my brain does", weight: 3),
    QuestionOption("I start thinking about them when they're not around", weight: 2),
  ]),
  GameQuestion(1, "What's something small that says a lot about a person?", [
    QuestionOption("How they treat people they don't need to impress", weight: 1),
    QuestionOption("The way they use their hands when they talk", weight: 2),
    QuestionOption("Eye contact — or lack of it", weight: 2),
    QuestionOption("What they laugh at", weight: 1),
  ]),
  GameQuestion(1, "What's the best compliment someone could give you right now?", [
    QuestionOption("That I'm magnetic without trying", weight: 2),
    QuestionOption("That I make people feel seen", weight: 1),
    QuestionOption("That I'm exactly the kind of person they didn't expect", weight: 2),
    QuestionOption("That I'm hard to forget", weight: 3),
  ]),

  // ─── LEVEL 2 — Getting warmer ─────────────────────────────────────────────
  GameQuestion(2, "What's the most attractive thing someone can do in a conversation?", [
    QuestionOption("Look at me like what I say matters", weight: 2),
    QuestionOption("Say something I didn't expect", weight: 2),
    QuestionOption("Make me feel the tension without saying anything", weight: 3),
    QuestionOption("Be honest about something most people wouldn't admit", weight: 2),
  ]),
  GameQuestion(2, "What do you find irresistible about someone?", [
    QuestionOption("Confidence that isn't loud", weight: 2),
    QuestionOption("The way they move", weight: 3),
    QuestionOption("When they make me feel like the only person in the room", weight: 2),
    QuestionOption("A voice that does something to me", weight: 3),
  ]),
  GameQuestion(2, "What's something you notice about someone before anything else?", [
    QuestionOption("Their mouth", weight: 3),
    QuestionOption("Their hands", weight: 2),
    QuestionOption("Their eyes", weight: 2),
    QuestionOption("The way they hold themselves", weight: 2),
  ]),
  GameQuestion(2, "How do you show someone you're interested without saying it?", [
    QuestionOption("I find reasons to be close", weight: 3),
    QuestionOption("I pay attention to details they mention", weight: 1),
    QuestionOption("I mirror them without thinking", weight: 2),
    QuestionOption("I hold eye contact a second too long", weight: 3),
  ]),
  GameQuestion(2, "What's something about tonight that's already working?", [
    QuestionOption("The conversation — it's real", weight: 2),
    QuestionOption("The energy between us", weight: 3),
    QuestionOption("That I'm not thinking about being anywhere else", weight: 2),
    QuestionOption("Something I'm not saying out loud yet", weight: 3),
  ]),
  GameQuestion(2, "What kind of energy do you bring when you really like someone?", [
    QuestionOption("Calm outside, burning inside", weight: 3),
    QuestionOption("I get very present — all attention on them", weight: 2),
    QuestionOption("Playful, a little dangerous", weight: 3),
    QuestionOption("Warm, like I want to pull them in", weight: 2),
  ]),
  GameQuestion(2, "What would make you lean in right now?", [
    QuestionOption("If they said something that surprised me", weight: 2),
    QuestionOption("If they moved closer", weight: 3),
    QuestionOption("If they looked at me the right way", weight: 3),
    QuestionOption("If the conversation went somewhere real", weight: 2),
  ]),
  GameQuestion(2, "What's your love language — and do you think I've hit it yet?", [
    QuestionOption("Touch. And you're getting closer.", weight: 4),
    QuestionOption("Words. You're saying the right things.", weight: 2),
    QuestionOption("Presence. You've had mine all night.", weight: 2),
    QuestionOption("Ask me again at the end of the night.", weight: 3),
  ]),

  // ─── LEVEL 3 — Personal & intimate ───────────────────────────────────────
  GameQuestion(3, "What's something small that turns you on instantly?", [
    QuestionOption("Eye contact that lasts too long", weight: 3),
    QuestionOption("A confident touch — casual but intentional", weight: 4),
    QuestionOption("A voice that drops just slightly", weight: 3),
    QuestionOption("When someone smells right", weight: 3),
  ]),
  GameQuestion(3, "What's the difference between attraction and chemistry to you?", [
    QuestionOption("Attraction is physical. Chemistry is when I can't stop thinking about them.", weight: 3),
    QuestionOption("When both are there at the same time, I stop being careful.", weight: 4),
    QuestionOption("Chemistry is attraction that makes me forget myself a little.", weight: 3),
    QuestionOption("I don't separate them — when it's real, it's both.", weight: 3),
  ]),
  GameQuestion(3, "What kind of touch do you like most?", [
    QuestionOption("Slow and deliberate", weight: 4),
    QuestionOption("Something that starts innocent and isn't", weight: 5),
    QuestionOption("When it's unexpected and right", weight: 4),
    QuestionOption("When it says more than words would", weight: 3),
  ]),
  GameQuestion(3, "What's something you want right now that you haven't said out loud?", [
    QuestionOption("To know what they're actually thinking", weight: 3),
    QuestionOption("For this tension to go somewhere", weight: 4),
    QuestionOption("To be closer than we are", weight: 4),
    QuestionOption("For the night not to end yet", weight: 3),
  ]),
  GameQuestion(3, "What does intimacy mean to you?", [
    QuestionOption("Feeling wanted, not just desired", weight: 3),
    QuestionOption("Being close enough that nothing else matters", weight: 4),
    QuestionOption("The moment just before — and the one just after", weight: 4),
    QuestionOption("When I stop performing and just feel", weight: 3),
  ]),
  GameQuestion(3, "What's the boldest move someone's ever made on you?", [
    QuestionOption("They told me directly what they wanted", weight: 4),
    QuestionOption("They touched me before asking", weight: 5),
    QuestionOption("They closed the distance without warning", weight: 4),
    QuestionOption("They said something that made it impossible to pretend", weight: 3),
  ]),
  GameQuestion(3, "When do you feel most desirable?", [
    QuestionOption("When someone can't stop looking", weight: 3),
    QuestionOption("When I can feel the tension and I know I'm causing it", weight: 4),
    QuestionOption("When someone forgets what they were saying", weight: 4),
    QuestionOption("When I'm wanted in a way that's hard to hide", weight: 4),
  ]),
  GameQuestion(3, "What do you want someone to notice about you that they haven't yet?", [
    QuestionOption("How much I'm holding back", weight: 4),
    QuestionOption("That I want this more than I'm showing", weight: 4),
    QuestionOption("What I look like when I stop being careful", weight: 5),
    QuestionOption("That I'm thinking about them more than I should be", weight: 4),
  ]),

  // ─── LEVEL 4 — Hot ───────────────────────────────────────────────────────
  GameQuestion(4, "What's something you'd want to happen after tonight?", [
    QuestionOption("To see where this goes", weight: 4),
    QuestionOption("For this not to be the last time", weight: 4),
    QuestionOption("Something I'd rather show than say", weight: 5),
    QuestionOption("More of this — whatever this is", weight: 4),
  ]),
  GameQuestion(4, "What's the thing about me tonight that made you the most…?", [
    QuestionOption("Curious", weight: 3),
    QuestionOption("Attracted", weight: 4),
    QuestionOption("Wanting to get closer", weight: 5),
    QuestionOption("Something I'm keeping to myself", weight: 4),
  ]),
  GameQuestion(4, "If you could say one thing to me right now without consequence, what would it be?", [
    QuestionOption("That I've been thinking about kissing you", weight: 5),
    QuestionOption("That tonight is going exactly where I wanted", weight: 4),
    QuestionOption("What I want to do next", weight: 5),
    QuestionOption("Something honest that I'd never usually say this early", weight: 4),
  ]),
  GameQuestion(4, "What's your idea of a perfect ending to tonight?", [
    QuestionOption("Not ending it yet", weight: 4),
    QuestionOption("Something I'll think about tomorrow", weight: 5),
    QuestionOption("A moment we don't need to explain", weight: 5),
    QuestionOption("Whatever feels right — and I have a feeling about what that is", weight: 5),
  ]),
  GameQuestion(4, "What's something you find attractive that you wouldn't usually admit?", [
    QuestionOption("When someone takes what they want, gently", weight: 5),
    QuestionOption("Being wanted so much it's hard to hide", weight: 4),
    QuestionOption("A certain kind of tension right before something happens", weight: 5),
    QuestionOption("Being looked at like I'm the only person in the room", weight: 4),
  ]),
  GameQuestion(4, "What's the most honest thing you could say about how you feel right now?", [
    QuestionOption("More interested than I expected", weight: 4),
    QuestionOption("Like I want this to go further", weight: 5),
    QuestionOption("Attracted in a way that's getting harder to ignore", weight: 5),
    QuestionOption("Like tonight might be something I remember", weight: 4),
  ]),

  // ─── LEVEL 5 — Very hot ──────────────────────────────────────────────────
  GameQuestion(5, "What would you want me to do right now if nothing was off limits?", [
    QuestionOption("Stay exactly this close", weight: 4),
    QuestionOption("Close the distance", weight: 5),
    QuestionOption("Something I'm not going to say out loud", weight: 5),
    QuestionOption("Kiss me", weight: 5),
  ]),
  GameQuestion(5, "What's the thing you want most that you haven't asked for yet tonight?", [
    QuestionOption("To feel you closer", weight: 5),
    QuestionOption("A kiss. Just one — and see what happens.", weight: 5),
    QuestionOption("For you to stop waiting", weight: 5),
    QuestionOption("The same thing you want", weight: 5),
  ]),
  GameQuestion(5, "What would it take for you to make a move right now?", [
    QuestionOption("You already have", weight: 5),
    QuestionOption("Nothing. I'm about to.", weight: 5),
    QuestionOption("Eye contact. Real eye contact.", weight: 4),
    QuestionOption("For you to want it as much as I do", weight: 5),
  ]),
  GameQuestion(5, "If this night could end any way you wanted, what happens next?", [
    QuestionOption("We stay until they close this place", weight: 3),
    QuestionOption("We find somewhere quieter", weight: 5),
    QuestionOption("You already know the answer", weight: 5),
    QuestionOption("Something that starts with a kiss and doesn't end there", weight: 5),
  ]),
];
