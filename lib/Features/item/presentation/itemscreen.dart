import 'package:flutter/material.dart';
import 'package:shamedan/Features/item/data/item_model.dart';
import 'package:shamedan/Features/item/data/item_repository.dart';
import 'package:shamedan/Features/item/presentation/widgets/character_story_section.dart';
import 'package:shamedan/Features/item/presentation/widgets/decorative_letters_section.dart';
import 'package:shamedan/Features/item/presentation/widgets/hero_section.dart';
import 'package:shamedan/Features/item/presentation/widgets/interactive_section.dart';
import 'package:shamedan/Features/item/presentation/widgets/item_footer_section.dart';
import 'package:shamedan/Features/item/presentation/widgets/timeline_section.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';
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
      appBar: const CustomAppBar(),
      backgroundColor: bgColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // 1. Hero Section (Header with pack & title)
              ItemHeroSection(item: item),

              // 2. Decorative background letters
              DecorativeLettersSection(item: item, waveColor: waveColor),

              // 3. Hero Character Story
              CharacterStorySection(item: item, waveColor: waveColor),

              const SizedBox(height: 24),

              // 4. Timeline ("خطوات الصنع")
              TimelineSection(item: item, waveColor: waveColor),

              const SizedBox(height: 32),

              // 5. Interactive / Mascot Section
              InteractiveSection(item: item, themeColor: themeColor),

              const SizedBox(height: 36),

              // 6. Footer Section
              ItemFooterSection(
                item: item,
                characters: _characters,
                footerColor: footerColor,
                footerTextColor: footerTextColor,
                onCharacterSelected: _loadData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}