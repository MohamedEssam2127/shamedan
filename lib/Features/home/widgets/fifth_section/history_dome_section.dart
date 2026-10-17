import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';

class HistoryDomeSection extends StatelessWidget {
  const HistoryDomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, bottom: 28, left: 24, right: 24),
      decoration: const BoxDecoration(
        color: AppColor.backgroundBlack,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(999999),
          bottomRight: Radius.circular(999999),
        ),
      ),
      child: Column(
        children: [
          Text(
            'تاريخنا',
            textAlign: TextAlign.center,
            style: AppFonts.titleLalezar.copyWith(
              color: AppColor.white,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'أصل الويفر في مصر',
            textAlign: TextAlign.center,
            style: AppFonts.regularLemonade.copyWith(
              color: AppColor.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'رحلة من الإبداع والجودة',
            textAlign: TextAlign.center,
            style: AppFonts.regularCairo.copyWith(
              color: AppColor.white.withValues(alpha: 0.8),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'ش  م  ع  د  ا  ن',
            textAlign: TextAlign.center,
            style: AppFonts.regularCairo.copyWith(
              color: AppColor.white.withValues(alpha: 0.18),
              fontSize: 16,
              letterSpacing: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Icon(
            Icons.arrow_downward_rounded,
            color: AppColor.white,
            size: 26,
          ),
        ],
      ),
    );
  }
}
