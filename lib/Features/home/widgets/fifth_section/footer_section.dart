import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';
import 'package:shamedan/Features/home/widgets/fifth_section/footer_character_item.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.backgroundBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(140),
          topRight: Radius.circular(140),
        ),
      ),
      padding: const EdgeInsets.only(top: 40, bottom: 36, left: 24, right: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _FooterAction(
                icon: Icons.groups_rounded,
                title: 'ابتكر شخصيتك',
              ),
              _FooterAction(
                icon: Icons.history_toggle_off_rounded,
                title: 'تاريخنا',
              ),
            ],
          ),

          const SizedBox(height: 36),

          // Shamadan Logo in white
          Image.asset(
            'assets/images/logo 1.png',
            height: 48,
            fit: BoxFit.contain,
            color: Colors.white,
          ),

          const SizedBox(height: 36),

          // 2x2 Characters Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    FooterCharacterItem(
                      name: 'عمدة',
                      imagePath: 'assets/images/omda.png',
                    ),
                    FooterCharacterItem(
                      name: 'بسكاوي',
                      imagePath: 'assets/images/beskawy.png',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    FooterCharacterItem(
                      name: 'كوكيز',
                      imagePath: 'assets/images/Cookies.png',
                    ),
                    FooterCharacterItem(
                      name: 'كتكيتو',
                      imagePath: 'assets/images/Kitkito.png',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // Copyright
          Text(
            'جميع الحقوق محفوظة لشركة الشمعدان\nللصناعات الغذائية',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppFonts.regularCairo.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 13,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 24),

          // Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _SocialIcon(icon: Icons.tiktok),
              SizedBox(width: 20),
              _SocialIcon(icon: Icons.camera_alt_outlined),
              SizedBox(width: 20),
              _SocialIcon(icon: Icons.facebook),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterAction extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FooterAction({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: AppFonts.regularCairo.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;

  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.8),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
