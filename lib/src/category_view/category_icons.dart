import 'package:flutter/material.dart';

/// Class used to define all the [CategoryIcon] shown for each [Category]
///
/// This allows the keyboard to be personalized by changing icons shown.
/// If a [CategoryIcon] is set as null or not defined during initialization,
/// the default icons will be used instead
class CategoryIcons {
  /// Constructor
  const CategoryIcons({
    this.recentIcon = Icons.access_time,
    this.smileyIcon = Icons.tag_faces,
    this.animalIcon = Icons.pets,
    this.foodIcon = Icons.fastfood,
    this.activityIcon = Icons.directions_run,
    this.travelIcon = Icons.location_city,
    this.objectIcon = Icons.lightbulb_outline,
    this.symbolIcon = Icons.emoji_symbols,
    this.flagIcon = Icons.flag,
    this.customSmileyIcon = Icons.tag_faces_outlined, // 与 SMILEYS 类似
    this.customPeopleIcon = Icons.person_outline, // 表示人群
    this.customAnimalIcon = Icons.pets_outlined, // 与 ANIMALS 类似
    this.customFoodIcon = Icons.fastfood_outlined, // 与 FOODS 类似
    this.customTravelIcon = Icons.location_on, // 与 TRAVEL 类似
    this.customActivityIcon = Icons.directions_run_outlined, // 与 ACTIVITIES 类似
    this.customObjectIcon = Icons.lightbulb, // 与 OBJECTS 类似
    this.customSymbolIcon = Icons.emoji_symbols_outlined, // 与 SYMBOLS 类似
  });

  /// Icon for [Category.RECENT]
  final IconData recentIcon;

  /// Icon for [Category.SMILEYS]
  final IconData smileyIcon;

  /// Icon for [Category.ANIMALS]
  final IconData animalIcon;

  /// Icon for [Category.FOODS]
  final IconData foodIcon;

  /// Icon for [Category.ACTIVITIES]
  final IconData activityIcon;

  /// Icon for [Category.TRAVEL]
  final IconData travelIcon;

  /// Icon for [Category.OBJECTS]
  final IconData objectIcon;

  /// Icon for [Category.SYMBOLS]
  final IconData symbolIcon;

  /// Icon for [Category.FLAGS]
  final IconData flagIcon;

  /// Icon for [Category.CUSTOM_SMILEYS]
  final IconData customSmileyIcon;

  /// Icon for [Category.CUSTOM_PEOPLE]
  final IconData customPeopleIcon;

  /// Icon for [Category.CUSTOM_ANIMALS]
  final IconData customAnimalIcon;

  /// Icon for [Category.CUSTOM_FOOD]
  final IconData customFoodIcon;

  /// Icon for [Category.CUSTOM_TRAVEL]
  final IconData customTravelIcon;

  /// Icon for [Category.CUSTOM_ACTIVITIES]
  final IconData customActivityIcon;

  /// Icon for [Category.CUSTOM_OBJECTS]
  final IconData customObjectIcon;

  /// Icon for [Category.CUSTOM_SYMBOLS]
  final IconData customSymbolIcon;
}
