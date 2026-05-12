import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) context.go('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 1.4,
            colors: [
              Color(0xFF2D6A4F), // primaryLight at centre
              Color(0xFF1B4332), // primary mid
              Color(0xFF0D2B1F), // deep dark edge
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Emblem ──────────────────────────────────────────
              SizedBox(
                width: 148,
                height: 148,
                child: CustomPaint(painter: _EmblemPainter()),
              ).animate().fadeIn(duration: 800.ms, curve: Curves.easeOut).scale(
                    begin: const Offset(0.65, 0.65),
                    duration: 900.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: 36),

              // ── App name ─────────────────────────────────────────
              Text(
                'KEBENA',
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 8,
                ),
              )
                  .animate(delay: 450.ms)
                  .fadeIn(duration: 700.ms)
                  .slideY(begin: 0.25, duration: 700.ms, curve: Curves.easeOut),

              const SizedBox(height: 8),

              // ── Subtitle ─────────────────────────────────────────
              Text(
                'H E R I T A G E',
                style: GoogleFonts.inter(
                  color: AppColors.gold,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 6,
                ),
              )
                  .animate(delay: 650.ms)
                  .fadeIn(duration: 700.ms)
                  .slideY(begin: 0.25, duration: 700.ms, curve: Curves.easeOut),

              const SizedBox(height: 52),

              // ── Ornament divider ─────────────────────────────────
              _OrnamentDivider()
                  .animate(delay: 900.ms)
                  .fadeIn(duration: 600.ms)
                  .scaleX(begin: 0.4, duration: 600.ms, curve: Curves.easeOut),

              const SizedBox(height: 22),

              Text(
                'Culture · History · Community',
                style: GoogleFonts.cormorantGaramond(
                  color: Colors.white.withValues(alpha: 0.45),
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                ),
              ).animate(delay: 1050.ms).fadeIn(duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrnamentDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _line(),
        const SizedBox(width: 12),
        _diamond(),
        const SizedBox(width: 8),
        _dot(),
        const SizedBox(width: 8),
        _diamond(),
        const SizedBox(width: 12),
        _line(),
      ],
    );
  }

  Widget _line() => Container(
        width: 36,
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gold.withValues(alpha: 0.0),
              AppColors.gold.withValues(alpha: 0.6),
            ],
          ),
        ),
      );

  Widget _diamond() => Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.7), width: 1),
          ),
        ),
      );

  Widget _dot() => Container(
        width: 5,
        height: 5,
        decoration: const BoxDecoration(
          color: AppColors.gold,
          shape: BoxShape.circle,
        ),
      );
}

// ── Emblem painter ────────────────────────────────────────────────────────────
class _EmblemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    // 1. Soft ambient glow
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.gold.withValues(alpha: 0.18),
            AppColors.gold.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r)),
    );

    // 2. Outer thin ring
    _strokeCircle(
        canvas, cx, cy, r - 1.5, AppColors.gold.withValues(alpha: 0.35), 1.0);

    // 3. Dashed decorative ring
    _dashedCircle(canvas, cx, cy, r * 0.88,
        AppColors.gold.withValues(alpha: 0.5), 1.0, 32);

    // 4. Gradient filled disc
    canvas.drawCircle(
      Offset(cx, cy),
      r * 0.76,
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0xFF3A7D5E), Color(0xFF1B4332)],
          stops: [0.0, 1.0],
        ).createShader(
            Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.76)),
    );

    // 5. Inner ring
    _strokeCircle(
        canvas, cx, cy, r * 0.76, AppColors.gold.withValues(alpha: 0.6), 1.2);

    // 6. Innermost thin ring
    _strokeCircle(
        canvas, cx, cy, r * 0.60, AppColors.gold.withValues(alpha: 0.25), 0.8);

    // 7. 8-pointed Islamic geometric star (outlined + filled)
    _drawStar(canvas, cx, cy, r * 0.48, r * 0.20, 8,
        fill: AppColors.gold.withValues(alpha: 0.15),
        stroke: AppColors.gold,
        strokeWidth: 1.4);

    // 8. Inner 8-pointed star (smaller, rotated 22.5°)
    _drawStar(canvas, cx, cy, r * 0.28, r * 0.12, 8,
        fill: AppColors.gold.withValues(alpha: 0.0),
        stroke: AppColors.gold.withValues(alpha: 0.55),
        strokeWidth: 0.9,
        rotationOffset: math.pi / 8);

    // 9. Center jewel
    canvas.drawCircle(
      Offset(cx, cy),
      r * 0.09,
      Paint()
        ..color = AppColors.gold
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      Offset(cx, cy),
      r * 0.05,
      Paint()
        ..color = const Color(0xFF1B4332)
        ..style = PaintingStyle.fill,
    );
  }

  void _strokeCircle(Canvas canvas, double cx, double cy, double radius,
      Color color, double width) {
    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      Paint()
        ..color = color
        ..strokeWidth = width
        ..style = PaintingStyle.stroke,
    );
  }

  void _dashedCircle(Canvas canvas, double cx, double cy, double radius,
      Color color, double width, int dashCount) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final step = (2 * math.pi) / dashCount;
    for (int i = 0; i < dashCount; i += 2) {
      final start = i * step;
      final end = start + step * 0.55;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: radius),
        start,
        end - start,
        false,
        paint,
      );
    }
  }

  void _drawStar(
    Canvas canvas,
    double cx,
    double cy,
    double outerR,
    double innerR,
    int points, {
    required Color fill,
    required Color stroke,
    required double strokeWidth,
    double rotationOffset = 0,
  }) {
    final path = Path();
    for (int i = 0; i < points * 2; i++) {
      final angle = (i * math.pi / points) - math.pi / 2 + rotationOffset;
      final dist = i.isEven ? outerR : innerR;
      final x = cx + dist * math.cos(angle);
      final y = cy + dist * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();

    canvas.drawPath(
        path,
        Paint()
          ..color = fill
          ..style = PaintingStyle.fill);
    canvas.drawPath(
      path,
      Paint()
        ..color = stroke
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
