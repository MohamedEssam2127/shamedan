import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';

class BeginningSection extends StatelessWidget {
  const BeginningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Text(
            'البداية',
            textAlign: TextAlign.center,
            style: AppFonts.titleLalezar.copyWith(
              color: AppColor.backgroundBlack,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'بدأت رحلتنا بحلم لصناعة أجود أنواع الويفر والبسكويت في مصر والعالم العربي.\nالتزامنا بالجودة وحب الناس هو سر استمرارنا جيل بعد جيل، لنقدم طعماً أصيلاً يرسم البسمة على وجوه الملايين.',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppFonts.regularCairo.copyWith(
              color: AppColor.backgroundBlack.withValues(alpha: 0.85),
              fontSize: 14,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
