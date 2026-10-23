import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/core/utils/Appfonts.dart';

class TimelineSection extends StatelessWidget {
  final ItemModel item;
  final Color waveColor;

  const TimelineSection({
    super.key,
    required this.item,
    required this.waveColor,
  });

  @override
  Widget build(BuildContext context) {
    if (item.timelineSteps.isEmpty) return const SizedBox.shrink();

    final badgeColor = item.id == '1'
        ? const Color(0xFF88241D)
        : waveColor.withValues(alpha: 0.85);

    return Column(
      children: [
        // Title & Subtitle aligned to the right in RTL (above the circular badges)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.timelineTitle,
                  textAlign: TextAlign.right,
                  style: AppFonts.titleLalezar.copyWith(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                if (item.timelineSubtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.timelineSubtitle,
                    textAlign: TextAlign.right,
                    style: AppFonts.regularCairo.copyWith(
                      fontSize: 12.5,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Timeline steps with background wave
        SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              // Wave shadow along the top-left side
              Positioned.fill(
                child: CustomPaint(
                  painter: _TimelineWavePainter(waveColor: waveColor),
                ),
              ),

              // Timeline step items
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Column(
                  children: List.generate(item.timelineSteps.length, (index) {
                    final step = item.timelineSteps[index];
                    final isFirst = index == 0;
                    final isLast = index == item.timelineSteps.length - 1;

                    return _TimelineStepRow(
                      step: step,
                      isFirst: isFirst,
                      isLast: isLast,
                      badgeColor: badgeColor,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineStepRow extends StatelessWidget {
  final TimelineStepModel step;
  final bool isFirst;
  final bool isLast;
  final Color badgeColor;

  const _TimelineStepRow({
    required this.step,
    required this.isFirst,
    required this.isLast,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Vertical continuous white line passing through center of the dots
          PositionedDirectional(
            start: 109,
            top: isFirst ? 48 : 0,
            bottom: isLast ? 48 : 0,
            child: Container(
              width: 2.5,
              color: Colors.white,
            ),
          ),

          // Content Row
          Row(
            children: [
              // Left (in RTL): Step description text
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    step.title,
                    textAlign: TextAlign.center,
                    style: AppFonts.regularCairo.copyWith(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              // Solid white indicator node on the line
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Right (in RTL): Solid dark red circular badge
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  step.icon,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineWavePainter extends CustomPainter {
  final Color waveColor;

  _TimelineWavePainter({required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor.withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.55, 0);
    path.quadraticBezierTo(
      size.width * 0.40,
      size.height * 0.22,
      size.width * 0.20,
      size.height * 0.45,
    );
    path.quadraticBezierTo(
      size.width * 0.08,
      size.height * 0.70,
      0,
      size.height * 0.90,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TimelineWavePainter oldDelegate) {
    return oldDelegate.waveColor != waveColor;
  }
}
