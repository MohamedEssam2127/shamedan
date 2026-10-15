import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';

class CharacterCardModel {
  final String title;
  final String description;
  final Color headerColor;
  final String? imagePath;

  const CharacterCardModel({
    required this.title,
    required this.description,
    required this.headerColor,
    this.imagePath,
  });
}

class CharacterCard extends StatelessWidget {
  final String title;
  final String description;
  final Color headerColor;
  final String? imagePath;
  final Widget? headerChild;

  const CharacterCard({
    super.key,
    required this.title,
    required this.description,
    required this.headerColor,
    this.imagePath,
    this.headerChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Upper colored section with character illustration
          Container(
            height: 220,
            color: headerColor,
            alignment: Alignment.center,
            child: headerChild ??
                (imagePath != null && imagePath!.isNotEmpty
                    ? Image.asset(
                        imagePath!,
                        fit: BoxFit.contain,
                      )
                    : Icon(
                        Icons.person,
                        size: 90,
                        color: Colors.white.withValues(alpha: 0.6),
                      )),
          ),

          // Lower white section with title and description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: AppFonts.titleLemonada.copyWith(
                    fontSize: 16,
                    color: AppColor.backgroundBlack,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppFonts.regularCairo.copyWith(
                    fontSize: 12,
                    color: AppColor.backgroundBlack.withValues(alpha: 0.85),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
