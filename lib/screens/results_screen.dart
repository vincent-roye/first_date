import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/game_session.dart';
import 'intro_screen.dart';

class ResultsScreen extends StatefulWidget {
  final GameSession session;
  const ResultsScreen({super.key, required this.session});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String get _headline {
    final lvl = widget.session.currentLevel;
    if (lvl >= 5) return 'You went all the way 🔥';
    if (lvl >= 4) return 'Things got intense ✨';
    if (lvl >= 3) return 'You went there 🌶️';
    return 'A good start 💫';
  }

  String get _subtext {
    final lvl = widget.session.currentLevel;
    if (lvl >= 5) return 'Whatever happens next — tonight happened first.';
    if (lvl >= 4) return 'That kind of honesty between two people is rare.';
    if (lvl >= 3) return 'You got somewhere real tonight.';
    return 'Next time, don\'t hold back.';
  }

  String _chilis(int lvl) =>
      ['🌶️', '🌶️🌶️', '🌶️🌶️🌶️', '🌶️🌶️🌶️🌶️', '🌶️🌶️🌶️🌶️🌶️'][(lvl - 1).clamp(0, 4)];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = widget.session;
    final spiceRatio = (s.spiceScore / 35).clamp(0.0, 1.0);

    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 48),

                      // ── Hero ──────────────────────────────
                      Center(child: Text('💋', style: const TextStyle(fontSize: 56))),
                      const SizedBox(height: 20),

                      Text(_headline,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 26, fontWeight: FontWeight.w800, color: cs.onSurface,
                        )),
                      const SizedBox(height: 8),
                      Text(_subtext,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 14, color: cs.onSurfaceVariant, height: 1.5)),

                      const SizedBox(height: 32),

                      // ── Stats card ────────────────────────
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Row stats
                              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                _StatItem('${s.questionCount}', 'questions', cs),
                                _StatItem(_chilis(s.currentLevel), 'intensity', cs),
                                _StatItem('${s.actionsDone.length}', 'moments ✅', cs),
                              ]),

                              const SizedBox(height: 20),

                              // Spice progress bar
                              Row(children: [
                                Text('🌶️', style: const TextStyle(fontSize: 16)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: LinearProgressIndicator(
                                      value: spiceRatio,
                                      backgroundColor: cs.surfaceContainerHighest,
                                      valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
                                      minHeight: 10,
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),

                      // ── Actions done ──────────────────────
                      if (s.actionsDone.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Moments',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12, color: cs.onSurfaceVariant,
                                    fontWeight: FontWeight.w600, letterSpacing: 0.5,
                                  )),
                                const SizedBox(height: 14),
                                ...s.actionsDone.map((a) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text('✅ ', style: const TextStyle(fontSize: 14)),
                                    Expanded(child: Text(a.text,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14, color: cs.onSurface, height: 1.4,
                                      ))),
                                  ]),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 32),

                      // ── Play again CTA ────────────────────
                      FilledButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const IntroScreen(),
                            transitionsBuilder: (_, a, __, child) =>
                                FadeTransition(opacity: a, child: child),
                          ),
                          (_) => false,
                        ),
                        child: Text('Play again',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),

                      const SizedBox(height: 40),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  final ColorScheme cs;
  const _StatItem(this.value, this.label, this.cs);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value,
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w800, color: cs.onSurface)),
      const SizedBox(height: 2),
      Text(label,
        style: GoogleFonts.poppins(fontSize: 11, color: cs.onSurfaceVariant)),
    ]);
  }
}
