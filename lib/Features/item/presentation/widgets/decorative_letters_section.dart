import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';

class DecorativeLettersSection extends StatelessWidget {
  final ItemModel item;
  final Color waveColor;

  const DecorativeLettersSection({
    super.key,
    required this.item,
    required this.waveColor,
  });

  @override
  Widget build(BuildContext context) {
    List<String> letters = item.heroLetters
        .trim()
        .split(RegExp(r'\s+'))
        .where((s) => s.isNotEmpty)
        .toList();

    if (letters.isEmpty) {
      letters = item.heroTitle.trim().replaceAll(' ', '').split('');
    }

    if (letters.isEmpty) return const SizedBox.shrink();

    final double fontSize = letters.length <= 4
        ? 34.0
        : (letters.length <= 5 ? 28.0 : 22.0);

    final rotations = [-0.15, -0.06, 0.12, 0.22, -0.10, 0.18, -0.08];
    final yOffsets = [-2.0, 4.0, -2.0, -5.0, 2.0, -3.0, 3.0];

    final Color letterColor = item.id == '1'
        ? AppColor.secondaryHeavy
        : waveColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(letters.length, (index) {
          final letter = letters[index];
          final angle = rotations[index % rotations.length];
          final dy = yOffsets[index % yOffsets.length];

          return Transform.translate(
            offset: Offset(0, dy),
            child: Transform.rotate(
              angle: angle,
              child: Text(
                letter,
                style: AppFonts.titleLemonada.copyWith(
                  fontSize: fontSize,
                  color: letterColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
