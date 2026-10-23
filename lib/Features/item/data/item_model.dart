class ItemModel {
  final String id;
  final String name;
  final String slug;
  final String heroTitle;
  final String heroSubtitle;
  final List<String> heroPerks;
  final String heroLetters;
  final String characterId;
  final String characterName;
  final String characterImage;
  final String storyTitle;
  final String storyText;
  final String themeColor;
  final String backgroundColor;
  final String waveColor;
  final String cardColor;
  final String cardTextColor;
  final String footerColor;
  final String footerTextColor;
  final String timelineTitle;
  final String timelineSubtitle;
  final List<TimelineStepModel> timelineSteps;
  final List<ProductCardModel> productCards;
  final String gameTitle;
  final String gameSubtitle;
  final List<String> quizOptions;
  final String interactiveType;
  final String weight;
  final String category;

  const ItemModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.heroPerks,
    required this.heroLetters,
    required this.characterId,
    required this.characterName,
    required this.characterImage,
    required this.storyTitle,
    required this.storyText,
    required this.themeColor,
    required this.backgroundColor,
    required this.waveColor,
    required this.cardColor,
    required this.cardTextColor,
    required this.footerColor,
    required this.footerTextColor,
    required this.timelineTitle,
    required this.timelineSubtitle,
    required this.timelineSteps,
    required this.productCards,
    required this.gameTitle,
    required this.gameSubtitle,
    this.quizOptions = const [],
    required this.interactiveType,
    required this.weight,
    required this.category,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      heroTitle: json['heroTitle'] as String? ?? json['name'] as String,
      heroSubtitle: json['heroSubtitle'] as String? ?? '',
      heroPerks: json['heroPerks'] != null
          ? List<String>.from(json['heroPerks'] as List)
          : const [],
      heroLetters: json['heroLetters'] as String? ?? '',
      characterId: json['characterId'] as String,
      characterName: json['characterName'] as String? ?? '',
      characterImage: json['characterImage'] as String,
      storyTitle: json['storyTitle'] as String? ?? '',
      storyText: json['storyText'] as String? ?? '',
      themeColor: json['themeColor'] as String,
      backgroundColor: json['backgroundColor'] as String,
      waveColor: json['waveColor'] as String? ?? json['backgroundColor'] as String,
      cardColor: json['cardColor'] as String? ?? '#FFFFFF',
      cardTextColor: json['cardTextColor'] as String? ?? '#1A1A1A',
      footerColor: json['footerColor'] as String? ?? '#FAF6EF',
      footerTextColor: json['footerTextColor'] as String? ?? '#2A2A2A',
      timelineTitle: json['timelineTitle'] as String? ?? 'خطوات الصنع',
      timelineSubtitle: json['timelineSubtitle'] as String? ?? '',
      timelineSteps: (json['timelineSteps'] as List? ?? [])
          .map((e) => TimelineStepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productCards: (json['productCards'] as List? ?? [])
          .map((e) => ProductCardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      gameTitle: json['gameTitle'] as String? ?? '',
      gameSubtitle: json['gameSubtitle'] as String? ?? '',
      quizOptions: json['quizOptions'] != null
          ? List<String>.from(json['quizOptions'] as List)
          : const [],
      interactiveType: json['interactiveType'] as String? ?? 'character_intro',
      weight: json['weight'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }
}

class TimelineStepModel {
  final String title;
  final String subtitle;
  final String icon;

  const TimelineStepModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  factory TimelineStepModel.fromJson(Map<String, dynamic> json) {
    return TimelineStepModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      icon: json['icon'] as String,
    );
  }
}

class ProductCardModel {
  final String title;
  final String subtitle;
  final String image;

  const ProductCardModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  factory ProductCardModel.fromJson(Map<String, dynamic> json) {
    return ProductCardModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      image: json['image'] as String,
    );
  }
}

class CharacterModel {
  final String id;
  final String itemId;
  final String name;
  final String image;
  final String? cardImage;
  final String description;
  final String color;

  const CharacterModel({
    required this.id,
    required this.itemId,
    required this.name,
    required this.image,
    this.cardImage,
    required this.description,
    required this.color,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as String,
      itemId: json['itemId'] as String? ?? '1',
      name: json['name'] as String,
      image: json['image'] as String,
      cardImage: json['cardImage'] as String?,
      description: json['description'] as String,
      color: json['color'] as String,
    );
  }
}
