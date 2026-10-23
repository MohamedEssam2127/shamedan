import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/core/utils/Appfonts.dart';

class ItemFooterSection extends StatelessWidget {
  final ItemModel item;
  final List<CharacterModel> characters;
  final Color footerColor;
  final Color footerTextColor;
  final ValueChanged<String> onCharacterSelected;

  const ItemFooterSection({
    super.key,
    required this.item,
    required this.characters,
    required this.footerColor,
    required this.footerTextColor,
    required this.onCharacterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: footerColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(64),
          topRight: Radius.circular(64),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(36, 40, 36, 32),
      child: Column(
        children: [
          // 1. Top action badges: "تاريخنا" (Right in RTL) & "اختار فريقك" (Left in RTL)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFooterActionItem(
                title: 'تاريخنا',
                icon: Icons.history_rounded,
                textColor: footerTextColor,
              ),
              _buildFooterActionItem(
                title: 'اختار فريقك',
                icon: Icons.groups_rounded,
                textColor: footerTextColor,
              ),
            ],
          ),

          const SizedBox(height: 36),

          // 2. Shamedan logo with generous height
          SizedBox(
            height: 85,
            child: Image.asset(
              'assets/images/logo 1.png',
              height: 85,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 44),

          // 3. 2x2 Character Grid
          // Row 1: Right is Kitkito, Left is Omda
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildFooterCharacterCard(
                  name: 'كتاكيتو',
                  image: 'assets/images/Kitkito.png',
                  itemId: '4',
                  currentItemId: item.id,
                  textColor: footerTextColor,
                ),
              ),
              Expanded(
                child: _buildFooterCharacterCard(
                  name: 'عمدة',
                  image: 'assets/images/omda.png',
                  itemId: '1',
                  currentItemId: item.id,
                  textColor: footerTextColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Row 2: Right is Cookies, Left is Beskawy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildFooterCharacterCard(
                  name: 'كوكيز',
                  image: 'assets/images/Cookies.png',
                  itemId: '3',
                  currentItemId: item.id,
                  textColor: footerTextColor,
                ),
              ),
              Expanded(
                child: _buildFooterCharacterCard(
                  name: 'بسكاوي',
                  image: 'assets/images/beskawy.png',
                  itemId: '2',
                  currentItemId: item.id,
                  textColor: footerTextColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // 4. Copyright Text (2 lines)
          Text(
            'جميع الحقوق محفوظة لشركة\nالشمعدان',
            textAlign: TextAlign.center,
            style: AppFonts.regularCairo.copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: footerTextColor,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // 5. Social icons row: TikTok, Instagram, Facebook
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialBox(
                  child: CustomPaint(
                    size: const Size(22, 22),
                    painter: _TikTokPainter(color: footerTextColor),
                  ),
                  borderColor: footerTextColor,
                ),
                const SizedBox(width: 20),
                _buildSocialBox(
                  child: CustomPaint(
                    size: const Size(22, 22),
                    painter: _InstagramPainter(color: footerTextColor),
                  ),
                  borderColor: footerTextColor,
                ),
                const SizedBox(width: 20),
                _buildSocialBox(
                  child: CustomPaint(
                    size: const Size(22, 22),
                    painter: _FacebookPainter(color: footerTextColor),
                  ),
                  borderColor: footerTextColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildFooterActionItem({
    required String title,
    required IconData icon,
    required Color textColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppFonts.regularCairo.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Icon(
          icon,
          size: 38,
          color: textColor,
        ),
      ],
    );
  }

  Widget _buildFooterCharacterCard({
    required String name,
    required String image,
    required String itemId,
    required String currentItemId,
    required Color textColor,
  }) {
    final char = characters.where((c) => c.itemId == itemId).firstOrNull;
    final displayName = char?.name ?? name;
    final displayImage = char?.image ?? image;
    final isCurrent = itemId == currentItemId;

    return GestureDetector(
      onTap: () {
        if (!isCurrent) {
          onCharacterSelected(itemId);
        }
      },
      child: Opacity(
        opacity: isCurrent ? 1.0 : 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayName,
              style: AppFonts.regularCairo.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Image.asset(
              displayImage,
              height: 72,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialBox({
    required Widget child,
    required Color borderColor,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
          width: 2.2,
        ),
      ),
      child: Center(child: child),
    );
  }
}

class _TikTokPainter extends CustomPainter {
  final Color color;
  const _TikTokPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Vertical Stem
    canvas.drawLine(
      Offset(w * 0.52, h * 0.20),
      Offset(w * 0.52, h * 0.62),
      strokePaint,
    );

    // Note head at bottom left
    canvas.drawCircle(Offset(w * 0.38, h * 0.66), w * 0.16, fillPaint);

    // Flag / Hook on top right
    final hookPath = Path()
      ..moveTo(w * 0.52, h * 0.36)
      ..cubicTo(w * 0.64, h * 0.36, w * 0.76, h * 0.28, w * 0.76, h * 0.18);
    canvas.drawPath(hookPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _TikTokPainter oldDelegate) => oldDelegate.color != color;
}

class _InstagramPainter extends CustomPainter {
  final Color color;
  const _InstagramPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width * 0.28, strokePaint);
    canvas.drawCircle(
      Offset(size.width * 0.74, size.height * 0.26),
      size.width * 0.08,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _InstagramPainter oldDelegate) => oldDelegate.color != color;
}

class _FacebookPainter extends CustomPainter {
  final Color color;
  const _FacebookPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w * 0.62, h * 0.90)
      ..lineTo(w * 0.46, h * 0.90)
      ..lineTo(w * 0.46, h * 0.52)
      ..lineTo(w * 0.34, h * 0.52)
      ..lineTo(w * 0.34, h * 0.38)
      ..lineTo(w * 0.46, h * 0.38)
      ..lineTo(w * 0.46, h * 0.28)
      ..cubicTo(w * 0.46, h * 0.14, w * 0.54, h * 0.10, w * 0.70, h * 0.10)
      ..lineTo(w * 0.76, h * 0.10)
      ..lineTo(w * 0.76, h * 0.24)
      ..lineTo(w * 0.66, h * 0.24)
      ..cubicTo(w * 0.62, h * 0.24, w * 0.62, h * 0.28, w * 0.62, h * 0.33)
      ..lineTo(w * 0.62, h * 0.38)
      ..lineTo(w * 0.76, h * 0.38)
      ..lineTo(w * 0.73, h * 0.52)
      ..lineTo(w * 0.62, h * 0.52)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _FacebookPainter oldDelegate) => oldDelegate.color != color;
}
