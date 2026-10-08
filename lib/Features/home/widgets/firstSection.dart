import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';

class Firstsection extends StatelessWidget {
  const Firstsection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/Art borad 1.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.2),
            BlendMode.multiply,
          ),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(999999),
          bottomRight: Radius.circular(999999),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x33000000),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        alignment: const Alignment(0, -0.425),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'من بيتنا لبيتك القرمشة مبتنتهيش',
            textAlign: TextAlign.center,
            style: AppFonts.regularLalezar.copyWith(
              fontSize: 28,
              color: AppColor.backGroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
