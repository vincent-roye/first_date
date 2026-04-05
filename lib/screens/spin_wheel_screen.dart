import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class SpinWheelScreen extends StatefulWidget {
  final VoidCallback onQuestion;
  final VoidCallback onAction;
  final VoidCallback onWildCard;

  const SpinWheelScreen({
    super.key,
    required this.onQuestion,
    required this.onAction,
    required this.onWildCard,
  });

  @override
  State<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  double _currentAngle = 0.0;
  bool _isSpinning = false;
  bool _isPointerActive = false;

  final List<String> _segments = ['Question', 'Action', 'Wild Card'];
  final List<Color> _colors = [
    const Color(0xFF4FC3F7), // Blue
    AppColors.accent,        // Rose
    const Color(0xFFAB9CFF), // Purple
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _spin() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
      _isPointerActive = true;
    });

    // Pre-spin haptic - triple tap for anticipation
    HapticFeedback.mediumImpact();
    Future.delayed(const Duration(milliseconds: 80), () => HapticFeedback.lightImpact());
    _pulseController.forward().then((_) => _pulseController.reverse());

    final random = math.Random();
    final spins = 6 + random.nextDouble() * 6;
    final finalAngle = random.nextDouble() * 2 * math.pi;

    var lastTick = 0.0;
    final totalRotation = spins * 2 * math.pi + finalAngle;

    // Add a listener to the animation itself - haptic ticks on each segment
    final animation = Tween<double>(begin: 0, end: totalRotation).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    animation.addListener(() {
      final current = animation.value;
      final segmentAngle = 2 * math.pi / _segments.length;
      // Trigger haptic on each segment boundary (creates ticking effect)
      if ((current - lastTick) > segmentAngle) {
        HapticFeedback.selectionClick(); // Lighter tick for web compatibility
        lastTick = current;
      }
    });

    _controller.forward(from: 0).whenComplete(() {
      setState(() {
        _isSpinning = false;
        _currentAngle = finalAngle;
      });
      _determineResult(finalAngle);
    });
  }

  void _determineResult(double angle) {
    final normalized = (2 * math.pi - (angle % (2 * math.pi))) % (2 * math.pi);
    final segmentSize = (2 * math.pi) / 3;
    final index = ((normalized + math.pi / 2) % (2 * math.pi) / segmentSize).floor();
    final result = _segments[index % 3];

    // Success haptics - graduated pattern for feedback
    HapticFeedback.heavyImpact();
    Future.delayed(const Duration(milliseconds: 80), () => HapticFeedback.mediumImpact());
    Future.delayed(const Duration(milliseconds: 160), () => HapticFeedback.lightImpact());

    setState(() => _isPointerActive = false);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (result == 'Question') widget.onQuestion();
      else if (result == 'Action') widget.onAction();
      else widget.onWildCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Spin the wheel.',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 48),

            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: _spin,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value *
                            (6 * 2 * math.pi +
                                (_currentAngle != 0.0
                                    ? _currentAngle
                                    : 0)),
                        child: CustomPaint(
                          size: const Size(300, 300),
                          painter: WheelPainter(_segments, _colors),
                        ),
                      );
                    },
                  ),
                ),
                // Top Pointer with enhanced animation
                Positioned(
                  top: -10,
                  child: AnimatedBuilder(
                    animation: Listenable.merge([_pulseAnimation, _controller]),
                    builder: (context, child) {
                      final isLanding = !_isSpinning && _controller.isCompleted;
                      final basePulse = isLanding ? 1.15 : _pulseAnimation.value;
                      return Transform.scale(
                        scale: basePulse,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: _isSpinning
                                ? Colors.white
                                : _isPointerActive
                                    ? const Color(0xFF4FC3F7).withOpacity(0.9)
                                    : const Color(0xFF4FC3F7),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _isSpinning ? AppColors.accent : Colors.white,
                              width: _isSpinning ? 5 : 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _isSpinning
                                    ? AppColors.accent.withOpacity(0.5)
                                    : _isPointerActive
                                        ? Colors.white.withOpacity(0.6)
                                        : Colors.black26,
                                blurRadius: _isSpinning ? 24 : 16,
                                spreadRadius: _isSpinning ? 6 : 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            _isSpinning ? Icons.autorenew_rounded : Icons.arrow_downward_rounded,
                            color: _isSpinning ? AppColors.accent : const Color(0xFF1E1E2E),
                            size: _isSpinning ? 24 : 28,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 48),

            if (!_isSpinning)
              Text(
                'Tap to spin',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<String> segments;
  final List<Color> colors;

  WheelPainter(this.segments, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final anglePerSegment = (2 * math.pi) / segments.length;

    // Shadow ring
    final shadowPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawCircle(center, radius + 5, shadowPaint);

    for (int i = 0; i < segments.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * anglePerSegment,
        anglePerSegment,
        true,
        paint,
      );

      // Border
      final borderPaint = Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * anglePerSegment,
        anglePerSegment,
        true,
        borderPaint,
      );

      // Text
      final textPainter = TextPainter(
        text: TextSpan(
          text: segments[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final angle = i * anglePerSegment + anglePerSegment / 2;
      final textOffset = Offset(
        center.dx + (radius * 0.62) * math.cos(angle) - textPainter.width / 2,
        center.dy + (radius * 0.62) * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }

    // Center dot
    canvas.drawCircle(
        center, 12, Paint()..color = Colors.white..style = PaintingStyle.fill);
    canvas.drawCircle(center, 8,
        Paint()..color = const Color(0xFF1E1E2E)..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
