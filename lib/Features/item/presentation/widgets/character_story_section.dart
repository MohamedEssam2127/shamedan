import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/core/utils/Appfonts.dart';

class CharacterStorySection extends StatelessWidget {
  final ItemModel item;
  final Color waveColor;

  const CharacterStorySection({
    super.key,
    required this.item,
    required this.waveColor,
  });

  List<_StoryIngredientConfig> _getStoryIngredients(ItemModel item) {
    if (item.id == '2') {
      // Beskawy
      return const [
        _StoryIngredientConfig(
          asset: 'assets/images/icon_wheat.png',
          top: 18,
          end: 18,
          width: 65,
          height: 65,
        ),
        _StoryIngredientConfig(
          asset: 'assets/images/milk.png',
          bottom: 20,
          end: 16,
          width: 80,
          height: 90,
        ),
        _StoryIngredientConfig(
          asset: 'assets/images/icon_baking_tray.png',
          top: 110,
          start: 16,
          width: 70,
          height: 70,
        ),
      ];
    } else if (item.id == '3') {
      // Cookies
      return const [
        _StoryIngredientConfig(
          asset: 'assets/images/cocoa.png',
          top: 18,
          end: 18,
          width: 85,
          height: 80,
        ),
        _StoryIngredientConfig(
          asset: 'assets/images/milk.png',
          bottom: 20,
          end: 16,
          width: 80,
          height: 90,
        ),
        _StoryIngredientConfig(
          asset: 'assets/images/icon_cookies_chips.png',
          top: 110,
          start: 16,
          width: 75,
          height: 75,
        ),
      ];
    }

    // Default: Omda (Item 1)
    return const [
      _StoryIngredientConfig(
        asset: 'assets/images/cocoa.png',
        top: 16,
        end: 18,
        width: 95,
        height: 85,
      ),
      _StoryIngredientConfig(
        asset: 'assets/images/milk.png',
        bottom: 20,
        end: 16,
        width: 85,
        height: 95,
      ),
      _StoryIngredientConfig(
        asset: 'assets/images/cacao powder.png',
        top: 110,
        start: 14,
        width: 105,
        height: 65,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final blobColor = item.id == '1'
        ? const Color(0xFF581212)
        : waveColor;

    final ingredients = _getStoryIngredients(item);

    final String storyDisplayText = item.storyText.isNotEmpty
        ? item.storyText
        : (item.id == '1' ? 'محتاج حد تقيل ؟ كلم عمدة' : '');

    return Column(
      children: [
        // Story Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            item.storyTitle,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppFonts.titleLalezar.copyWith(
              fontSize: 26,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Organic Blob with character and floating ingredients
        SizedBox(
          height: 270,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Blob background
              Positioned.fill(
                child: CustomPaint(
                  painter: _OrganicStoryBlobPainter(
                    color: blobColor,
                    isRtl: isRtl,
                  ),
                ),
              ),

              // Floating ingredients respecting RTL (start/end)
              for (final ing in ingredients)
                PositionedDirectional(
                  top: ing.top,
                  bottom: ing.bottom,
                  start: ing.start,
                  end: ing.end,
                  child: Image.asset(
                    ing.asset,
                    width: ing.width,
                    height: ing.height,
                    fit: BoxFit.contain,
                  ),
                ),

              // Main Character in center
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  item.characterImage,
                  height: 190,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Story text
        if (storyDisplayText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              storyDisplayText,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: AppFonts.regularCairo.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.2,
                height: 1.4,
              ),
            ),
          ),
      ],
    );
  }
}

class _StoryIngredientConfig {
  final String asset;
  final double? top;
  final double? bottom;
  final double? start;
  final double? end;
  final double width;
  final double height;

  const _StoryIngredientConfig({
    required this.asset,
    this.top,
    this.bottom,
    this.start,
    this.end,
    required this.width,
    required this.height,
  });
}

class _OrganicStoryBlobPainter extends CustomPainter {
  final Color color;
  final bool isRtl;

  const _OrganicStoryBlobPainter({
    required this.color,
    required this.isRtl,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.save();

    // In LTR, mirror horizontally so start/end remains visually symmetric
    if (!isRtl) {
      canvas.translate(size.width, 0);
      canvas.scale(-1, 1);
    }

    final w = size.width;
    final h = size.height;
    final path = Path();

    // Base coordinates designed for RTL:
    path.moveTo(w * 0.44, h * 0.28);

    // Toward right tapered lobe (start side)
    path.cubicTo(w * 0.58, h * 0.28, w * 0.74, h * 0.32, w * 0.88, h * 0.38);
    path.cubicTo(w * 0.98, h * 0.42, w * 1.00, h * 0.50, w * 0.95, h * 0.58);
    path.cubicTo(w * 0.88, h * 0.68, w * 0.74, h * 0.74, w * 0.58, h * 0.76);

    // Dip under Omda's feet in center-bottom
    path.cubicTo(w * 0.48, h * 0.78, w * 0.42, h * 0.88, w * 0.36, h * 0.88);

    // Left rounded bulb (end in RTL)
    path.cubicTo(w * 0.26, h * 0.88, w * 0.14, h * 0.82, w * 0.08, h * 0.68);
    path.cubicTo(w * 0.02, h * 0.58, w * 0.02, h * 0.42, w * 0.08, h * 0.32);

    // Top-left crest behind chocolate bar
    path.cubicTo(w * 0.14, h * 0.22, w * 0.26, h * 0.22, w * 0.36, h * 0.25);
    path.cubicTo(w * 0.40, h * 0.26, w * 0.42, h * 0.28, w * 0.44, h * 0.28);

    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _OrganicStoryBlobPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isRtl != isRtl;
  }
}
