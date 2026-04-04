import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../models/game_action.dart';

class ActionScreen extends StatefulWidget {
  final GameAction action;
  const ActionScreen({super.key, required this.action});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  Color get _accentColor {
    final lvl = widget.action.level;
    if (lvl <= 1) return const Color(0xFF9C8FE8);
    if (lvl == 2) return const Color(0xFFFFB74D);
    if (lvl == 3) return const Color(0xFFFF7043);
    return AppColors.accent;
  }

  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _scale = Tween<double>(begin: 0.9, end: 1)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 360, height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  _accentColor.withOpacity(0.12),
                  Colors.transparent,
                ]),
              ),
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Spice indicator — minimal
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: _accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppRadius.chip),
                          border: Border.all(color: _accentColor.withOpacity(0.25)),
                        ),
                        child: Text(
                          ['🌶️', '🌶️🌶️', '🌶️🌶️🌶️', '🌶️🌶️🌶️🌶️', '🌶️🌶️🌶️🌶️🌶️']
                              [(widget.action.level - 1).clamp(0, 4)],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),

                      const SizedBox(height: 28),

                      Text(
                        widget.action.text,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Take your time. No pressure.',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textDisabled,
                        ),
                      ),

                      const SizedBox(height: 52),

                      // We did it
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          width: double.infinity, height: 56,
                          decoration: BoxDecoration(
                            color: _accentColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(AppRadius.button),
                            border: Border.all(color: _accentColor.withOpacity(0.35)),
                          ),
                          child: Center(
                            child: Text('We did it ✓',
                              style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w600,
                                color: _accentColor,
                              )),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Pass — very ghost
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context, false);
                        },
                        child: SizedBox(
                          width: double.infinity, height: 48,
                          child: Center(
                            child: Text('Pass',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.textDisabled,
                              )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
