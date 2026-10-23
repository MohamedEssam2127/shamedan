import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/Features/item/data/item_repository.dart';
import 'package:shamedan/core/utils/app_color.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/widgets/customAppBar.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, required this.itemId});

  final String itemId;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final ItemRepository _repository = ItemRepository();
  ItemModel? _item;
  List<CharacterModel> _characters = [];
  bool _isLoading = true;
  String? _selectedQuizOption;
  final Set<int> _flippedCookies = {};

  @override
  void initState() {
    super.initState();
    _loadData(widget.itemId);
  }

  Future<void> _loadData(String id) async {
    setState(() => _isLoading = true);
    final item = await _repository.getItemById(id);
    final characters = await _repository.getCharacters();
    if (mounted) {
      setState(() {
        _item = item;
        _characters = characters;
        _isLoading = false;
        _selectedQuizOption = null;
        _flippedCookies.clear();
      });
    }
  }

  Color _parseColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF4F8C82),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    if (_item == null) {
      return Scaffold(
        backgroundColor: AppColor.secondarylight,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'المنتج غير موجود',
                  style: AppFonts.titleLalezar.copyWith(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('رجوع'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final item = _item!;
    final themeColor = _parseColor(item.themeColor);
    final bgColor = _parseColor(item.backgroundColor);
    final waveColor = _parseColor(item.waveColor);
    final footerColor = _parseColor(item.footerColor);
    final footerTextColor = _parseColor(item.footerTextColor);

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: bgColor  , // background color 
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [


              // 2. Hero Section (Header with pack & title)
              _buildHeroSection(item),

              // 3. Decorative background letters
              _buildDecorativeLetters(item),

              // 4. Hero Character Story
              _buildCharacterStory(item, waveColor),

              const SizedBox(height: 24),

              // 5. Timeline ("خطوات الصنع")
              _buildTimelineSection(item, waveColor),

              const SizedBox(height: 32),
              
              // 7. Interactive / Mascot Section
              _buildInteractiveSection(item, themeColor),

              const SizedBox(height: 36),

              // 8. Footer Section
              _buildFooter(item, footerColor, footerTextColor),
            ],
          ),
        ),
      ),
    );
  }

  // ── 2. Hero Section ──────────────────────────────────────────
  Widget _buildHeroSection(ItemModel item) {
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
                   "ده عمدة" ,  // title 
                  style: AppFonts.titleLemonada.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                if (item.heroSubtitle.isNotEmpty) ...[
                  const SizedBox(height: 49),
                  Text(
                   "لما تحب تحلي و عايز حد يخلص \n المهمة ديه كلم عمدة بس\n وهو هيخلصهالك ",
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
          //Product pack image
          if (item.productCards.isNotEmpty)
            SizedBox(
              width: 98,
              height: 146,
              child: Image.asset(
                'assets/images/omda_card.png', // omda_card.png 
                fit: BoxFit.contain,
              ),
            ),

          const SizedBox(width: 14),
        ],
      ),
    );
  }

  // ── 3. Decorative Letters ────────────────────────────────────
  Widget _buildDecorativeLetters(ItemModel item) {
    // Extract letters from heroLetters (space-separated) or fallback to heroTitle characters
    List<String> letters = item.heroLetters
        .trim()
        .split(RegExp(r'\s+'))
        .where((s) => s.isNotEmpty)
        .toList();

    if (letters.isEmpty) {
      letters = item.heroTitle.trim().replaceAll(' ', '').split('');
    }

    if (letters.isEmpty) return const SizedBox.shrink();

    // Dynamically adjust font size based on the number of letters
    final double fontSize = letters.length <= 4
        ? 34.0
        : (letters.length <= 5 ? 28.0 : 22.0);

    // Playful rotation angles and vertical offsets for each letter
    final rotations = [-0.15, -0.06, 0.12, 0.22, -0.10, 0.18, -0.08];
    final yOffsets = [-2.0, 4.0, -2.0, -5.0, 2.0, -3.0, 3.0];

    final Color letterColor = item.id == '1'
        ? AppColor.secondaryHeavy
        : _parseColor(item.waveColor);

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

  // ── 4. Hero Character Story ──────────────────────────────────
  Widget _buildCharacterStory(ItemModel item, Color waveColor) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final blobColor = item.id == '1'
        ? const Color(0xFF581212)
        : waveColor;

    final ingredients = _getStoryIngredients(item);

    final String storyDisplayText = item.storyText.isNotEmpty
        ? item.storyText
        : (item.id == '1' ? 'محتاج حد تقيل ؟ كلم عمدة' : '');

    return Column(
      children: [
        // Story Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            item.storyTitle,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppFonts.titleLalezar.copyWith(
              fontSize: 26,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Organic Blob with character and floating ingredients
        SizedBox(
          height: 270,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Blob background
              Positioned.fill(
                child: CustomPaint(
                  painter: _OrganicStoryBlobPainter(
                    color: blobColor,
                    isRtl: isRtl,
                  ),
                ),
              ),

              // Floating ingredients respecting RTL (start/end)
              for (final ing in ingredients)
                PositionedDirectional(
                  top: ing.top,
                  bottom: ing.bottom,
                  start: ing.start,
                  end: ing.end,
                  child: Image.asset(
                    ing.asset,
                    width: ing.width,
                    height: ing.height,
                    fit: BoxFit.contain,
                  ),
                ),

              // Main Character in center
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  item.characterImage,
                  height: 190,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Story text
        if (storyDisplayText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              storyDisplayText,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: AppFonts.regularCairo.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.2,
                height: 1.4,
              ),
            ),
          ),
      ],
    );
  }

  List<_StoryIngredientConfig> _getStoryIngredients(ItemModel item) {
    if (item.id == '2') {
      // Beskawy
      return const [
        _StoryIngredientConfig(
          asset: 'assets/images/icon_wheat.png',
          top: 18,
          end: 18,
          width: 65,
          height: 65,
        ),
        _StoryIngredientConfig(
          asset: 'assets/images/milk.png',
          bottom: 20,
          end: 16,
          width: 80,
          height: 90,
        ),
        _StoryIngredientConfig(
          asset: 'assets/images/icon_baking_tray.png',
          top: 110,
          start: 16,
          width: 70,
          height: 70,
        ),
      ];
    } else if (item.id == '3') {
      // Cookies
      return const [
        _StoryIngredientConfig(
          asset: 'assets/images/cocoa.png',
          top: 18,
          end: 18,
          width: 85,
          height: 80,
        ),
        _StoryIngredientConfig(
          asset: 'assets/images/milk.png',
          bottom: 20,
          end: 16,
          width: 80,
          height: 90,
        ),
        _StoryIngredientConfig(
          asset: 'assets/images/icon_cookies_chips.png',
          top: 110,
          start: 16,
          width: 75,
          height: 75,
        ),
      ];
    }

    // Default: Omda (Item 1)
    return const [
      _StoryIngredientConfig(
        asset: 'assets/images/cocoa.png',
        top: 16,
        end: 18,
        width: 95,
        height: 85,
      ),
      _StoryIngredientConfig(
        asset: 'assets/images/milk.png',
        bottom: 20,
        end: 16,
        width: 85,
        height: 95,
      ),
      _StoryIngredientConfig(
        asset: 'assets/images/cacao powder.png',
        top: 110,
        start: 14,
        width: 105,
        height: 65,
      ),
    ];
  }

  // ── 5. Timeline Section ("خطوات الصنع") ────────────────────────
  Widget _buildTimelineSection(ItemModel item, Color waveColor) {
    if (item.timelineSteps.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // Title & Subtitle
        Text(
          item.timelineTitle,
          style: AppFonts.titleLalezar.copyWith(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        if (item.timelineSubtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            item.timelineSubtitle,
            style: AppFonts.regularCairo.copyWith(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
        ],
        const SizedBox(height: 28),

        // Timeline with organic wave on right
        SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              // Wave on the right side
              Positioned.fill(
                child: CustomPaint(
                  painter: _TimelineWavePainter(waveColor: waveColor),
                ),
              ),

              // Timeline content
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Column(
                  children: List.generate(item.timelineSteps.length, (index) {
                    final step = item.timelineSteps[index];
                    final isFirst = index == 0;
                    final isLast = index == item.timelineSteps.length - 1;

                    return _TimelineStepRow(
                      step: step,
                      isFirst: isFirst,
                      isLast: isLast,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  
  // ── 7. Interactive / Mascot Section ──────────────────────────
  Widget _buildInteractiveSection(ItemModel item, Color themeColor) {
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

          // Cute Mascot Character + Prompt Row
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

  // Quiz Options (Omda Red screen)
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

        // Big standing Omda character
        Image.asset(
          item.characterImage,
          height: 190,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  // Cookie Grid (Cookies Brown screen)
  Widget _buildCookieGrid(ItemModel item) {
    return Column(
      children: [
        // Big Detective Cookies character standing
        Image.asset(
          item.characterImage,
          height: 190,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),

        // 2x3 Grid of 6 cookie cards
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

  // Character Intro (Somsatawy / Kitkito screens)
  Widget _buildCharacterIntro(ItemModel item) {
    return Column(
      children: [
        // Big character standing
        Image.asset(
          item.characterImage,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),

        // Action button
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

  // ── 8. Footer Section ────────────────────────────────────────
  Widget _buildFooter(
    ItemModel item,
    Color footerColor,
    Color footerTextColor,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: footerColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(64),
          topRight: Radius.circular(64),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(36, 40, 36, 32),
      child: Column(
        children: [
          // 1. Top action badges: "تاريخنا" (Right in RTL) & "اختار فريقك" (Left in RTL)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFooterActionItem(
                title: 'تاريخنا',
                icon: Icons.history_rounded,
                textColor: footerTextColor,
              ),
              _buildFooterActionItem(
                title: 'اختار فريقك',
                icon: Icons.groups_rounded,
                textColor: footerTextColor,
              ),
            ],
          ),

          const SizedBox(height: 36),

          // 2. Center Shamedan candle emblem (cropped cleanly to framed emblem)
          ClipRect(
            child: SizedBox(
              height: 62,
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.70,
                child: Image.asset(
                  'assets/images/logo 1.png',
                  width: 145,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),

          const SizedBox(height: 44),

          // 3. 2x2 Character Grid
          // Row 1: Right is Kitkito, Left is Omda
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildFooterCharacterCard(
                  name: 'كتاكيتو',
                  image: 'assets/images/Kitkito.png',
                  itemId: '4',
                  currentItemId: item.id,
                  textColor: footerTextColor,
                ),
              ),
              Expanded(
                child: _buildFooterCharacterCard(
                  name: 'عمدة',
                  image: 'assets/images/omda.png',
                  itemId: '1',
                  currentItemId: item.id,
                  textColor: footerTextColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Row 2: Right is Cookies, Left is Beskawy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildFooterCharacterCard(
                  name: 'كوكيز',
                  image: 'assets/images/Cookies.png',
                  itemId: '3',
                  currentItemId: item.id,
                  textColor: footerTextColor,
                ),
              ),
              Expanded(
                child: _buildFooterCharacterCard(
                  name: 'بسكاوي',
                  image: 'assets/images/beskawy.png',
                  itemId: '2',
                  currentItemId: item.id,
                  textColor: footerTextColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // 4. Copyright Text (2 lines)
          Text(
            'جميع الحقوق محفوظة لشركة\nالشمعدان',
            textAlign: TextAlign.center,
            style: AppFonts.regularCairo.copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: footerTextColor,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // 5. Social icons row: TikTok, Instagram, Facebook
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialBox(
                  child: CustomPaint(
                    size: const Size(22, 22),
                    painter: _TikTokPainter(color: footerTextColor),
                  ),
                  borderColor: footerTextColor,
                ),
                const SizedBox(width: 20),
                _buildSocialBox(
                  child: CustomPaint(
                    size: const Size(22, 22),
                    painter: _InstagramPainter(color: footerTextColor),
                  ),
                  borderColor: footerTextColor,
                ),
                const SizedBox(width: 20),
                _buildSocialBox(
                  child: CustomPaint(
                    size: const Size(22, 22),
                    painter: _FacebookPainter(color: footerTextColor),
                  ),
                  borderColor: footerTextColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildFooterActionItem({
    required String title,
    required IconData icon,
    required Color textColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppFonts.regularCairo.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Icon(
          icon,
          size: 38,
          color: textColor,
        ),
      ],
    );
  }

  Widget _buildFooterCharacterCard({
    required String name,
    required String image,
    required String itemId,
    required String currentItemId,
    required Color textColor,
  }) {
    final char = _characters.where((c) => c.itemId == itemId).firstOrNull;
    final displayName = char?.name ?? name;
    final displayImage = char?.image ?? image;
    final isCurrent = itemId == currentItemId;
    return GestureDetector(
      onTap: () {
        if (!isCurrent) {
          _loadData(itemId);
        }
      },
      child: Opacity(
        opacity: isCurrent ? 1.0 : 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayName,
              style: AppFonts.regularCairo.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Image.asset(
              displayImage,
              height: 72,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialBox({
    required Widget child,
    required Color borderColor,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
          width: 2.2,
        ),
      ),
      child: Center(child: child),
    );
  }
}

class _TikTokPainter extends CustomPainter {
  final Color color;
  const _TikTokPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Vertical Stem
    canvas.drawLine(
      Offset(w * 0.52, h * 0.20),
      Offset(w * 0.52, h * 0.62),
      strokePaint,
    );

    // Note head at bottom left
    canvas.drawCircle(Offset(w * 0.38, h * 0.66), w * 0.16, fillPaint);

    // Flag / Hook on top right
    final hookPath = Path()
      ..moveTo(w * 0.52, h * 0.36)
      ..cubicTo(w * 0.64, h * 0.36, w * 0.76, h * 0.28, w * 0.76, h * 0.18);
    canvas.drawPath(hookPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _TikTokPainter oldDelegate) => oldDelegate.color != color;
}

class _InstagramPainter extends CustomPainter {
  final Color color;
  const _InstagramPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width * 0.28, strokePaint);
    canvas.drawCircle(
      Offset(size.width * 0.74, size.height * 0.26),
      size.width * 0.08,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _InstagramPainter oldDelegate) => oldDelegate.color != color;
}

class _FacebookPainter extends CustomPainter {
  final Color color;
  const _FacebookPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w * 0.62, h * 0.90)
      ..lineTo(w * 0.46, h * 0.90)
      ..lineTo(w * 0.46, h * 0.52)
      ..lineTo(w * 0.34, h * 0.52)
      ..lineTo(w * 0.34, h * 0.38)
      ..lineTo(w * 0.46, h * 0.38)
      ..lineTo(w * 0.46, h * 0.28)
      ..cubicTo(w * 0.46, h * 0.14, w * 0.54, h * 0.10, w * 0.70, h * 0.10)
      ..lineTo(w * 0.76, h * 0.10)
      ..lineTo(w * 0.76, h * 0.24)
      ..lineTo(w * 0.66, h * 0.24)
      ..cubicTo(w * 0.62, h * 0.24, w * 0.62, h * 0.28, w * 0.62, h * 0.33)
      ..lineTo(w * 0.62, h * 0.38)
      ..lineTo(w * 0.76, h * 0.38)
      ..lineTo(w * 0.73, h * 0.52)
      ..lineTo(w * 0.62, h * 0.52)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _FacebookPainter oldDelegate) => oldDelegate.color != color;
}

// ── Timeline Wave Painter ──────────────────────────────────────
class _TimelineWavePainter extends CustomPainter {
  final Color waveColor;

  _TimelineWavePainter({required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final path = Path();
    // Organic wave along the right side
    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.45, 0);
    path.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.25,
      size.width * 0.45,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.55,
      size.height * 0.75,
      size.width * 0.45,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TimelineWavePainter oldDelegate) {
    return oldDelegate.waveColor != waveColor;
  }
}

// ── Timeline Step Row Widget ───────────────────────────────────
class _TimelineStepRow extends StatelessWidget {
  final TimelineStepModel step;
  final bool isFirst;
  final bool isLast;

  const _TimelineStepRow({
    required this.step,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Vertical continuous line (positioned at 65% width)
          Positioned(
            right: 105,
            top: isFirst ? 45 : 0,
            bottom: isLast ? 45 : 0,
            child: Container(
              width: 2.5,
              color: Colors.white,
            ),
          ),

          // Row content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                // Inner side (Left in RTL): Text
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: AppFonts.titleLalezar.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          step.subtitle,
                          style: AppFonts.regularCairo.copyWith(
                            fontSize: 10.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Solid white dot centered on the line
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 14),

                // Outer side (Right in RTL): Circular icon badge
                Container(
                  width: 58,
                  height: 58,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                  ),
                  child: Image.asset(
                    step.icon,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryIngredientConfig {
  final String asset;
  final double? top;
  final double? bottom;
  final double? start;
  final double? end;
  final double width;
  final double height;

  const _StoryIngredientConfig({
    required this.asset,
    this.top,
    this.bottom,
    this.start,
    this.end,
    required this.width,
    required this.height,
  });
}

class _OrganicStoryBlobPainter extends CustomPainter {
  final Color color;
  final bool isRtl;

  const _OrganicStoryBlobPainter({
    required this.color,
    required this.isRtl,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.save();

    // In LTR, mirror horizontally so start/end remains visually symmetric
    if (!isRtl) {
      canvas.translate(size.width, 0);
      canvas.scale(-1, 1);
    }

    final w = size.width;
    final h = size.height;
    final path = Path();

    // Base coordinates are designed for RTL:
    // Left side (end in RTL) has the rounded bulb hugging chocolate & milk.
    // Right side (start in RTL) has the tapered lobe supporting the cocoa powder mound.
    // Top center dips behind Omda's head.
    // Bottom scoops under Omda's feet.
    path.moveTo(w * 0.44, h * 0.28);

    // Toward right tapered lobe (start side)
    path.cubicTo(w * 0.58, h * 0.28, w * 0.74, h * 0.32, w * 0.88, h * 0.38);
    path.cubicTo(w * 0.98, h * 0.42, w * 1.00, h * 0.50, w * 0.95, h * 0.58);
    path.cubicTo(w * 0.88, h * 0.68, w * 0.74, h * 0.74, w * 0.58, h * 0.76);

    // Dip under Omda's feet in center-bottom
    path.cubicTo(w * 0.48, h * 0.78, w * 0.42, h * 0.88, w * 0.36, h * 0.88);

    // Left rounded bulb (end in RTL)
    path.cubicTo(w * 0.26, h * 0.88, w * 0.14, h * 0.82, w * 0.08, h * 0.68);
    path.cubicTo(w * 0.02, h * 0.58, w * 0.02, h * 0.42, w * 0.08, h * 0.32);

    // Top-left crest behind chocolate bar
    path.cubicTo(w * 0.14, h * 0.22, w * 0.26, h * 0.22, w * 0.36, h * 0.25);
    path.cubicTo(w * 0.40, h * 0.26, w * 0.42, h * 0.28, w * 0.44, h * 0.28);

    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _OrganicStoryBlobPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isRtl != isRtl;
  }
}