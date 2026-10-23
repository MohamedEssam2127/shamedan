import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/core/utils/Appfonts.dart';

class ItemHeroSection extends StatelessWidget {
  final ItemModel item;

  const ItemHeroSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title & Perks column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  item.heroTitle.isNotEmpty ? 'ده ${item.heroTitle}' : 'ده عمدة',
                  style: AppFonts.titleLemonada.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                if (item.heroSubtitle.isNotEmpty) ...[
                  const SizedBox(height: 49),
                  Text(
                    item.id == '1'
                        ? "لما تحب تحلي و عايز حد يخلص \n المهمة ديه كلم عمدة بس\n وهو هيخلصهالك "
                        : item.heroSubtitle,
                    style: AppFonts.regularCairo.copyWith(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
              ],
            ),
          ),
          // Product pack image
          if (item.productCards.isNotEmpty)
            SizedBox(
              width: 98,
              height: 146,
              child: Image.asset(
                item.id == '1' ? 'assets/images/omda_card.png' : item.productCards.first.image,
                fit: BoxFit.contain,
              ),
            ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }
}
