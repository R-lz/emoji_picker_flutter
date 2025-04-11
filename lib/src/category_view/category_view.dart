import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

/// Template class for custom implementation
/// Inhert this class to create your own Category view
abstract class CategoryView extends StatefulWidget {
  /// Constructor
  const CategoryView(
    this.config,
    this.state,
    this.tabController,
    this.pageController, {
    super.key,
  });

  /// Config for customizations
  final Config config;

  /// State that holds current emoji data
  final EmojiViewState state;

  /// TabController for Category view
  final TabController tabController;

  /// Page Controller of Emoji view
  final PageController pageController;
}

/// Returns the icon for the category
IconData getIconForCategory(CategoryIcons categoryIcons, Category category) {
  switch (category) {
    case Category.RECENT:
      return categoryIcons.recentIcon;
    case Category.SMILEYS:
      return categoryIcons.smileyIcon;
    case Category.ANIMALS:
      return categoryIcons.animalIcon;
    case Category.FOODS:
      return categoryIcons.foodIcon;
    case Category.ACTIVITIES:
      return categoryIcons.activityIcon;
    case Category.TRAVEL:
      return categoryIcons.travelIcon;
    case Category.OBJECTS:
      return categoryIcons.objectIcon;
    case Category.SYMBOLS:
      return categoryIcons.symbolIcon;
    case Category.FLAGS:
      return categoryIcons.flagIcon;
    case Category.CUSTOM_SMILEYS:
      return categoryIcons.customSmileyIcon;
    case Category.CUSTOM_PEOPLE:
      return categoryIcons.customPeopleIcon;
    case Category.CUSTOM_ANIMALS:
      return categoryIcons.customAnimalIcon;
    case Category.CUSTOM_FOOD:
      return categoryIcons.customFoodIcon;
    case Category.CUSTOM_TRAVEL:
      return categoryIcons.customTravelIcon;
    case Category.CUSTOM_ACTIVITIES:
      return categoryIcons.customActivityIcon;
    case Category.CUSTOM_OBJECTS:
      return categoryIcons.customObjectIcon;
    case Category.CUSTOM_SYMBOLS:
      return categoryIcons.customSymbolIcon;
  }
}

/// Template class for custom implementation
/// Inhert this class to create your own category view state
class CategoryViewState<T extends CategoryView> extends State<T>
    with SkinToneOverlayStateMixin {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('Category View implementation missing');
  }
}
