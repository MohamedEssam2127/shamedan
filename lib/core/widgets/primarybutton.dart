import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';


class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return  OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColor.backgroundBlack,
        side:  BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minimumSize: const Size(142, 38),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        elevation: 0,
      ),
      child: Text(
        'اعرف اكتر عن بسكاوي',
        style: AppFonts.regularCairo.copyWith(
          fontSize: 13,
          color: AppColor.backgroundBlack,
        ),
      ),
    );
  }
}
