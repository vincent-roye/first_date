import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'game_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Subtle accent glow — top right only, restrained
          Positioned(
            top: -120, right: -80,
            child: Container(
              width: 320, height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.accent.withOpacity(0.10),
                  Colors.transparent,
                ]),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),

                // ── Hero ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo — minimal, not a glowing pill
                      Text('💋', style: const TextStyle(fontSize: 36)),

                      const SizedBox(height: AppSpacing.md),

                      // Serif display headline — gives personality
                      Text(
                        'First Date.',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.05,
                          letterSpacing: -1,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      // Sans-serif body — contrast with title
                      Text(
                        'Questions that actually\ngo somewhere.',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 2),

                // ── How it works — not a card, just spaced rows ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _Step('One question at a time — answer out loud.'),
                      SizedBox(height: 14),
                      _Step('Pick your closest answer on screen.'),
                      SizedBox(height: 14),
                      _Step('Choose where to go next — hotter or not.'),
                      SizedBox(height: 14),
                      _Step('Every few questions, a moment just for you two.'),
                    ],
                  ),
                ),

                const Spacer(flex: 1),

                // ── CTA — bottom, large, single ──────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
                  child: _StartButton(),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Center(
                    child: Text(
                      'One phone. No signup. No ads.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textDisabled,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String text;
  const _Step(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 5, height: 5,
          margin: const EdgeInsets.only(top: 8, right: 12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent,
          ),
        ),
        Expanded(
          child: Text(text,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.4,
            )),
        ),
      ],
    );
  }
}

class _StartButton extends StatefulWidget {
  @override
  State<_StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<_StartButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        HapticFeedback.mediumImpact();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const GameScreen(),
            transitionDuration: const Duration(milliseconds: 350),
            transitionsBuilder: (_, a, __, child) =>
                FadeTransition(opacity: a, child: child),
          ),
        );
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(AppRadius.button),
            boxShadow: _pressed ? [] : [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.28),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Start',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
