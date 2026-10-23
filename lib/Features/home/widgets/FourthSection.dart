import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';
import 'package:shamedan/core/widgets/character_card.dart';

class FourthSection extends StatelessWidget {
  const FourthSection({super.key});

  final List<CharacterCardModel> characters = const [
    CharacterCardModel(
      title: 'عمدة',
      description: 'عمدة ده الكل في الكل هنا وكلمته بتمشي علي الكل بس طيب وطعمه هيعجبك ',
      headerColor: AppColor.secondarylight,
      imagePath: 'assets/images/omda.png',
      itemId: '1',
    ),
    CharacterCardModel(
      title: 'كتاكيتو',
      description: 'انت اكيد سمعت عن كتاكيتو قبل كده ده اطيب فينا واحد وقلبه طيب وهش من جوه',
      headerColor: AppColor.primarylight,
      imagePath: 'assets/images/Kitkito.png',
      itemId: '4',
    ),
    CharacterCardModel(
      title: 'بسكاوي',
      description: 'ده اكبر واحد فينا وليه احترامه كفايا انه بيعرف يظبط الشاي ',
      headerColor: AppColor.accentTale,
      imagePath: 'assets/images/beskawy.png',
      itemId: '2',
    ),
    CharacterCardModel(
      title: 'كوكيز',
      description: 'خلي بالك من كوكيز هو يبان كوكي عادي بس هو مش سهل خااالص',
      headerColor: AppColor.backgroundBlack,
      imagePath: 'assets/images/Cookies.png',
      itemId: '3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double curveHeight = screenWidth * 0.70;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ArtWork.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          // Top-left curved transition shape matching the design
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: curveHeight + 20,
            child: CustomPaint(
              painter: TopLeftCurvePainter(
                color: AppColor.backGroundColor,
                curveHeight: curveHeight,
              ),
            ),
          ),

          // Section Content: Title and Cards list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 64),
                Center(
                  child: Text(
                    'مين احنا ؟',
                    style: AppFonts.titleLalezar.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Cards List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: characters.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final item = characters[index];
                    return CharacterCard(
                      title: item.title,
                      description: item.description,
                      headerColor: item.headerColor,
                      imagePath: item.imagePath,
                      itemId: item.itemId,
                    );
                  },
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopLeftCurvePainter extends CustomPainter {
  final Color color;
  final double curveHeight;

  const TopLeftCurvePainter({
    required this.color,
    required this.curveHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    // Starts from ~85% of top edge
    path.lineTo(size.width * 0.85, 0);

    // Smooth quadratic bezier curve towards left edge
    path.quadraticBezierTo(
      size.width * 0.18,
      curveHeight * 0.10,
      0,
      curveHeight,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TopLeftCurvePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.curveHeight != curveHeight;
  }
}