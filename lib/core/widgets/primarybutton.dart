import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const PrimaryButton({
    super.key,
    this.text = 'اعرف اكتر عن بسكاوي',
    this.onPressed,
    this.isSelected = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBg = isSelected
        ? const Color(0xFFFFF3CD)
        : (backgroundColor ?? Colors.white);

    final effectiveTextColor = textColor ?? AppColor.backgroundBlack;

    final effectiveBorder = BorderSide(
      color: isSelected
          ? const Color(0xFFB0931E)
          : (borderColor ?? Colors.black),
      width: isSelected ? 1.5 : 1.0,
    );

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed ?? () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: effectiveBg,
          foregroundColor: effectiveTextColor,
          side: effectiveBorder,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          minimumSize: Size(width ?? 142, height ?? 38),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFFB0931E),
                size: 16,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              text,
              style: AppFonts.regularCairo.copyWith(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: effectiveTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

