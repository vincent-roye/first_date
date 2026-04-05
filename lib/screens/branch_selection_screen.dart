import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../models/question_branch.dart';
import '../services/revenue_cat_service.dart';
import 'paywall_screen.dart';
import 'game_screen.dart';

class BranchSelectionScreen extends StatefulWidget {
  const BranchSelectionScreen({super.key});

  @override
  State<BranchSelectionScreen> createState() => _BranchSelectionScreenState();
}

class _BranchSelectionScreenState extends State<BranchSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;
  bool _isPremium = false;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
    _checkPremium();
  }

  Future<void> _checkPremium() async {
    final premium = await RevenueCatService.isPremium();
    if (mounted) {
      setState(() { _isPremium = premium; });
    }
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectBranch(QuestionBranch branch) async {
    // Romantic is always free
    if (branch == QuestionBranch.romantic) {
      HapticFeedback.mediumImpact();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => GameScreen(selectedBranch: branch),
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
        ),
      );
      return;
    }

    if (!_isPremium) {
      final didUpgrade = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (_) => const PaywallScreen()),
      );
      if (didUpgrade == true) {
        await _checkPremium();
        _selectBranch(branch); // Retry after upgrade
      }
      return;
    }

    HapticFeedback.mediumImpact();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => GameScreen(selectedBranch: branch),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose your vibe.',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'What kind of night are you looking for?',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              _BranchCard(
                branch: QuestionBranch.romantic,
                description: 'Pour les connexions vraies et les moments doux.',
                color: const Color(0xFFAB9CFF),
                icon: '💜',
                onTap: () => _selectBranch(QuestionBranch.romantic),
              ),

              const SizedBox(height: 16),

              _BranchCard(
                branch: QuestionBranch.spicy,
                description: 'Pour les soirs où tu as pas envie de jouer.',
                color: AppColors.accent,
                icon: '🌶️',
                isLocked: !_isPremium,
                onTap: () => _selectBranch(QuestionBranch.spicy),
              ),

              const SizedBox(height: 16),

              _BranchCard(
                branch: QuestionBranch.deep,
                description: 'Pour aller là où les autres vont pas.',
                color: const Color(0xFF4FC3F7),
                icon: '🔮',
                isLocked: !_isPremium,
                onTap: () => _selectBranch(QuestionBranch.deep),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BranchCard extends StatefulWidget {
  final QuestionBranch branch;
  final String description;
  final Color color;
  final String icon;
  final bool isLocked;
  final VoidCallback onTap;

  const _BranchCard({
    required this.branch,
    required this.description,
    required this.color,
    required this.icon,
    required this.isLocked,
    required this.onTap,
  });

  @override
  State<_BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<_BranchCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 28),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: widget.isLocked ? AppColors.surfaceElevated : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: widget.isLocked 
                  ? AppColors.textDisabled.withOpacity(0.3)
                  : widget.color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.icon, 
                        style: TextStyle(
                          fontSize: 36,
                          color: widget.isLocked ? AppColors.textDisabled : null)),
                      const SizedBox(width: 16),
                      Text(
                        widget.branch.label,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: widget.isLocked ? AppColors.textDisabled : AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      if (widget.isLocked)
                        const Icon(Icons.lock, color: AppColors.textDisabled, size: 20),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: widget.isLocked ? AppColors.textDisabled : AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
