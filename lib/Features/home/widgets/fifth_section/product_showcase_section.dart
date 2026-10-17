import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';
import 'package:shamedan/core/widgets/primarybutton.dart';

class ProductShowcaseSection extends StatelessWidget {
  const ProductShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/bako.png',
            fit: BoxFit.contain,
            width: screenWidth * 0.85,
            height: 150,
          ),
          const SizedBox(height: 18),
          Text(
            'شوكولاتة الشمعدان الأصلية بطعم الويفر المميز والمقرمش',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppFonts.regularLemonade.copyWith(
              color: AppColor.backgroundBlack,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'طعم الأصالة في كل قضمة',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppFonts.regularCairo.copyWith(
              color: AppColor.backgroundBlack.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            text: 'عن منتجاتنا',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
