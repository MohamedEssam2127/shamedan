import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';

class TimelineSection extends StatelessWidget {
  final ItemModel item;
  final Color waveColor;

  const TimelineSection({
    super.key,
    required this.item,
    required this.waveColor,
  });

  Color _getHeavyColor(ItemModel item, Color waveColor) {
    if (item.id == '1') {
      return AppColor.secondaryHeavy;
    }
    return waveColor;
  }

  Color _getCircleColor(ItemModel item) {
    if (item.id == '1') {
      return AppColor.secondarylight;
    }
    try {
      return Color(int.parse(item.themeColor.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFFA42B20);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (item.timelineSteps.isEmpty) return const SizedBox.shrink();

    final heavyColor = _getHeavyColor(item, waveColor);
    final circleColor = _getCircleColor(item);

    return LayoutBuilder(
      builder: (context, constraints) {
        final centerX = constraints.maxWidth / 2;

        return Stack(
          children: [
            // Background shape (Secondary/heavy with curve at top-left)
            Positioned.fill(
              child: CustomPaint(
                painter: _TimelineBackgroundPainter(heavyColor: heavyColor),
              ),
            ),

            // Continuous vertical white line in the exact middle
            Positioned(
              left: centerX - 1.25,
              top: 50,
              bottom: 40,
              child: Container(
                width: 2.5,
                color: Colors.white,
              ),
            ),

            // Content: Title area + Step rows
            Column(
              children: [
                // Title and Subtitle aligned to the right (above images)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    right: 28,
                    left: 28,
                    bottom: 20,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.timelineTitle,
                          textAlign: TextAlign.right,
                          style: AppFonts.titleLemonada.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (item.timelineSubtitle.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            item.timelineSubtitle,
                            textAlign: TextAlign.right,
                            style: AppFonts.regularLemonade.copyWith(
                              fontSize: 13.5,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Step rows
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: List.generate(item.timelineSteps.length, (index) {
                      final step = item.timelineSteps[index];
                      return _TimelineStepRow(
                        step: step,
                        circleColor: circleColor,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// ── Each timeline step row ─────────────────────────────────────
class _TimelineStepRow extends StatelessWidget {
  final TimelineStepModel step;
  final Color circleColor;

  const _TimelineStepRow({
    required this.step,
    required this.circleColor,
  });

  String _formatTitle(String title) {
    if (title.contains('\n')) return title;
    final words = title.trim().split(RegExp(r'\s+'));
    if (words.length == 2) {
      return '${words[0]}\n${words[1]}';
    } else if (words.length == 3) {
      return '${words[0]} ${words[1]}\n${words[2]}';
    } else if (words.length >= 4) {
      final mid = (words.length / 2).ceil();
      return '${words.sublist(0, mid).join(' ')}\n${words.sublist(mid).join(' ')}';
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            // Left: Step description text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _formatTitle(step.title),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: AppFonts.regularLemonade.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.45,
                  ),
                ),
              ),
            ),

            // Middle: Solid white circle dot on the line
            SizedBox(
              width: 32,
              child: Center(
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // Right: Circular container with image
            Expanded(
              child: Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    step.icon,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Organic background curve painter ──────────────────────────
class _TimelineBackgroundPainter extends CustomPainter {
  final Color heavyColor;

  _TimelineBackgroundPainter({required this.heavyColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = heavyColor
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final path = Path();
    // Start at top right
    path.moveTo(w, 0);
    // Line across the top to 38% from left
    path.lineTo(w * 0.38, 0);
    // Curve down and across to the left edge at y = 150
    path.quadraticBezierTo(w * 0.12, 45, 0, 150);
    // Down to bottom left
    path.lineTo(0, h);
    // Across to bottom right
    path.lineTo(w, h);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TimelineBackgroundPainter oldDelegate) {
    return oldDelegate.heavyColor != heavyColor;
  }
}
