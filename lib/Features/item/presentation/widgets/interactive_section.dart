import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/core/utils/Appfonts.dart';

class InteractiveSection extends StatefulWidget {
  final ItemModel item;
  final Color themeColor;

  const InteractiveSection({
    super.key,
    required this.item,
    required this.themeColor,
  });

  @override
  State<InteractiveSection> createState() => _InteractiveSectionState();
}

class _InteractiveSectionState extends State<InteractiveSection> {
  String? _selectedQuizOption;
  final Set<int> _flippedCookies = {};

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Section Title
          Text(
            item.gameTitle,
            style: AppFonts.titleLalezar.copyWith(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Mascot Character + Prompt Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mascot Vector/Icon
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/icon_cocoa_bean.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 14),

              // Speech Prompt
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    item.gameSubtitle,
                    style: AppFonts.regularCairo.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Interaction type
          if (item.interactiveType == 'quiz')
            _buildQuizOptions(item)
          else if (item.interactiveType == 'cookie_grid')
            _buildCookieGrid(item)
          else
            _buildCharacterIntro(item),
        ],
      ),
    );
  }

  // Quiz Options
  Widget _buildQuizOptions(ItemModel item) {
    return Column(
      children: [
        ...item.quizOptions.map((option) {
          final isSelected = _selectedQuizOption == option;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _selectedQuizOption = option);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? const Color(0xFFFEE500)
                      : Colors.white,
                  foregroundColor: const Color(0xFF2A2A2A),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isSelected) ...[
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF7B1C1C),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      option,
                      style: AppFonts.regularCairo.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        const SizedBox(height: 16),

        // Character standing
        Image.asset(
          item.characterImage,
          height: 190,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  // Cookie Grid
  Widget _buildCookieGrid(ItemModel item) {
    return Column(
      children: [
        Image.asset(
          item.characterImage,
          height: 190,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.15,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            final isFlipped = _flippedCookies.contains(index);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isFlipped) {
                    _flippedCookies.remove(index);
                  } else {
                    _flippedCookies.add(index);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Image.asset(
                    'assets/images/icon_cookies_chips.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Character Intro
  Widget _buildCharacterIntro(ItemModel item) {
    return Column(
      children: [
        Image.asset(
          item.characterImage,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'أهلاً بك مع ${item.heroTitle}!',
                  textAlign: TextAlign.center,
                  style: AppFonts.regularCairo,
                ),
                backgroundColor: Colors.white,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: item.cardColor == '#FFFFFF'
                ? Colors.white
                : const Color(0xFF2B1C13),
            foregroundColor: item.cardColor == '#FFFFFF'
                ? const Color(0xFF2A2A2A)
                : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Text(
            'ابدأ!',
            style: AppFonts.titleLalezar.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
