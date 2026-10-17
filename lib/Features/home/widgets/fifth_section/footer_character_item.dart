import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';

class FooterCharacterItem extends StatelessWidget {
  final String name;
  final String imagePath;

  const FooterCharacterItem({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: AppFonts.regularLalezar.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 6),
        Image.asset(
          imagePath,
          height: 46,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
