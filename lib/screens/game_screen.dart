import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../models/question_branch.dart';
import '../models/game_session.dart';
import '../data/questions_data.dart';
import '../data/actions_data.dart';
import 'action_screen.dart';
import 'results_screen.dart';
import 'branch_selection_screen.dart';

class GameScreen extends StatefulWidget {
  final QuestionBranch? selectedBranch;
  const GameScreen({super.key, this.selectedBranch});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final GameSession _session = GameSession();
  late QuestionBranch _currentBranch;
  late Map<int, List<GameQuestion>> _pools;
  late Map<int, int> _poolIndex;
  int _questionIndex = 0;

  int _phase = 0; // 0 = Person A, 1 = Person B, 2 = direction/branch switch
  int? _selectedA;
  int? _selectedB;
  GameQuestion? _currentQuestion;

  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _currentBranch = widget.selectedBranch ?? QuestionBranch.romantic;
    _session.currentBranch = _currentBranch;
    _loadBranch(_currentBranch);
    _currentQuestion = _nextQuestion();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 260));
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  void _loadBranch(QuestionBranch branch) {
    final questions = getQuestionsForBranch(branch);
    _pools = {};
    _poolIndex = {};
    for (int lvl = 1; lvl <= 5; lvl++) {
      _pools[lvl] = questions.where((q) => q.level == lvl).toList()..shuffle();
      _poolIndex[lvl] = 0;
    }
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  GameQuestion _nextQuestion() {
    final lvl = _session.currentLevel;
    final pool = _pools[lvl]!;
    if (_poolIndex[lvl]! >= pool.length) {
      pool.shuffle();
      _poolIndex[lvl] = 0;
    }
    final q = pool[_poolIndex[lvl]!];
    _poolIndex[lvl] = _poolIndex[lvl]! + 1;
    return q;
  }

  Future<void> _transition(VoidCallback change) async {
    await _fadeCtrl.reverse();
    setState(change);
    _fadeCtrl.forward();
  }

  void _onSelect(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_phase == 0) _selectedA = index;
      else _selectedB = index;
    });
  }

  void _onConfirm() async {
    if (_phase == 0) {
      if (_selectedA == null) return;
      HapticFeedback.lightImpact();
      await _transition(() => _phase = 1);
    } else {
      if (_selectedB == null) return;
      HapticFeedback.lightImpact();
      final q = _currentQuestion!;
      _session.addQuestionScore(
        q.options[_selectedA!].weight + q.options[_selectedB!].weight,
        q.branch,
      );
      _questionIndex++;

      if (_session.shouldTriggerAction) {
        final action = ActionLibrary.getRandomAction(_session.currentLevel);
        await _fadeCtrl.reverse();
        if (!mounted) return;
        final result = await Navigator.push<bool>(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ActionScreen(action: action),
            transitionDuration: const Duration(milliseconds: 350),
            transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
          ),
        );
        if (!mounted) return;
        if (result == true) _session.actionCompleted(action);
        else _session.actionPassed(action);
      }

      await _transition(() => _phase = 2);
    }
  }

  void _onBack() async {
    if (_phase == 1) {
      await _transition(() { _phase = 0; _selectedB = null; });
    }
  }

  void _onDirection(bool spicier) async {
    if (spicier) _session.goSpicier();
    else _session.goMilder();
    HapticFeedback.mediumImpact();
    if (_questionIndex >= 20) { _goToResults(); return; }
    await _transition(() {
      _currentQuestion = _nextQuestion();
      _selectedA = null; _selectedB = null; _phase = 0;
    });
  }

  void _onChangeBranch() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const BranchSelectionScreen(),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
      ),
    );
  }

  void _goToResults() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ResultsScreen(session: _session),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
      ),
    );
  }

  Color _accentForLevel(int lvl) {
    if (lvl <= 1) return const Color(0xFF9C8FE8);
    if (lvl == 2) return const Color(0xFFFFB74D);
    if (lvl == 3) return const Color(0xFFFF7043);
    return AppColors.accent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fade,
        child: _phase == 2 ? _buildDirection() : _buildAnswerScreen(_phase == 0),
      ),
    );
  }

  Widget _buildAnswerScreen(bool isA) {
    final q = _currentQuestion!;
    final personColor = isA ? AppColors.accent : AppColors.accentSoft;
    final selected = isA ? _selectedA : _selectedB;
    final canConfirm = selected != null;
    final qAccent = _accentForLevel(q.level);
    final isMirror = q.type == QuestionType.mirror;
    final isActionFirst = q.type == QuestionType.actionFirst;
    final isSilent = q.type == QuestionType.silent;

    String questionText = q.text;
    if (isMirror) questionText = "What do you think ${isA ? 'Person B' : 'Person A'} will answer?";
    if (isActionFirst) questionText = q.instruction ?? q.text;
    if (isSilent) questionText = q.instruction ?? q.text;

    return SafeArea(
      child: Column(
        children: [
          // ── Top bar ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 16, 0),
            child: Row(children: [
              IconButton(
                icon: Icon(
                  _phase == 1 ? Icons.arrow_back_ios_new_rounded : Icons.close_rounded,
                  size: 18,
                ),
                color: AppColors.textDisabled,
                onPressed: _phase == 1 ? _onBack : () => Navigator.pop(context),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: (_questionIndex + 1) / 20,
                    backgroundColor: AppColors.surfaceElevated,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _accentForLevel(_session.currentLevel),
                    ),
                    minHeight: 3,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${_questionIndex + 1}/20',
                style: GoogleFonts.inter(fontSize: 12, color: AppColors.textDisabled),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: _goToResults,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text('End',
                    style: GoogleFonts.inter(fontSize: 13, color: AppColors.textDisabled)),
                ),
              ),
            ]),
          ),

          // ── Question card ────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: qAccent.withOpacity(0.2), width: 1),
              ),
              child: Column(
                children: [
                  // Spice dots — subtle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                      width: 5, height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < q.level
                            ? qAccent.withOpacity(0.7)
                            : AppColors.borderSubtle,
                      ),
                    )),
                  ),
                  const SizedBox(height: 14),
                  Text(q.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      height: 1.45,
                    )),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ── Person label ─────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(children: [
              Container(
                width: 6, height: 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: personColor),
              ),
              const SizedBox(width: 8),
              Text(
                isA ? 'Person A' : 'Person B',
                style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w500, color: personColor,
                ),
              ),
              const SizedBox(width: 8),
              Text('— say it out loud first',
                style: GoogleFonts.inter(fontSize: 12, color: AppColors.textDisabled)),
            ]),
          ),

          const SizedBox(height: 10),

          // ── Options ──────────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: q.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final isSel = selected == i;
                return GestureDetector(
                  onTap: () => _onSelect(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                    decoration: BoxDecoration(
                      color: isSel
                          ? personColor.withOpacity(0.12)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.button),
                      border: Border.all(
                        color: isSel
                            ? personColor.withOpacity(0.45)
                            : AppColors.borderSubtle,
                        width: 1,
                      ),
                    ),
                    child: Text(q.options[i].text,
                      style: GoogleFonts.inter(
                        fontSize: 15, height: 1.35,
                        color: isSel ? AppColors.textPrimary : AppColors.textSecondary,
                        fontWeight: isSel ? FontWeight.w500 : FontWeight.w400,
                      )),
                  ),
                );
              },
            ),
          ),

          // ── CTA ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: _ConfirmButton(
              label: isA ? 'Pass to Person B →' : 'Continue →',
              color: personColor,
              enabled: canConfirm,
              onTap: canConfirm ? _onConfirm : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirection() {
    final lvl = _session.currentLevel;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Next?',
              style: GoogleFonts.playfairDisplay(
                fontSize: 36, fontWeight: FontWeight.w700,
                color: AppColors.textPrimary, height: 1.0,
              )),
            const SizedBox(height: 8),
            Text(_levelHint(lvl),
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),

            const SizedBox(height: 48),

            // Hotter — main CTA
            _ConfirmButton(
              label: '🌶️  Turn it up',
              color: AppColors.accent,
              enabled: true,
              onTap: () => _onDirection(true),
              height: 62,
              fontSize: 17,
            ),

            const SizedBox(height: 12),

            // Keep it easy — ghost button, less prominent
            GestureDetector(
              onTap: () => _onDirection(false),
              child: Container(
                width: double.infinity, height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Center(
                  child: Text('Keep it easy',
                    style: GoogleFonts.inter(
                      fontSize: 15, color: AppColors.textDisabled,
                      fontWeight: FontWeight.w400,
                    )),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Change vibe
            GestureDetector(
              onTap: _onChangeBranch,
              child: Container(
                width: double.infinity, height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Center(
                  child: Text('Change vibe →',
                    style: GoogleFonts.inter(
                      fontSize: 15, color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _levelHint(int lvl) {
    switch (lvl) {
      case 1: return 'Just getting started…';
      case 2: return 'Getting interesting';
      case 3: return 'Feeling the heat';
      case 4: return 'Things are getting real';
      default: return 'You\'re all the way in.';
    }
  }
}

// ─── Confirm button with scale animation ────────────────────────────────────

class _ConfirmButton extends StatefulWidget {
  final String label;
  final Color color;
  final bool enabled;
  final VoidCallback? onTap;
  final double height;
  final double fontSize;

  const _ConfirmButton({
    required this.label, required this.color,
    required this.enabled, this.onTap,
    this.height = 56, this.fontSize = 15,
  });

  @override
  State<_ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<_ConfirmButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.enabled && widget.onTap != null;
    return GestureDetector(
      onTapDown: active ? (_) => setState(() => _pressed = true) : null,
      onTapUp: active ? (_) {
        setState(() => _pressed = false);
        widget.onTap!();
      } : null,
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: active ? widget.color : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: Border.all(
              color: active ? Colors.transparent : AppColors.borderSubtle,
            ),
            boxShadow: (active && !_pressed) ? [
              BoxShadow(
                color: widget.color.withOpacity(0.25),
                blurRadius: 20, offset: const Offset(0, 6),
              ),
            ] : null,
          ),
          child: Center(
            child: Text(widget.label,
              style: GoogleFonts.inter(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : AppColors.textDisabled,
              )),
          ),
        ),
      ),
    );
  }
}
